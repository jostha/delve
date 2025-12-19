;       Delve for the unexpanded Vic20
;       by jostha / John Halfpenny

* = $1001

;
; BASIC program to boot the machine language code
;

!byte    $0b, $10, $0a, $00, $9e, $34, $31, $30, $39, $00, $00, $00

    jmp   init


;------------------------------------------------
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


;------------------------------------------------
;
; Buffers
;

tile_char !byte 0,0


;------------------------------------------------
;
; MACROS
;

!macro print text, colour, xx, y {
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
    ; Compute target_x = player_x + dx
    lda    player_x
    clc
    adc    #dx
    sta    target_x

    ; Compute target_y = player_y + dy
    lda    player_y
    clc
    adc    #dy
    sta    target_y

;    ; Compute row pointer = dungeon + (y << 4)
;    Saving below in case lookup table uses too much RAM
;    ldy    target_y
;    tya
;    asl
;    asl
;    asl
;    asl
;    clc
;    adc    #<dungeon
;    sta    row_lo
;    lda    #>dungeon
;    adc    #0
;    sta    row_hi

    ; This section is lookup table code, can be removed if above
    ; used instead
    ldy    target_y
    lda    row_table_lo,y    ; low byte from table
    sta    row_lo
    lda    row_table_hi,y    ; high byte from table
    sta    row_hi

    ; Compute byte index = x >> 1
    lda     target_x
    lsr
    tay

    ; Extract nibble
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

    ; Convert tile_value → PETSCII
    lda    tile_value
    clc
    adc    #$30        ; '0'..'9'
    sta    tile_char

    lda    #0
    sta    tile_char+1  ; terminator

    ; Print using existing macro
    +print tile_char, 1, scrx, scry
}


;------------------------------------------------
; DATA

!source         "dungeonmap.asm"

; ------------------------------------------
; Generate lookup tables to save on the fly computation
; Will revert if I run out of RAM for this, so will leave
; the ASL code in the tile routine

row_table_lo
!for i, 0, 31 {
    !byte <(dungeon + (i * 16))
}

row_table_hi
!for i, 0, 31 {
    !byte >(dungeon + (i * 16))
}


;------------------------------------------------
; SUBROUTINES

read_keys
    ; Check W (Up)  → row 2, bit 1
    lda #%11111011      ; select row 2 (bit 2 = 0)
    sta $9120
    lda $9121
    and #%00000010      ; bit 1 = W
    beq key_up          ; 0 = pressed

    ; Check S (Down) → row 2, bit 2
    lda #%11111011
    sta $9120
    lda $9121
    and #%00000100      ; bit 2 = S
    beq key_down

    ; Check A (Left) → row 1, bit 2
    lda #%11111101      ; select row 1 (bit 1 = 0)
    sta $9120
    lda $9121
    and #%00000100      ; bit 2 = A
    beq key_left

    ; Check D (Right) → row 1, bit 1
    lda #%11111101
    sta $9120
    lda $9121
    and #%00000010      ; bit 1 = D
    beq key_right

    rts                 ; no key pressed

key_up
    dec player_y
    rts

key_down
    inc player_y
    rts

key_left
    dec player_x
    rts

key_right
    inc player_x
    rts

draw_dungeon
    +draw_tile -1, -1, 10, 5   ; NW
    +draw_tile  0, -1, 11, 5   ; N
    +draw_tile  1, -1, 12, 5   ; NE
    +draw_tile -1,  0, 10, 6   ; W
    +draw_tile  1,  0, 12, 6   ; E
    +draw_tile -1,  1, 10, 7   ; SW
    +draw_tile  0,  1, 11, 7   ; S
    +draw_tile  1,  1, 12, 7   ; SE
    rts


;------------------------------------------------
; CODE ENTRY

init

    lda    #$93
    jsr    $FFD2    ; cls

    ldx   #$08
    stx   $900f    ; borders to black

    lda    #7
    sta    player_x
    lda    #8
    sta    player_y

game_loop
    jsr read_keys
    jsr draw_dungeon
    jmp game_loop

freeze
	jmp     freeze

