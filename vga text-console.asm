; *********************************************************************************************************************************
; programming  : pvar (spir@l evolut10n)
; started      : 24-10-2013
; completed    : 02-11-2013
;
; video output on PIND1 (USART - MSPI)
; horizontal sync pulse on PINC2
; vertical sync pulse on PINC0
;
; *************************************************************************************************
;
; NOTES:
;
; X: buffer pointer for string manipulation (outside ISR)
; Y: buffer pointer for rendering (inside ISR)
; Z: message pointer for copying (outside ISR)  /  scanline-data & font-data pointer (inside ISR)
;
; r4..r9: temporary storage for pointers and SREG (CPU-stack access is very slow)
;
; *************************************************************************************************


; **************************************************
; * fundamental assembler directives
; **************************************************

; macros ------------------------------------------------------------------------------------------

; total duration 14 cycles
.macro prep_batch
        ; prepare fontdata pointer
        ldi ZH, high(fontdata*2); (1)
        ldi ZL, low(fontdata*2) ; (1)
        ; get character
        ld data, Y+             ; (2)
        ; get font pixel-line
        ldi temp, 10            ; (1)
        mul data, temp          ; (2)
        add ZL, r0              ; (1)
        adc ZH, r1              ; (1)
        add ZL, font_line       ; (1)
        adc ZH, zero            ; (1)
        lpm temp, Z             ; (3)
.endmacro

; total duration 2 cycles
.macro push_batch
        sts UDR0, temp          ; (2)
.endmacro

; constants ---------------------------------------------------------------------------------------

.include "m88def.inc"

.equ vsync = 0
.equ hsync = 2

.equ txt_bufferH = 0x01
.equ txt_bufferL = 0x00

; variables ---------------------------------------------------------------------------------------

.equ var1 = 0x1E                ; General Purpose IO register
.equ var2 = 0x2A                ; General Purpose IO register
.equ var3 = 0x2B                ; General Purpose IO register

.def temp = r16                 ; temporary values (used inside ISR)
.def data = r17                 ; working values (used inside ISR)

.def tmp1 = r18                 ; temporary values (outside ISR)
.def tmp2 = r19                 ; temporary values (outside ISR)
.def char = r20                 ; char pointer or value (outside ISR)

.def frames = r21               ; frames counter
.def timer = r22                ; time counter (time unit: 100ms)

.def zero = r14                 ; always equal to zero
.def font_line = r15            ; current pixel-line of font (0..9)



; **************************************************
; * code segment initialization
; **************************************************

.cseg
.org 0
        rjmp mcu_init           ; Power-on, Brown-out and Watchdog Reset
        reti                    ; External Interrupt Request 0
        reti                    ; External Interrupt Request 1
        reti                    ; Pin Change Interrupt Request0
        reti                    ; Pin Change Interrupt Request1
        reti                    ; Pin Change Interrupt Request2
        reti                    ; Watchdog Time-out
        reti                    ; Timer/Counter2 Compare Match A
        reti                    ; Timer/Counter2 Compare Match B
        reti                    ; Timer/Counter2 Overflow
        reti                    ; Timer/Counter1 Capture
        rjmp scanline           ; Timer/Counter1 Compare Match A
        reti                    ; Timer/Counter1 Compare Match B
        reti                    ; Timer/Counter1 Overflow
        reti                    ; Timer/Counter0 Compare Match A
        reti                    ; Timer/Counter0 Compare Match B
        reti                    ; Timer/Counter0 Overflow
        reti                    ; SPI Transfer Complete
        reti                    ; USART RX Complete
        reti                    ; USART UDR Empty
        reti                    ; USART TX Complete
        reti                    ; ADC Conversion Complete
        reti                    ; EEPROM Ready
        reti                    ; Analog Comparator
        reti                    ; 2-wire Serial Interface
        reti                    ; Store Program Memory Ready



; **************************************************
; * microcontroller initialization
; **************************************************

mcu_init:
        ldi temp, $FF           ; set Stack Pointer low-byte
        out SPL, temp           ;
        ldi temp, $04           ; set Stack Pointer high-byte
        out SPH, temp           ;

        lds temp, ADCSRA        ; turn off analog to digital converter
        cbr temp, 128           ; set ADEN bit to 0
        sts ADCSRA, temp        ;

        lds temp, ACSR          ; turn off and disconnect analog comp from internal v-ref
        sbr temp, 128           ; set ACD bit to 1
        cbr temp, 64            ; set ACBG bit to 1
        sts ACSR, temp          ;

        lds temp, WDTCSR        ; stop Watchdog Timer
        andi temp, 0b10110111   ; clear WDTIE and WDE
        sts WDTCSR, temp        ;

        ldi temp, 0b00000001    ;  shutdown analog to digital converter
        sts PRR, temp           ;  set PRADC bit to 1

; PORT configuration
        ldi temp, 0b00010010    ; PIND1 (TX) and PIND4 (XCK) configured as outputs
        out DDRD, temp          ;
        clr temp                ; all outputs high / enable pull-up resistors on inputs
        out PORTD, temp         ;

        ldi temp, 0b00000101    ; PINC0 (vsync) and PINC2 (hsync) configured as outputs
        out DDRC, temp          ; all other pins configured as inputs
        ser temp                ; all outputs high / enable pull-up resistors on inputs
        out PORTC, temp         ;

; TIMER1 configuration
        clr temp                ;
        sts TCCR1A, temp        ; enable CTC mode
        ldi temp, 0b00001001    ; no prescalling
        sts TCCR1B, temp        ;

        ldi temp, 0b00000010    ; load 635 in OCR1A
        sts OCR1AH, temp        ;
        ldi temp, 0b01111011    ; (interrupt for scan-lines)
        sts OCR1AL, temp        ;

        ldi temp, 2             ;
        sts TIMSK1, temp        ; enable interrupt on match A

; USART MSPI configuration
        ldi temp, 0b11000011    ; UMSEL01 = 1, UMSEL00 = 1, UPCHA0 = 1, UCPOL0 = 1
        sts UCSR0C, temp        ;
        ldi temp, 0b00001000    ; enable transmitter (TXEN)
        sts UCSR0B, temp        ;
        clr temp                ; baud rate = F_osc / 2*(UBRR+1)
        sts UBRR0H, temp        ;
        sts UBRR0L, temp        ; UBRR: 0 => baudrate: 10Mbps

; linedata pointer init and save
        ldi ZH, high(linedata*2)
        ldi ZL, low(linedata*2)
        movw r4, ZL

; always equal to zero!
        clr zero

; enable interrupts!
        sei



; **************************************************
; * main program
; **************************************************
        rcall clear

        ldi tmp1, 15
        rcall delay

        ldi tmp1, 2
        ldi tmp2, 6
        rcall locate
; "VGA signal generator" : start=00, len=20
        ldi tmp1, 0
        ldi tmp2, 20
        rcall print

        ldi tmp1, 3
        ldi tmp2, 6
        rcall locate
        ldi tmp1, 20
        ldi tmp2, '='
        rcall string

        ldi tmp1, 15
        rcall delay

        ldi tmp1, 6
        ldi tmp2, 6
        rcall locate
; "monitor res: 640x480" : start=20, len=20
        ldi tmp1, 20
        ldi tmp2, 20
        rcall print

        ldi tmp1, 15
        rcall delay

        ldi tmp1, 9
        ldi tmp2, 6
        rcall locate
; "raster res:  256x240" : start=40, len=20
        ldi tmp1, 40
        ldi tmp2, 20
        rcall print

        ldi tmp1, 15
        rcall delay

        ldi tmp1, 12
        ldi tmp2, 8
        rcall locate
; "delta Hacker mag" : start=58, len=16
        ldi tmp1, 60
        ldi tmp2, 16
        rcall print

        ldi tmp1, 15
        rcall delay

        ldi tmp1, 14
        ldi tmp2, 8
        rcall locate
; "Spir@l Ev0lution" : start=74, len=16
        ldi tmp1, 76
        ldi tmp2, 16
        rcall print

        ldi tmp1, 15
        rcall delay

        ldi tmp1, 18
        ldi tmp2, 1
        rcall locate
; "the quick brown fox..." : start=90, len=43
        ldi tmp1, 92
        ldi tmp2, 43
        rcall print

loop:
        rjmp loop



.include "functions.asm"



; **************************************************
; horizontal ---------------------
; sync pulse    76  cycles
; back porch    37  cycles
; visible       512 cycles
; front porch   11  cycles
;
; vertical -----------------------
; sync pulse    2   lines
; back porch    33  lines
; visible       480 lines
; front porch   10  lines
; **************************************************

scanline:
; compensate for variable interrupt latency
; adds a delay of 4~5 cycles
        lds temp, TCNT1L        ; (2)
        sbrs temp, 0            ; (1~2)
        mul temp, data          ; (2)

; -------------------------------------------------------------------------------------------------
; sync pulse (76 cycles) [current version: 68 cycles]
; -------------------------------------------------------------------------------------------------

; start horizontal sync pulse
        cbi PORTC, hsync        ; (2)

; save SREG
        in r10, SREG            ; (1)
; save Z pointer
        movw r8, ZL             ; (1)
; save buffer pointer
        movw r6, YL             ; (1)

; restore linedata pointer
        movw ZL, r4             ; (1)

; check for end of frame
        lpm data, Z+            ; (3)
        cpi data, 255           ; (1)
        breq frame_end          ; (1~2)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        rjmp vertical_sync      ; (2)

; if end of frame -> reset scanline pointer
frame_end:
        ldi ZH, high(linedata*2); (1)
        ldi ZL, low(linedata*2) ; (1)
        lpm data, Z+            ; (3)
        inc frames              ; (1)

; start / stop vertical sync pulse
vertical_sync:
        sbrc data, 7            ; (1~2)
        cbi PORTC, vsync        ; (2)
        sbrs data, 7            ; (1~2)
        sbi PORTC, vsync        ; (2)

; get font pixel-line
        lpm font_line, Z+       ; (3)

; save linedata pointer
        movw r4, ZL             ; (1)

; timer update
        cpi frames, 6           ; (1)
        brne not_yet            ; (1~2)
        inc timer               ; (1)
        clr frames              ; (1)
        rjmp timer_updated      ; (2)
not_yet:
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
timer_updated:

; 33 spare cycles
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
; 33 spare cycles

; stop horizontal sync pulse
        sbi PORTC, hsync        ; (2)

; -------------------------------------------------------------------------------------------------
; back porch (37 cycles) [current version: 31 cycles]
; -------------------------------------------------------------------------------------------------

; if set -> video blanking / exit ISR
        sbrc data, 6            ; (1~2)
        reti                    ; (4)

; get current line number
        andi data, 0b00011111   ; (1)
; calculate starting byte
        ldi temp, 32            ; (1)
        mul data, temp          ; (2)
; prepare buffer pointer
        ldi YL, txt_bufferL     ; (1)
        ldi YH, txt_bufferH     ; (1)
        add YL, r0              ; (1)
        adc YH, r1              ; (1)

        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)
        nop                     ; (1)

; pixels for character-column #00
        prep_batch              ; (14)
        push_batch              ; (2)

; -------------------------------------------------------------------------------------------------
; active video (512 cycles)
; -------------------------------------------------------------------------------------------------

; pixels for character-column #01
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #02
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #03
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #04
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #05
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #06
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #07
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #08
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #09
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #10
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #11
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #12
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #13
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #14
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #15
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #16
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #17
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #18
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #19
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #20
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #21
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #22
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #23
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #24
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #25
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #26
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #27
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #28
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #29
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #30
        prep_batch              ; (14)
        push_batch              ; (2)
; pixels for character-column #31
        prep_batch              ; (14)
        push_batch              ; (2)

; -------------------------------------------------------------------------------------------------
; front porch (11 cycles) [current version: 7 cycles]
; -------------------------------------------------------------------------------------------------

; restore Z pointer
        movw ZL, r8             ; (1)
; restore buffer pointer
        movw YL, r6             ; (1)
; restore SREG
        out SREG, r10           ; (1)
reti                            ; (4)



.include "linedata.asm"
.include "fontdata.asm"



messages:
.db "VGA signal generatormonitor res: 640x480raster  res: 256x240delta Hacker magSpir@l Ev0lutionthe quick brown fox jumps over the lazy dog!"
