
; **************************************************
; clears the text-buffer
; **************************************************

clear:
        ldi XH, txt_bufferH
        ldi XL, txt_bufferL
        clr char
        ldi tmp1, 24
lrow:
        ldi tmp2, 32
lcol:
        st X+, char
        dec tmp2
        brne lcol
        dec tmp1
        brne lrow

        ldi XH, txt_bufferH
        ldi XL, txt_bufferL
ret



; **************************************************
; creates a string of characters
; X pointer: starting location
; tmp1: length of string
; tmp2: character to be repeated
; **************************************************

string:
        subi tmp2, 32
str_loop:
        st X+, tmp2
        dec tmp1
        brne str_loop
ret



; **************************************************
; moves "cursor" to a new location
; tmp1: line [0..23]
; tmp2: column [0..31]
; **************************************************

locate:
        ldi XH, txt_bufferH
        ldi XL, txt_bufferL
        ldi char, 32
        mul char, tmp1
        add r0, tmp2
        adc r1, zero
        add XL, r0
        adc XH, r1
ret



; **************************************************
; prints a string from message-buffer
; tmp1: starting character
; tmp2: string length
; **************************************************

print:
        ldi ZH, high(messages*2)
        ldi ZL, low(messages*2)
        add ZL, tmp1
        adc ZH, zero
nxt_chr:
        lpm char, Z+
        subi char, 32
        st X+, char
        dec tmp2
        brne nxt_chr
ret



; **************************************************
; freeze program for tmp1 * 100ms
; **************************************************

delay:
        clr timer
wait_timer:
        cp timer, tmp1
        brne wait_timer
ret
