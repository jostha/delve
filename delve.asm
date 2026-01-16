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
;               by johhn

;------------------------------------------------
; Get the high code loaded in first before
; coming back to start of RAM
!source "charset.asm"

* = $1001

; -----------------------------------------------
; BASIC program to boot the machine language code

!byte    $0b, $10, $0a, $00, $9e, $34, $31, $30, $39, $00, $00, $00

    jmp init

;------------------------------------------------
; STATIC DATA - Keep in low RAM area

!source "dungeonmap.asm"

;------------------------------------------------
; Zero page vars
; Stick to $00 to $0F or $45 to $50 range for safety
player_x     = $02
player_y     = $03
target_x     = $04
target_y     = $05
tile_value   = $06
tile_char    = $07

temp_colour     = $08        
temp_colour_hi  = $09        

row_lo = $fb
row_hi = $fc

;------------------------------------------------
; MACROS - to be replaced

!macro draw_tile dx, dy, scrx, scry, tile_colour {
    ; 1. Calculate Map Coordinates
    lda player_x
    clc
    adc #dx
    sta target_x
    lda player_y
    clc
    adc #dy
    sta target_y

    ; 2. Lookup Map Data (using your existing map table logic)
    ldy target_y
    lda row_table_lo, y
    sta row_lo
    lda row_table_hi, y
    sta row_hi

    lda target_x
    lsr
    tay                  ; Y is index into map byte (x/2)
    lda target_x
    and #1
    beq .get_high

    lda (row_lo), y      ; Get low nibble
    and #$0f
    jmp .got_tile
.get_high:
    lda (row_lo), y      ; Get high nibble
    lsr
    lsr
    lsr
    lsr
.got_tile:
    sta tile_value

    ; --- New Lookup Table Logic ---
    tax                  ; Move tile value (0-15) into X
    lda tile_to_char, x  ; Get actual PETSCII character from table
    sta tile_char        ; Store it for printing
    ; ------------------------------

    ;clc
    ;adc #$30             ; Convert 0-9 to PETSCII '0'-'9'
    ;sta tile_char        ; We only need the first byte now

    ; 3. Prepare for Subroutine
    ; If scrx > 30, we just wanted the tile_value, so skip printing
    ldx #scrx
    cpx #31
    bcs .skip_print

    lda #tile_colour
    sta temp_colour
    
    lda tile_char        ; Restore character to A
    ldx #scry            ; X = Row
    ldy #scrx            ; Y = Column
    jsr fast_print

.skip_print:
}

; ------------------------------------------
; LOOKUP TABLES

; Save on the fly computation
; Will revert to on the fly if I run out of RAM 
row_table_lo:
!for i, 0, 31 {
    !byte <(dungeon + (i * 16))
}

row_table_hi:
!for i, 0, 31 {
    !byte >(dungeon + (i * 16))
}

; Screen RAM starts at $1000 for unexpanded VIC-20
; Each row is 22 characters wide
screen_lo:
!for i, 0, 22 {
    !byte <($1e00 + (i * 22))
}

screen_hi:
!for i, 0, 22 {
    !byte >($1e00 + (i * 22))
}

; Map number to printable character table
tile_to_char:
    !byte 00   ;floor
    !byte 00   ;gradd
    !byte 00   ;lava
    !byte 59   ;door unlocked
    !byte 00   ;shallow water
    !byte 00   ;hidden passage
    !byte 54   ;fountain (health +1)
    !byte 00   ;teleportation (goes somewhere random)
    !byte 00   ;key (changes to 0 once touched, keys + 1)
    !byte 00   ;Petr / Petra (randomly chosen) - game won if touched
    !byte 00   ;Time spell (adds 20 seconds to time)
    !byte 61   ;wall
    !byte 60   ;locked Door (Changes to 3 if touched with a key)
    !byte 00   ;deep water
    !byte 00   ;monster
    !byte 00   ;blank

;------------------------------------------------
; SUBROUTINES

fast_print:
    ; Prints direct to screen without using kernal routine
    ;   A = Character (PETSCII)
    ;   X = Screen Row (0-22)
    ;   Y = Screen Column (0-21)
    ;   temp_colour = Hardware Color (0-7)

    pha                  ; [1] Save character to stack

    lda screen_lo, x     ; Get row address from lookup table
    sta row_lo           ; row_lo/hi MUST be safe ZP (e.g., $FB/$FC)
    lda screen_hi, x
    sta row_hi           ; row_lo/hi now points to SCREEN RAM ($1E00)

    pla                  ; [2] Restore character from stack
    sta (row_lo), y      ; Write character to the screen

    ; --- Switch pointer to Colour RAM ---
    lda row_hi
    clc
    adc #$78             ; $1E (Screen) + $78 = $96 (Color RAM)
    sta row_hi           ; row_lo/hi now points to COLOR RAM ($9600)

    lda temp_colour
    and #$07             ; [3] CRITICAL: Keep only bits 0-2 (Colors 0-7)
                         ; This prevents bit 3 (Multicolor) from being set
    sta (row_lo), y      ; Write color to Color RAM
    
    rts


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

; MOVEMENT
key_up_handler:
    +draw_tile 0, -1, 255, 255, 0
    lda tile_value
    cmp #11
    bcs .blocked_up
    dec player_y
.blocked_up:
    rts

key_down_handler:
    +draw_tile 0, 1, 255, 255, 0
    lda tile_value
    cmp #11
    bcs .blocked_down
    inc player_y
.blocked_down:
    rts

key_left_handler:
    +draw_tile -1, 0, 255, 255, 0
    lda tile_value
    cmp #11
    bcs .blocked_left
    dec player_x
.blocked_left:
    rts

key_right_handler:
    +draw_tile 1, 0, 255, 255, 0
    lda tile_value
    cmp #11
    bcs .blocked_right
    inc player_x
.blocked_right:
    rts

draw_dungeon:
   ; 5x5 core grid
    +draw_tile -2, -2,  9, 10, 7  ; row 1
    +draw_tile -1, -2, 10, 10, 7
    +draw_tile  0, -2, 11, 10, 7
    +draw_tile  1, -2, 12, 10, 7
    +draw_tile  2, -2, 13, 10, 7

    +draw_tile -2, -1,  9, 11, 2  ; row 2
    +draw_tile -1, -1, 10, 11, 4
    +draw_tile  0, -1, 11, 11, 4
    +draw_tile  1, -1, 12, 11, 4
    +draw_tile  2, -1, 13, 11, 2

    +draw_tile -2,  0,  9, 12, 3  ; row 3 (player row)
    +draw_tile -1,  0, 10, 12, 4
    ; player at 11, 12
    +draw_tile  1,  0, 12, 12, 4
    +draw_tile  2,  0, 13, 12, 3 

    +draw_tile -2,  1,  9, 13, 5  ; row 4
    +draw_tile -1,  1, 10, 13, 4
    +draw_tile  0,  1, 11, 13, 4
    +draw_tile  1,  1, 12, 13, 4
    +draw_tile  2,  1, 13, 13, 5

    +draw_tile -2,  2,  9, 14, 7  ; row 5
    +draw_tile -1,  2, 10, 14, 7
    +draw_tile  0,  2, 11, 14, 7
    +draw_tile  1,  2, 12, 14, 7
    +draw_tile  2,  2, 13, 14, 7

    ; Test compass one at a time - comment out the crashing ones
    ;+draw_tile  0, -3, 11,  9, 5  ; North
    ;+draw_tile  0,  3, 11, 15, 5  ; South (works)
    ;+draw_tile -3,  0,  8, 12, 5  ; West
    ;+draw_tile  3,  0, 14, 12, 5  ; East

    rts

;------------------------------------------------
; CODE ENTRY POINT

init:

    lda #$93
    jsr $ffd2    ; cls

    ; -----------------------------------------------
    ; Set VIC char base to $1C00 (block 3) for custom charset
    ; stored in charset.asm

    lda $9005
    and #%11110000           ; clear bits 1-4
    ora #%00001111           ; set bits 1-4 > $1c00
    sta $9005

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

    ; Draw the hero after everything else is on screen
    lda #3
    sta temp_colour
    lda #62              ; Print the hero
    ldx #12              ;
    ldy #11              ;
    jsr fast_print

    jmp game_loop


;Black	144	$90	CTRL + 1
;White	5	$05	CTRL + 2
;Red	28	$1C	CTRL + 3
;Cyan	159	$9F	CTRL + 4
;Purple	156	$9C	CTRL + 5
;Green	30	$1E	CTRL + 6
;Blue	31	$1F	CTRL + 7
;Yellow	158	$9E	CTRL + 8
