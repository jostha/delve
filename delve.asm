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
; Zero page vars
;

player_x  = $10
player_y  = $11
target_x  = $12
target_y  = $13
tile_value = $14

row_lo = $fb
row_hi = $fc


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

    ldx    #y         ; row in x - yes really
    ldy    #xx        ; column in y wtf
    clc
    jsr    $fff0

	ldx	   #00

.print_loop
    lda    text,x
    beq    .print_end
    jsr    $ffd2
    inx
    bne    .print_loop ; loops until byte 0 encountered

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
    beq    .draw_tile_get_high

.draw_tile_get_low
    lda    (row_lo),y
    and    #$0f
    jmp    .draw_tile_got_tile

.draw_tile_get_high
    lda    (row_lo),y
    lsr
    lsr
    lsr
    lsr
    and    #$0f

.draw_tile_got_tile
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

    lda    #7
    sta    player_x
    lda    #8
    sta    player_y

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

