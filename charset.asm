; -----------------------------------------------
; Define chars 47+

; 63 is the highest before screen ram so work down from
; there - $1c00 + (63 * 8) =
;         $1c00 + $1f8      = $1df8

* = $1c00 + (54 * 8)

; fountain              char54
fountain
    !byte %00010100
    !byte %00001001
    !byte %01000000
    !byte %00001000
    !byte %01111111
    !byte %00111110
    !byte %00001000
    !byte %00011100

; petr                  char55
petr
    !byte %00000000
    !byte %00011000
    !byte %00011000
    !byte %00011100
    !byte %00111110
    !byte %01011010
    !byte %00010000
    !byte %00100100

; petra                 char56
petra
    !byte %00000000
    !byte %00011000
    !byte %00011000
    !byte %00111100
    !byte %00111000
    !byte %01111000
    !byte %00011000
    !byte %00111100

; water lava ns         char57
water_lava_ns
    !byte %00111000
    !byte %00110000
    !byte %00110000
    !byte %00011000
    !byte %00011000
    !byte %00001100
    !byte %00011100
    !byte %00110000

; water_lava_ew         char58
water_lava_ew
    !byte %01100000
    !byte %11110000
    !byte %11011000
    !byte %00011000
    !byte %00110011
    !byte %01100111
    !byte %00111100
    !byte %00011000

; door_open             char59
door_open
    !byte %00011100
    !byte %00100010
    !byte %01000001
    !byte %01000101
    !byte %01000101
    !byte %01000101
    !byte %01000101
    !byte %01000101

; door_closed           char60
door_closed
    !byte %00011100
    !byte %00100010
    !byte %01000001
    !byte %01011101
    !byte %01011101
    !byte %01001101
    !byte %01011101
    !byte %01011101

; wall                   char61
wall
    !byte %00000000
    !byte %00111111
    !byte %01111111
    !byte %01111111
    !byte %01111101
    !byte %01111010
    !byte %01011110
    !byte %00011100

; hero                   char62
hero
    !byte %00011010
    !byte %00010010
    !byte %00011010
    !byte %01111110
    !byte %01111010
    !byte %00010100
    !byte %00100100
    !byte %00100100

; heart                  char63
heart
    !byte %01100110
    !byte %11111111
    !byte %10111111
    !byte %10111111
    !byte %01011110
    !byte %00111100
    !byte %00011000
    !byte %00000000
