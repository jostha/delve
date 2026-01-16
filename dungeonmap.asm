; 
;       dungeon data
;

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

; dungeon is 32x32  (16/32)

dungeon             !byte $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC
                    !byte $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC
                    !byte $CC, $C0, $0C, $00,  $0C, $CC, $CC, $C0,  $0C, $00, $CC, $CC,  $CC, $CC, $CC, $CC
                    !byte $CC, $CC, $C3, $00,  $0C, $00, $CC, $CC,  $0C, $0C, $00, $00,  $00, $CC, $CC, $CC
                    !byte $CC, $C0, $0C, $C3,  $CC, $0C, $00, $0C,  $0C, $00, $0C, $00,  $C0, $CC, $0C, $CC
                    !byte $CC, $00, $03, $00,  $0C, $0C, $0C, $00,  $00, $0C, $C0, $C0,  $00, $CC, $3C, $CC
                    !byte $CC, $C0, $0C, $00,  $0C, $0C, $00, $C0,  $CC, $00, $00, $C0,  $CC, $00, $0C, $CC
                    !byte $CC, $CC, $CC, $00,  $CC, $0C, $CC, $00,  $00, $0C, $0C, $00,  $0C, $0C, $0C, $CC

                    !byte $CC, $C0, $CC, $CC,  $CC, $0C, $00, $0C,  $0C, $0C, $00, $0C,  $00, $0C, $0C, $CC
                    !byte $CC, $3C, $C0, $0C,  $CC, $0C, $0C, $C0,  $00, $0C, $CC, $00,  $0C, $C0, $0C, $CC
                    !byte $C0, $00, $30, $0C,  $CC, $0C, $00, $00,  $CC, $C0, $00, $C0,  $CC, $CC, $0C, $CC
                    !byte $C0, $00, $C0, $0C,  $00, $00, $0C, $00,  $00, $C0, $00, $CC,  $00, $00, $0C, $CC
                    !byte $CC, $0C, $CC, $CC,  $00, $C0, $CC, $0C,  $C0, $CC, $3C, $00,  $0C, $CC, $CC, $CC
                    !byte $CC, $00, $30, $03,  $0C, $00, $0C, $00,  $00, $0C, $0C, $00,  $0C, $03, $00, $CC
                    !byte $CC, $CC, $C0, $CC,  $CC, $0C, $00, $0C,  $0C, $0C, $0C, $00,  $CC, $0C, $00, $CC
                    !byte $CC, $C0, $0C, $03,  $0C, $00, $0C, $00,  $0C, $0C, $0C, $CC,  $00, $0C, $3C, $CC

                    !byte $CC, $C0, $00, $0C,  $00, $CC, $CC, $CC,  $C0, $00, $0C, $03,  $00, $0C, $00, $CC
                    !byte $CC, $CC, $CC, $CC,  $00, $C0, $00, $00,  $00, $CC, $CC, $0C,  $00, $0C, $00, $CC
                    !byte $CC, $CC, $0C, $03,  $00, $C0, $CC, $CC,  $CC, $C0, $30, $0C,  $CC, $CC, $CC, $CC
                    !byte $CC, $CC, $3C, $0C,  $00, $C0, $C0, $00,  $CC, $C0, $C3, $C0,  $00, $00, $CC, $CC
                    !byte $CC, $C0, $03, $0C,  $CC, $C0, $C0, $00,  $00, $00, $C0, $C0,  $C0, $C0, $CC, $CC
                    !byte $C0, $30, $0C, $CC,  $C0, $30, $C0, $06,  $CC, $C3, $C0, $C0,  $00, $00, $CC, $CC
                    !byte $CC, $C0, $03, $0C,  $CC, $C0, $CC, $0C,  $CC, $C0, $CC, $CC,  $0C, $0C, $CC, $CC
                    !byte $CC, $C0, $0C, $CC,  $C0, $00, $0C, $00,  $0C, $00, $03, $00,  $0C, $0C, $CC, $CC

                    !byte $C0, $30, $03, $0C,  $00, $CC, $CC, $CC,  $0C, $C0, $CC, $0C,  $C0, $0C, $CC, $CC
                    !byte $CC, $C3, $CC, $CC,  $C0, $C0, $00, $00,  $00, $C3, $CC, $CC,  $CC, $CC, $00, $0C
                    !byte $CC, $C0, $CC, $CC,  $00, $C0, $C0, $CC,  $CC, $C0, $CC, $00,  $00, $0C, $00, $0C
                    !byte $CC, $CC, $0C, $CC,  $0C, $C0, $00, $C0,  $00, $00, $00, $0C,  $00, $0C, $CC, $0C
                    !byte $C0, $00, $00, $0C,  $00, $00, $CC, $C0,  $CC, $C0, $CC, $0C,  $0C, $00, $00, $0C
                    !byte $CC, $C0, $00, $CC,  $CC, $C0, $CC, $00,  $CC, $C0, $CC, $00,  $00, $0C, $CC, $CC
                    !byte $CC, $00, $00, $C0,  $30, $00, $CC, $00,  $CC, $C0, $00, $CC,  $CC, $CC, $CC, $CC
                    !byte $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC,  $CC, $CC, $CC, $CC

