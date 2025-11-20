;       Delve
;       John Halfpenny 2025     

; Build with 
;       acme --cpu 6502 -f cbm -o outfile.prg infile.asm

* = $1001

; BASIC program to boot the machine language code
        !byte    $0b, $10, $0a, $00, $9e, $34, $31, $30, $39, $00, $00, $00


; 
;       dungeon data
;

* = $2000

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


level_1                 !byte %11111111
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
