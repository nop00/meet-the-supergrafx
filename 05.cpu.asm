    .include "d05.cpu.code.asm"

cpu:
    jsr cpu_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; sine index
    stz <R10
    stz <R10 + 1
    ; color offset
    stz <R11
    stz <R11 + 1
    ; color
    stz <R12
    stz <R12 + 1
    ; counter
    stz <R13
    ; counter for screen end's filling up with the next screen's bg color
    lda #$ff
    sta <R13 + 1

    ; setup a scanline handler
    lda LOW_BYTE #cpu_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #cpu_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

    stz <R3
    stz <R3 + 1
    stz <R4
    stz <R4 + 1

.wait:
    jsr wait_vsync
    lda <R11
    stz <R10
    sta <R12
    lda <R11 + 1
    sta <R12 + 1

    stz <R13

    lda <frame_skip_counter
    cmp #4
    lbne .next

    stz <frame_skip_counter
    incw <R11


.next:
    cmpw #(60 * 5), <frame_counter
    bcc .fillup
    cmpw #(60 * 5 + 128), <frame_counter
    bcs .fillup
    ; scroll the shit out of bg#1
    lda #LOW(d05.easeout)
    sta <R14
    lda #HIGH(d05.easeout)
    sta <R14 + 1
    addw <R3, <R14

    lda [R14]
    sta <R4
    incw <R14
    lda [R14]
    sta <R4 + 1
    addw #256, <R4

    st0 #$07
    lda <R4
    sta $0002
    lda <R4 + 1
    sta $0003

    incw <R3
    incw <R3

.fillup:
    cmpw #(8 * 60 - 15 - 32), <frame_counter
    bcc .end
    lda <R13 + 1
    sec
    sbc #7
    sta <R13 + 1


.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(8 * 60 - 15), <frame_counter
    lblo .wait

    jsr wait_vsync
    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00

    rts

cpu_scanline:
    pha
    phx

    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f0
    lda <vdc_current_scanline
    cmp #$f0
    bne .set_scanline_int

    stz <vdc_current_scanline

.set_scanline_int:
    clc
    lda <vdc_current_scanline
    adc #$40
    st0 #$06
    sta $0002
    cla
    adc #$00
    sta $0003

    ; load sine value
    ldx <R10
    lda sinecolors, x
    ; higher than counter ?
    ; nope => go change color
    cmp <R13
    bne .changeColor

    ; yes => reset counter, inc sine index, inc color
    inc <R10
    stz <R13
    incw <R12
    cmpw #%0000000111111111, <R12
    bne .changeColor
    stz <R12
    stz <R12 + 1

.changeColor:
    inc <R13
    lda <vdc_current_scanline
    cmp <R13 + 1
    bcs .changeColorEnd
    ; change palette color
    lda <R12
    sta <R2
    lda <R12
    sta <R2 + 1
    stz <R0
    stz <R0 + 1
    stz <R1
    stz <R1 + 1
    jsr setpalettecolorfast
    bra .end

.changeColorEnd:
    ; change palette color to $310
    ; == %000000001011000
    lda #%01011000
    sta <R2
    stz <R2 + 1
    stz <R0
    stz <R0 + 1
    stz <R1
    stz <R1 + 1
    jsr setpalettecolorfast


.end:

    plx
    pla
    rti



cpu_load:
    jsr clearbg2
    inc $000e
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00
    stz $000e


    jsr d05.cpu_load_VDC1
    st0 #$09        ; set the BAT size to 64x32 tiles
    st1 #%00010000
    st2 #$00

    ; shift one screen to the right
    st0 #$07
    st1 #$00
    st2 #$01


    rts

sinecolors:
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05
    .db 06, 07, 08, 08, 09, 09, 10, 10, 10, 10, 10, 09, 09, 08, 08, 07
    .db 06, 05, 04, 04, 03, 03, 02, 02, 02, 02, 02, 03, 03, 04, 04, 05

    .include "d05.easeout.asm"

