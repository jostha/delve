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

dungeon             !byte $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB
                    !byte $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB
                    !byte $BB, $B0, $0B, $00,  $0B, $BB, $BB, $B0,  $0B, $00, $BB, $BB,  $BB, $BB, $BB, $BB
                    !byte $BB, $BB, $B3, $00,  $0B, $00, $BB, $BB,  $0B, $0B, $00, $00,  $00, $BB, $BB, $BB
                    !byte $BB, $B0, $0B, $B3,  $BB, $0B, $00, $0B,  $0B, $00, $0B, $00,  $B0, $BB, $0B, $BB
                    !byte $BB, $00, $03, $00,  $0B, $0B, $0B, $00,  $00, $0B, $B0, $B0,  $00, $BB, $3B, $BB
                    !byte $BB, $B0, $0B, $00,  $0B, $0B, $00, $B0,  $BB, $00, $00, $B0,  $BB, $00, $0B, $BB
                    !byte $BB, $BB, $BB, $00,  $BB, $0B, $BB, $00,  $00, $0B, $0B, $00,  $0B, $0B, $0B, $BB

                    !byte $BB, $B0, $BB, $BB,  $BB, $0B, $00, $0B,  $0B, $0B, $00, $0B,  $00, $0B, $0B, $BB
                    !byte $BB, $3B, $B0, $0B,  $BB, $0B, $0B, $B0,  $00, $0B, $BB, $00,  $0B, $B0, $0B, $BB
                    !byte $B0, $00, $30, $0B,  $BB, $0B, $00, $00,  $BB, $B0, $00, $B0,  $BB, $BB, $0B, $BB
                    !byte $B0, $00, $B0, $0B,  $00, $00, $0B, $00,  $00, $B0, $00, $BB,  $00, $00, $0B, $BB
                    !byte $BB, $0B, $BB, $BB,  $00, $B0, $BB, $0B,  $B0, $BB, $3B, $00,  $0B, $BB, $BB, $BB
                    !byte $BB, $00, $30, $03,  $0B, $00, $0B, $00,  $00, $0B, $0B, $00,  $0B, $03, $00, $BB
                    !byte $BB, $BB, $B0, $BB,  $BB, $0B, $00, $0B,  $0B, $0B, $0B, $00,  $BB, $0B, $00, $BB
                    !byte $BB, $B0, $0B, $03,  $0B, $00, $0B, $00,  $0B, $0B, $0B, $BB,  $00, $0B, $3B, $BB

                    !byte $BB, $B0, $00, $0B,  $00, $BB, $BB, $BB,  $B0, $00, $0B, $03,  $00, $0B, $00, $BB
                    !byte $BB, $BB, $BB, $BB,  $00, $B0, $00, $00,  $00, $BB, $BB, $0B,  $00, $0B, $00, $BB
                    !byte $BB, $BB, $0B, $03,  $00, $B0, $BB, $BB,  $BB, $B0, $30, $0B,  $BB, $BB, $BB, $BB
                    !byte $BB, $BB, $3B, $0B,  $00, $B0, $B0, $00,  $BB, $B0, $B3, $B0,  $00, $00, $BB, $BB
                    !byte $BB, $B0, $03, $0B,  $BB, $B0, $B0, $00,  $00, $00, $B0, $B0,  $B0, $B0, $BB, $BB
                    !byte $B0, $30, $0B, $BB,  $B0, $30, $B0, $00,  $BB, $B3, $B0, $B0,  $00, $00, $BB, $BB
                    !byte $BB, $B0, $03, $0B,  $BB, $B0, $BB, $0B,  $BB, $B0, $BB, $BB,  $0B, $0B, $BB, $BB
                    !byte $BB, $B0, $0B, $BB,  $B0, $00, $0B, $00,  $0B, $00, $03, $00,  $0B, $0B, $BB, $BB

                    !byte $B0, $30, $03, $0B,  $00, $BB, $BB, $BB,  $0B, $B0, $BB, $0B,  $B0, $0B, $BB, $BB
                    !byte $BB, $B3, $BB, $BB,  $B0, $B0, $00, $00,  $00, $B3, $BB, $BB,  $BB, $BB, $00, $0B
                    !byte $BB, $B0, $BB, $BB,  $00, $B0, $B0, $BB,  $BB, $B0, $BB, $00,  $00, $0B, $00, $0B
                    !byte $BB, $BB, $0B, $BB,  $0B, $B0, $00, $B0,  $00, $00, $00, $0B,  $00, $0B, $BB, $0B
                    !byte $B0, $00, $00, $0B,  $00, $00, $BB, $B0,  $BB, $B0, $BB, $0B,  $0B, $00, $00, $0B
                    !byte $BB, $B0, $00, $BB,  $BB, $B0, $BB, $00,  $BB, $B0, $BB, $00,  $00, $0B, $BB, $BB
                    !byte $BB, $00, $00, $B0,  $30, $00, $BB, $00,  $BB, $B0, $00, $BB,  $BB, $BB, $BB, $BB
                    !byte $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB,  $BB, $BB, $BB, $BB

