
; ----------------------------------------------------------------
; character matrix: 8 x 10
; 10 bytes for each character
;
; the table contains characters (#32 to #126)
; the first 32 characters are "ASCII control characters"
; ----------------------------------------------------------------

fontdata:
.db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0                ; SPACE
.db 0, 0, 64, 64, 64, 64, 0, 0, 64, 0           ; !
.db 0, 40, 40, 40, 0, 0, 0, 0, 0, 0             ; "
.db 0, 0, 40, 40, 124, 40, 124, 40, 40, 0       ; #
.db 0, 0, 16, 56, 80, 56, 20, 20, 56, 16        ; $
.db 0, 0, 0, 68, 8, 16, 32, 68, 0, 0            ; %
.db 0, 0, 48, 72, 72, 48, 84, 72, 52, 0         ; &
.db 0, 32, 32, 32, 0, 0, 0, 0, 0, 0             ; '
.db 0, 4, 8, 8, 8, 8, 8, 8, 8, 4                ; (
.db 0, 32, 16, 16, 16, 16, 16, 16, 16, 32       ; )
.db 0, 0, 0, 0, 40, 16, 16, 40, 0, 0            ; *
.db 0, 0, 0, 0, 16, 56, 16, 0, 0, 0             ; +
.db 0, 0, 0, 0, 0, 0, 0, 0, 64, 64              ; ,
.db 0, 0, 0, 0, 0, 56, 0, 0, 0, 0               ; -
.db 0, 0, 0, 0, 0, 0, 0, 0, 64, 0               ; .
.db 0, 6, 12, 12, 24, 24, 48, 48, 96, 0         ; /
.db 0, 24, 36, 36, 52, 44, 36, 36, 24, 0        ; 0
.db 0, 8, 24, 8, 8, 8, 8, 8, 28, 0              ; 1
.db 0, 24, 36, 4, 4, 8, 16, 32, 60, 0           ; 2
.db 0, 24, 36, 4, 4, 8, 4, 36, 24, 0            ; 3
.db 0, 4, 12, 20, 36, 60, 4, 4, 4, 0            ; 4
.db 0, 56, 32, 32, 56, 4, 4, 36, 24, 0          ; 5
.db 0, 24, 32, 32, 56, 36, 36, 36, 24, 0        ; 6
.db 0, 56, 4, 4, 4, 8, 8, 16, 16, 0             ; 7
.db 0, 24, 36, 36, 24, 36, 36, 36, 24, 0        ; 8
.db 0, 24, 36, 36, 36, 28, 4, 4, 24, 0          ; 9
.db 0, 0, 0, 0, 0, 64, 0, 0, 64, 0              ; :
.db 0, 0, 0, 0, 0, 64, 0, 0, 64, 64             ; ;
.db 0, 12, 24, 48, 96, 96, 48, 24, 12, 0        ; <
.db 0, 0, 0, 0, 56, 0, 56, 0, 0, 0              ; =
.db 0, 48, 24, 12, 6, 6, 12, 24, 48, 0          ; >
.db 0, 48, 24, 24, 24, 48, 0, 48, 48, 0         ; ?
.db 0, 0, 56, 68, 76, 84, 92, 64, 56, 0         ; @
.db 0, 60, 66, 66, 126, 66, 98, 98, 98, 0       ; A
.db 0, 124, 66, 66, 124, 66, 98, 98, 124, 0     ; B
.db 0, 60, 66, 64, 64, 64, 96, 98, 60, 0        ; C
.db 0, 124, 66, 66, 66, 66, 98, 98, 124, 0      ; D
.db 0, 126, 64, 64, 120, 64, 96, 96, 126, 0     ; E
.db 0, 126, 64, 64, 120, 64, 96, 96, 96, 0      ; F
.db 0, 60, 66, 64, 64, 70, 98, 98, 60, 0        ; G
.db 0, 66, 66, 66, 126, 66, 98, 98, 98, 0       ; H
.db 0, 60, 16, 16, 16, 16, 24, 24, 60, 0        ; I
.db 0, 60, 8, 8, 8, 8, 24, 24, 48, 0            ; J
.db 0, 66, 66, 68, 120, 68, 98, 98, 98, 0       ; K
.db 0, 64, 64, 64, 64, 64, 96, 96, 126, 0       ; L
.db 0, 102, 90, 90, 66, 66, 98, 98, 98, 0       ; M
.db 0, 66, 98, 114, 90, 78, 102, 98, 98, 0      ; N
.db 0, 60, 66, 66, 66, 66, 98, 98, 60, 0        ; O
.db 0, 124, 66, 66, 124, 64, 96, 96, 96, 0      ; P
.db 0, 60, 66, 66, 66, 66, 106, 100, 58, 0      ; Q
.db 0, 124, 66, 66, 124, 72, 100, 98, 98, 0     ; R
.db 0, 60, 64, 64, 60, 6, 6, 6, 60, 0           ; S
.db 0, 126, 16, 16, 16, 16, 24, 24, 24, 0       ; T
.db 0, 66, 66, 66, 66, 66, 98, 98, 60, 0        ; U
.db 0, 66, 66, 66, 66, 66, 102, 36, 24, 0       ; V
.db 0, 98, 98, 98, 66, 66, 90, 90, 102, 0       ; W
.db 0, 66, 66, 36, 24, 24, 36, 66, 66, 0        ; X
.db 0, 66, 66, 36, 24, 16, 24, 24, 24, 0        ; Y
.db 0, 126, 6, 6, 12, 24, 48, 96, 126, 0        ; Z
.db 0, 12, 8, 8, 8, 8, 8, 8, 8, 12              ; [
.db 0, 96, 48, 48, 24, 24, 12, 12, 6, 0         ; \ ;
.db 0, 48, 16, 16, 16, 16, 16, 16, 16, 48       ; ]
.db 0, 32, 80, 80, 0, 0, 0, 0, 0, 0             ; ^
.db 0, 0, 0, 0, 0, 0, 0, 0, 126, 0              ; _
.db 0, 32, 32, 16, 0, 0, 0, 0, 0, 0             ; `
.db 0, 0, 0, 0, 56, 4, 60, 68, 56, 0            ; a
.db 0, 0, 0, 64, 64, 120, 68, 68, 56, 0         ; b
.db 0, 0, 0, 0, 56, 64, 64, 64, 56, 0           ; c
.db 0, 0, 0, 4, 4, 60, 68, 68, 56, 0            ; d
.db 0, 0, 0, 0, 56, 68, 120, 64, 56, 0          ; e
.db 0, 0, 0, 28, 32, 32, 120, 32, 32, 0         ; f
.db 0, 0, 0, 0, 56, 68, 68, 60, 4, 56           ; g
.db 0, 0, 0, 64, 64, 120, 68, 68, 68, 0         ; h
.db 0, 0, 0, 16, 0, 16, 16, 16, 16, 0           ; i
.db 0, 0, 0, 16, 0, 16, 16, 16, 32, 0           ; j
.db 0, 0, 0, 64, 72, 80, 96, 80, 72, 0          ; k
.db 0, 0, 0, 32, 32, 32, 32, 32, 24, 0          ; l
.db 0, 0, 0, 0, 40, 84, 68, 68, 68, 0           ; m
.db 0, 0, 0, 0, 88, 36, 36, 36, 36, 0           ; n
.db 0, 0, 0, 0, 56, 68, 68, 68, 56, 0           ; o
.db 0, 0, 0, 0, 56, 68, 68, 120, 64, 64         ; p
.db 0, 0, 0, 0, 56, 68, 68, 60, 4, 4            ; q
.db 0, 0, 0, 0, 24, 32, 32, 32, 32, 0           ; r
.db 0, 0, 0, 0, 60, 64, 56, 4, 120, 0           ; s
.db 0, 0, 0, 32, 32, 120, 32, 32, 28, 0         ; t
.db 0, 0, 0, 0, 68, 68, 68, 68, 56, 0           ; u
.db 0, 0, 0, 0, 68, 68, 68, 40, 16, 0           ; v
.db 0, 0, 0, 0, 68, 68, 68, 84, 40, 0           ; w
.db 0, 0, 0, 0, 68, 40, 16, 40, 68, 0           ; x
.db 0, 0, 0, 0, 68, 68, 60, 4, 4, 56            ; y
.db 0, 0, 0, 0, 124, 8, 16, 32, 124, 0          ; z
.db 0, 4, 8, 8, 8, 16, 8, 8, 8, 4               ; {
.db 0, 0, 16, 16, 16, 16, 16, 16, 16, 0         ; |
.db 0, 32, 16, 16, 16, 8, 16, 16, 16, 32        ; }
.db 0, 0, 40, 80, 0, 0, 0, 0, 0, 0              ; ~
