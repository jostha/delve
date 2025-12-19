;       Delve for the unexpanded Vic20
;       by jostha / John Halfpenny

* = $1001

;
; BASIC program to boot the machine language code
;

!byte    $0b, $10, $0a, $00, $9e, $34, $31, $30, $39, $00, $00, $00

    lda    #$93
    jsr    $FFD2    ; cls

    ldx   #$08
    stx   $900f    ; borders to black
    jmp   init

;
; Zero page
;
;TBD


;
; Vars
;

player_x = 4
player_y = 16

row_lo   = 0
row_hi   = 0

target_x = 0
target_y = 0

tile_value = 0


;
; Buffers
;

tile_char !byte 0,0


;
; MACROS
;

!macro print text, colour, xx, y {
; print at a given x,y
    lda    #colour
    jsr    $ffd2           ; set text colour

    ; Set cursor position to x and y
    ; This is wacky...

    ; Row first...
    lda    #y
    sta    $D6     ; cursor row

    ; ...call plot routine to update internal machinations...
    jsr     $FFF0  ; Vic 20 plot routine (erases $D3)

    ; ...set column as plot routine erases it
    lda    #xx
    sta    $D3     ; cursor column

	ldx	#00
    jsr	   .print_start
    jmp    .print_end

.print_loop
    jsr    $ffd2
    inx

.print_start
    lda    text,x
    cpx    #$05
    bne    .print_loop ; loops until byte 0 encountered
    rts

.print_end
}


!macro draw_tile dx, dy, scrx, scry {
    ;---------------------------------------
    ; Compute target_x = player_x + dx
    ;---------------------------------------
    lda    player_x
    clc
    adc    #dx
    sta    target_x

    ;---------------------------------------
    ; Compute target_y = player_y + dy
    ;---------------------------------------
    lda    player_y
    clc
    adc    #dy
    sta    target_y

    ;---------------------------------------
    ; Compute row pointer = dungeon + (y << 4)
    ;---------------------------------------
    ldy    target_y
    tya
    asl
    asl
    asl
    asl
    clc
    adc    #<dungeon
    sta    row_lo
    lda    #>dungeon
    adc    #0
    sta    row_hi

    ;---------------------------------------
    ; Compute byte index = x >> 1
    ;---------------------------------------
    lda     target_x
    lsr
    tay

    ;---------------------------------------
    ; Extract nibble
    ;---------------------------------------
    lda    target_x
    and    #1
    beq    .get_high

.get_low
    lda    (row_lo),y
    and    #$0f
    jmp    .got_tile

.get_high
    lda    (row_lo),y
    lsr
    lsr
    lsr
    lsr
    and    #$0f

.got_tile
    sta    tile_value

    ;---------------------------------------
    ; Convert tile_value → PETSCII
    ;---------------------------------------
    lda    tile_value
    clc
    adc    #$30        ; '0'..'9'
    sta    tile_char

    lda    #0
    sta    tile_char+1  ; terminator

    ;---------------------------------------
    ; Print using existing macro
    ;---------------------------------------
    +print tile_char, 1, scrx, scry
}


;
; DATA
;
!source         "dungeonmap.asm"


;
; CODE ENTRY
;

init

+draw_tile -1, -1, 10, 5   ; NW
+draw_tile  0, -1, 11, 5   ; N
+draw_tile  1, -1, 12, 5   ; NE
+draw_tile -1,  0, 10, 6   ; W
+draw_tile  1,  0, 12, 6   ; E
+draw_tile -1,  1, 10, 7   ; SW
+draw_tile  0,  1, 11, 7   ; S
+draw_tile  1,  1, 12, 7   ; SE

freeze
	jmp     freeze

