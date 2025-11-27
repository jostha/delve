;       Delve
;       John Halfpenny 2025     

; Build with 
;       acme --cpu 6502 -f cbm -o outfile.prg infile.asm

* = $1001

; BASIC program to boot the machine language code
        !byte    $0b, $10, $0a, $00, $9e, $34, $31, $30, $39, $00, $00, $00

; Colour codes
black           = $00
white           = $01
red             = $02
cyan            = $03
purple          = $04
green           = $05
blue            = $06
yellow          = $07
orange          = $08
light_orange    = $09
light_red       = $0A
light_cyan      = $0B
light_purple    = $0C
light_green     = $0D
light_bluegreen = $0E
light_yellow    = $0F

; Some startup values
hero_map_x      = 1
hero_map_y      = 4
hero_screen_x   = 11
hero_screen_y   = 12
map_width       = 32
screen_width    = 22

; -------------------------------------------------
; Zero-page scratch
; -------------------------------------------------
;tmp     = $f9        ; 1-byte scratch
;map_off = $fa        ; 1-byte scratch for dungeon offset
;scr_off = $fb        ; 1-byte scratch for screen offset
;screen_ptr = $fc
;colour_ptr = $fe

mask            = $f6    ; scratch byte for bit mask
screen_ptr      = $fb    ; 2 bytes: $fb/$fc → base address for screen RAM
colour_ptr      = $fd    ; 2 bytes: $fd/$fe → base address for colour RAM
scr_row         = $f7    ; 1 byte scratch: screen row
scr_col         = $f8    ; 1 byte scratch: screen column
tmp             = $f9    ; 1 byte scratch: general temporary

; Addresses
SCREEN_BASE     = $1e00
COLOR_BASE      = $9600

init
        jsr     $e55f                   ; cls and home cursor
        ldx     #$08
        stx     $900f                   ; borders to black

        ; set screen and colour base pointers
        lda     #<SCREEN_BASE
        sta     screen_ptr
        lda     #>SCREEN_BASE
        sta     screen_ptr+1

        lda     #<COLOR_BASE
        sta     colour_ptr
        lda     #>COLOR_BASE
        sta     colour_ptr+1

update_screen

draw_hero
        lda     #81                     ; ball shape
        sta     SCREEN_BASE + (hero_screen_y * screen_width + hero_screen_x)
        lda     #cyan
        sta     COLOR_BASE + (hero_screen_y * screen_width + hero_screen_x)

draw_surround_1_deep

        ; NW
        ldy #hero_map_y-1
        ldx #hero_map_x-1
        lda #hero_screen_y-1
        sta scr_row
        lda #hero_screen_x-1
        sta scr_col
        jsr check_and_draw

        ; N
        ldy #hero_map_y-1
        ldx #hero_map_x
        lda #hero_screen_y-1
        sta scr_row
        lda #hero_screen_x
        sta scr_col
        jsr check_and_draw

        ; NE
        ldy #hero_map_y-1
        ldx #hero_map_x+1
        lda #hero_screen_y-1
        sta scr_row
        lda #hero_screen_x+1
        sta scr_col
        jsr check_and_draw

        rts

; -------------------------------------------------
; Subroutine: check_and_draw
; Inputs:
;   Y = map_row
;   X = map_col
;   scr_row/$f7 and scr_col/$f8 are set by caller
; -------------------------------------------------
check_and_draw
; --- compute byte index = row*4 + (col >> 3) ---
tya
asl
asl
sta tmp              ; tmp = row*4

txa
pha                  ; save col
lsr
lsr
lsr                  ; col >> 3
clc
adc tmp
tax                  ; X = byte index

; --- compute mask = $80 >> (col & 7) ---
pla
and #$07             ; keep low 3 bits
tay                  ; Y = bit index
lda #$80
shift_mask:
dey
bmi mask_done
lsr
bpl shift_mask
mask_done:
sta mask             ; save mask

; --- test bit ---
lda dungeon,x
and mask
beq skip_draw


        ; --- compute screen offset = scr_row*22 + scr_col ---
        lda scr_row
        asl
        asl
        sta tmp          ; row*4

        lda scr_row
        clc
        adc tmp          ; row*5
        asl              ; ×10
        sta tmp

        lda scr_row
        clc
        adc tmp          ; row*11
        asl              ; ×22
        sta tmp          ; row*22

        lda tmp          ; row*22
        clc
        adc scr_col      ; + column
        tay              ; final screen offset in Y

        ; --- draw fuzzy wall ---
        lda #102
        sta (screen_ptr),y
        lda #yellow
        sta (colour_ptr),y

skip_draw:
        rts
; 
;       dungeon data
;

; * = $1100

; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
; XXX  X   XXXXXX  X  XXXXXXXXXXXX
; X        X   XXX X X      XXXXXX
; XXX  XX XX X   X X   X  X X  XXX
; X        X   X     XX X   XX XXX
; XXX  X   X X  X XX    X XX   XXX
; XXXXXX  XX XXX     X X   X X XXX
; XX XXXXXXX X   X X X   X   X XXX
; XX XX  XXX X XX    XXX   XX  XXX
; X      XXX X    XXX   X XXXX XXX
; X   X  X     X    X   XX     XXX
; XX XXXXX  X XX XX XX X   XXXXXXX
; XX       X   X     X X   X    XX
; XXXXX XXXX X   X X X X  XX X  XX
; XXX  X   X   X   X X XXX   X XXX
; XXX    X  XXXXXXX    X     X  XX
; XXXXXXXX  X       XXXX X   X  XX
; XXXX X    X XXXXXXX    XXXXXXXXX
; XXXX X X  X X   XXX X X     XXXX
; XXX    XXXX X       X X X X XXXX
; X    XXXX   X   XXX X X     XXXX
; XXX    XXXX XX XXXX XX X X XXXXX
; XXX  XXXX    X   X       X XXXXX
; X      X  XXXXXX XX XX XX  XXXXX
; XXX XXXXX X       X XXXXXXXX   X
; XXX XXXX  X X XXXXX XX     X   X
; XXXX XXX XX   X        X   XXX X
; X      X    XXX XXX XX   X     X
; XXX   XXXXX XX  XXX XX     XXXXX
; XX    X     XX  XXX   XXXXXXXXXX
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


dungeon                 !byte %11111111
                        !byte %11111111
                        !byte %11111111
                        !byte %11111111

                        !byte %11111111
                        !byte %11111111
                        !byte %11111111
                        !byte %11111111

                        !byte %11100100
                        !byte %01111110
                        !byte %01001111
                        !byte %11111111

                        !byte %10000000
                        !byte %01000111
                        !byte %01010000
                        !byte %00111111

                        !byte %11100110
                        !byte %11010001
                        !byte %01000100
                        !byte %10100111

                        !byte %10000000
                        !byte %01000100
                        !byte %00011010
                        !byte %00110111

                        !byte %11100100
                        !byte %01010010
                        !byte %11000010
                        !byte %11000111

                        !byte %11111100
                        !byte %11011100
                        !byte %00010100
                        !byte %01010111

                        !byte %11011111
                        !byte %11010001
                        !byte %01010001
                        !byte %00010111

                        !byte %11011001
                        !byte %11010110
                        !byte %00011100
                        !byte %01100111

                        !byte %10000001
                        !byte %11010000
                        !byte %11100010
                        !byte %11110111

                        !byte %10001001
                        !byte %00000100
                        !byte %00100011
                        !byte %00000111

                        !byte %11011111
                        !byte %00101101
                        !byte %10110100
                        !byte %01111111

                        !byte %11000000
                        !byte %01000100
                        !byte %00010100
                        !byte %01000011

                        !byte %11111011
                        !byte %11010001
                        !byte %01010100
                        !byte %11010011

                        !byte %11100100
                        !byte %01000100
                        !byte %01010111
                        !byte %00010111

                        !byte %11100001
                        !byte %00111111
                        !byte %10000100
                        !byte %00010011

                        !byte %11111111
                        !byte %00100000
                        !byte %00111101
                        !byte %00010011

                        !byte %11110100
                        !byte %00101111
                        !byte %11100001
                        !byte %11111111

                        !byte %11110101
                        !byte %00101000
                        !byte %11101010
                        !byte %00001111

                        !byte %11100001
                        !byte %11101000
                        !byte %00001010
                        !byte %10101111

                        !byte %10000111
                        !byte %10001000
                        !byte %11101010
                        !byte %00001111

                        !byte %11100001
                        !byte %11101101
                        !byte %11101101
                        !byte %01011111

                        !byte %11100111
                        !byte %10000100
                        !byte %01000000
                        !byte %01011111

                        !byte %10000001
                        !byte %00111111
                        !byte %01101101
                        !byte %10011111

                        !byte %11101111
                        !byte %10100000
                        !byte %00101111
                        !byte %11110001

                        !byte %11101111
                        !byte %00101011
                        !byte %11101100
                        !byte %00010001

                        !byte %11110111
                        !byte %01100010
                        !byte %00000001
                        !byte %00011101

                        !byte %10000001
                        !byte %00001110
                        !byte %11101100
                        !byte %01000001

                        !byte %11100011
                        !byte %11101100
                        !byte %11101100
                        !byte %00011111

                        !byte %11000010
                        !byte %00001100
                        !byte %11100011
                        !byte %11111111

                        !byte %11111111
                        !byte %11111111
                        !byte %11111111
                        !byte %11111111
