; ▓█████▄ ▓█████  ██▓  ██▒   █▓▓█████
; ▒██▀ ██▌▓█   ▀ ▓██▒ ▓██░   █▒▓█   ▀
; ░██   █▌▒███   ▒██░  ▓██  █▒░▒███
; ░▓█▄   ▌▒▓█  ▄ ▒██░   ▒██ █░░▒▓█  ▄
; ░▒████▓ ░▒████▒░██████▒▒▀█░  ░▒████▒
;  ▒▒▓  ▒ ░░ ▒░ ░░ ▒░▓  ░░ ▐░  ░░ ▒░ ░
;  ░ ▒  ▒  ░ ░  ░░ ░ ▒  ░░ ░░   ░ ░  ░
;  ░ ░  ░    ░     ░ ░     ░░     ░
;    ░       ░  ░    ░  ░   ░     ░  ░
;  ░                       ░
;       for the unexpanded Vic20
;              by  wroob

* = $1001

; -----------------------------------------------
; BASIC program to boot the machine language code

!byte    $0b, $10, $0a, $00, $9e, $34, $31, $30, $39, $00, $00, $00

    jmp   init


;------------------------------------------------
; Zero page vars

player_x  = $10
player_y  = $11
target_x  = $12
target_y  = $13
tile_value = $14

row_lo = $fb
row_hi = $fc


;------------------------------------------------
; Buffers

tile_char !byte 0,0


;------------------------------------------------
; MACROS

!macro print text, colour, xx, y {
    lda #colour
    jsr $ffd2           ; set text colour

    ; Set cursor position to x and y

    ldx #y         ; row in x - yes really
    ldy #xx        ; column in y wtf
    clc
    jsr $fff0

	ldx	#00

.print_loop
    lda text,x
    beq .print_end
    jsr $ffd2
    inx
    bne .print_loop ; loops until byte 0 encountered

.print_end
}


!macro draw_tile dx, dy, scrx, scry {
    ; Specify scrx of > 30 to skip printing result if you just
    ; want to check the target tile is passable

    ; Compute target_x = player_x + dx
    lda player_x
    clc
    adc #dx
    sta target_x

    ; Compute target_y = player_y + dy
    lda player_y
    clc
    adc #dy
    sta target_y

    ; lookup table code
    ldy target_y
    lda row_table_lo,y    ; low byte from table
    sta row_lo
    lda row_table_hi,y    ; high byte from table
    sta row_hi

    ; Compute byte index = x >> 1
    lda target_x
    lsr
    tay

    ; Extract nibble
    lda target_x
    and #1
    beq .draw_tile_get_high

.draw_tile_get_low
    lda (row_lo),y
    and #$0f
    jmp .draw_tile_got_tile

.draw_tile_get_high
    lda (row_lo),y
    lsr
    lsr
    lsr
    lsr
    and #$0f

.draw_tile_got_tile
    sta tile_value

    ; Convert tile_value → PETSCII
    lda tile_value
    clc
    adc #$30        ; '0'..'9'
    sta tile_char

    lda #0
    sta tile_char+1  ; terminator

    ; Only print using existing macro if scrx < 30
    ; otherwise presume we are reusing this macro just to determine
    ; the target tile to see if it's passable or not
    lda #scrx
    cmp #31
    bcs .draw_tile_skip_print
    +print tile_char, 1, scrx, scry

.draw_tile_skip_print
}


;------------------------------------------------
; DATA

!source         "dungeonmap.asm"

; ------------------------------------------
; Generate lookup tables to save on the fly computation
; Will revert if I run out of RAM for this, so will leave
; the ASL code in the tile routine

row_table_lo:
!for i, 0, 31 {
    !byte <(dungeon + (i * 16))
}

row_table_hi:
!for i, 0, 31 {
    !byte >(dungeon + (i * 16))
}


;------------------------------------------------
; SUBROUTINES

read_keys:
    jsr $ffe4           ; GETIN - returns key in A
    beq .done           ; If 0, no key pressed

    ; Check for W (up) - PETSCII $57 or $77
    cmp #$57            ; uppercase W
    beq .key_up

    ; Check for A (left) - PETSCII $41 or $61
    cmp #$41            ; uppercase A
    beq .key_left

    ; Check for S (down) - PETSCII $53 or $73
    cmp #$53            ; uppercase S
    beq .key_down

    ; Check for D (right) - PETSCII $44 or $64
    cmp #$44            ; uppercase D
    beq .key_right

.done
    rts

.key_up:
    jsr key_up_handler
    rts

.key_left:
    jsr key_left_handler
    rts

.key_down:
    jsr key_down_handler
    rts

.key_right:
    jsr key_right_handler
    rts

; --- Movement Subroutines ---
; We move the macro calls here. Since these are called via JSR,
; they can be anywhere in your code!

key_up_handler:
    +draw_tile 0, -1, 255, 255
    lda tile_value
    cmp #11
    bcs .blocked_up
    dec player_y
.blocked_up:
    rts

key_down_handler:
    +draw_tile 0, 1, 255, 255
    lda tile_value
    cmp #11
    bcs .blocked_down
    inc player_y
.blocked_down:
    rts

key_left_handler:
    +draw_tile -1, 0, 255, 255
    lda tile_value
    cmp #11
    bcs .blocked_left
    dec player_x
.blocked_left:
    rts

key_right_handler:
    +draw_tile 1, 0, 255, 255
    lda tile_value
    cmp #11
    bcs .blocked_right
    inc player_x
.blocked_right:
    rts

draw_dungeon:
    +draw_tile -1, -1, 10, 11  ; NW
    +draw_tile  0, -1, 11, 11  ; N
    +draw_tile  1, -1, 12, 11  ; NE
    +draw_tile -1,  0, 10, 12  ; W
    +draw_tile  1,  0, 12, 12  ; E
    +draw_tile -1,  1, 10, 13  ; SW
    +draw_tile  0,  1, 11, 13  ; S
    +draw_tile  1,  1, 12, 13  ; SE
    rts


;------------------------------------------------
; CODE ENTRY

init:

    lda #$93
    jsr $ffd2    ; cls

    ldx #$08
    stx $900f    ; borders to black

    lda #14
    sta player_x
    lda #20
    sta player_y

game_loop:
    ; Wait for screen to finish drawing
    lda $9004
.wait_v:
    cmp $9004
    beq .wait_v

    jsr read_keys
    jsr draw_dungeon
    jmp game_loop


