; ----------------------------------------------------------------
; data is arranged in byte-couples
;
; first byte
;   bit0-5: text line (0..23)
;   bit6: video blank
;   bit7: vertical sync
;
; second byte
;   bit0-7: pixel line (0..9)
; ----------------------------------------------------------------

linedata:

; vertical sync (2 scan-lines)
.db 192, 0, 192, 0

; vertical back porch (33 scan-lines)
.db 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0
.db 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0
.db 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0, 64, 0
.db 64, 0, 64, 0, 64, 0

; vertical active video (480 scan-lines)
.db  0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 2, 0, 3, 0, 3, 0, 4, 0, 4, 0, 5, 0, 5, 0, 6, 0, 6, 0, 7, 0, 7, 0, 8, 0, 8, 0, 9, 0, 9                     ; text line: 00
.db  1, 0, 1, 0, 1, 1, 1, 1, 1, 2, 1, 2, 1, 3, 1, 3, 1, 4, 1, 4, 1, 5, 1, 5, 1, 6, 1, 6, 1, 7, 1, 7, 1, 8, 1, 8, 1, 9, 1, 9                     ; text line: 01
.db  2, 0, 2, 0, 2, 1, 2, 1, 2, 2, 2, 2, 2, 3, 2, 3, 2, 4, 2, 4, 2, 5, 2, 5, 2, 6, 2, 6, 2, 7, 2, 7, 2, 8, 2, 8, 2, 9, 2, 9                     ; text line: 02
.db  3, 0, 3, 0, 3, 1, 3, 1, 3, 2, 3, 2, 3, 3, 3, 3, 3, 4, 3, 4, 3, 5, 3, 5, 3, 6, 3, 6, 3, 7, 3, 7, 3, 8, 3, 8, 3, 9, 3, 9                     ; text line: 03
.db  4, 0, 4, 0, 4, 1, 4, 1, 4, 2, 4, 2, 4, 3, 4, 3, 4, 4, 4, 4, 4, 5, 4, 5, 4, 6, 4, 6, 4, 7, 4, 7, 4, 8, 4, 8, 4, 9, 4, 9                     ; text line: 04
.db  5, 0, 5, 0, 5, 1, 5, 1, 5, 2, 5, 2, 5, 3, 5, 3, 5, 4, 5, 4, 5, 5, 5, 5, 5, 6, 5, 6, 5, 7, 5, 7, 5, 8, 5, 8, 5, 9, 5, 9                     ; text line: 05
.db  6, 0, 6, 0, 6, 1, 6, 1, 6, 2, 6, 2, 6, 3, 6, 3, 6, 4, 6, 4, 6, 5, 6, 5, 6, 6, 6, 6, 6, 7, 6, 7, 6, 8, 6, 8, 6, 9, 6, 9                     ; text line: 06
.db  7, 0, 7, 0, 7, 1, 7, 1, 7, 2, 7, 2, 7, 3, 7, 3, 7, 4, 7, 4, 7, 5, 7, 5, 7, 6, 7, 6, 7, 7, 7, 7, 7, 8, 7, 8, 7, 9, 7, 9                     ; text line: 07
.db  8, 0, 8, 0, 8, 1, 8, 1, 8, 2, 8, 2, 8, 3, 8, 3, 8, 4, 8, 4, 8, 5, 8, 5, 8, 6, 8, 6, 8, 7, 8, 7, 8, 8, 8, 8, 8, 9, 8, 9                     ; text line: 08
.db  9, 0, 9, 0, 9, 1, 9, 1, 9, 2, 9, 2, 9, 3, 9, 3, 9, 4, 9, 4, 9, 5, 9, 5, 9, 6, 9, 6, 9, 7, 9, 7, 9, 8, 9, 8, 9, 9, 9, 9                     ; text line: 09
.db  10, 0, 10, 0, 10, 1, 10, 1, 10, 2, 10, 2, 10, 3, 10, 3, 10, 4, 10, 4, 10, 5, 10, 5, 10, 6, 10, 6, 10, 7, 10, 7, 10, 8, 10, 8, 10, 9, 10, 9 ; text line: 10
.db  11, 0, 11, 0, 11, 1, 11, 1, 11, 2, 11, 2, 11, 3, 11, 3, 11, 4, 11, 4, 11, 5, 11, 5, 11, 6, 11, 6, 11, 7, 11, 7, 11, 8, 11, 8, 11, 9, 11, 9 ; text line: 11
.db  12, 0, 12, 0, 12, 1, 12, 1, 12, 2, 12, 2, 12, 3, 12, 3, 12, 4, 12, 4, 12, 5, 12, 5, 12, 6, 12, 6, 12, 7, 12, 7, 12, 8, 12, 8, 12, 9, 12, 9 ; text line: 12
.db  13, 0, 13, 0, 13, 1, 13, 1, 13, 2, 13, 2, 13, 3, 13, 3, 13, 4, 13, 4, 13, 5, 13, 5, 13, 6, 13, 6, 13, 7, 13, 7, 13, 8, 13, 8, 13, 9, 13, 9 ; text line: 13
.db  14, 0, 14, 0, 14, 1, 14, 1, 14, 2, 14, 2, 14, 3, 14, 3, 14, 4, 14, 4, 14, 5, 14, 5, 14, 6, 14, 6, 14, 7, 14, 7, 14, 8, 14, 8, 14, 9, 14, 9 ; text line: 14
.db  15, 0, 15, 0, 15, 1, 15, 1, 15, 2, 15, 2, 15, 3, 15, 3, 15, 4, 15, 4, 15, 5, 15, 5, 15, 6, 15, 6, 15, 7, 15, 7, 15, 8, 15, 8, 15, 9, 15, 9 ; text line: 15
.db  16, 0, 16, 0, 16, 1, 16, 1, 16, 2, 16, 2, 16, 3, 16, 3, 16, 4, 16, 4, 16, 5, 16, 5, 16, 6, 16, 6, 16, 7, 16, 7, 16, 8, 16, 8, 16, 9, 16, 9 ; text line: 16
.db  17, 0, 17, 0, 17, 1, 17, 1, 17, 2, 17, 2, 17, 3, 17, 3, 17, 4, 17, 4, 17, 5, 17, 5, 17, 6, 17, 6, 17, 7, 17, 7, 17, 8, 17, 8, 17, 9, 17, 9 ; text line: 17
.db  18, 0, 18, 0, 18, 1, 18, 1, 18, 2, 18, 2, 18, 3, 18, 3, 18, 4, 18, 4, 18, 5, 18, 5, 18, 6, 18, 6, 18, 7, 18, 7, 18, 8, 18, 8, 18, 9, 18, 9 ; text line: 18
.db  19, 0, 19, 0, 19, 1, 19, 1, 19, 2, 19, 2, 19, 3, 19, 3, 19, 4, 19, 4, 19, 5, 19, 5, 19, 6, 19, 6, 19, 7, 19, 7, 19, 8, 19, 8, 19, 9, 19, 9 ; text line: 19
.db  20, 0, 20, 0, 20, 1, 20, 1, 20, 2, 20, 2, 20, 3, 20, 3, 20, 4, 20, 4, 20, 5, 20, 5, 20, 6, 20, 6, 20, 7, 20, 7, 20, 8, 20, 8, 20, 9, 20, 9 ; text line: 20
.db  21, 0, 21, 0, 21, 1, 21, 1, 21, 2, 21, 2, 21, 3, 21, 3, 21, 4, 21, 4, 21, 5, 21, 5, 21, 6, 21, 6, 21, 7, 21, 7, 21, 8, 21, 8, 21, 9, 21, 9 ; text line: 21
.db  22, 0, 22, 0, 22, 1, 22, 1, 22, 2, 22, 2, 22, 3, 22, 3, 22, 4, 22, 4, 22, 5, 22, 5, 22, 6, 22, 6, 22, 7, 22, 7, 22, 8, 22, 8, 22, 9, 22, 9 ; text line: 22
.db  23, 0, 23, 0, 23, 1, 23, 1, 23, 2, 23, 2, 23, 3, 23, 3, 23, 4, 23, 4, 23, 5, 23, 5, 23, 6, 23, 6, 23, 7, 23, 7, 23, 8, 23, 8, 23, 9, 23, 9 ; text line: 23

; vertical front porch (10 scan-lines)
.db 64, 0,  64, 0,  64, 0,  64, 0,  64, 0,  64, 0,  64, 0,  64, 0,  64, 0,  64, 0

; sentry element -- marks end of frame (scan-line 801)
.db 255, 0