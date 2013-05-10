    .include "d08.colors.code.asm"

colors:
    jsr colors_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #colors_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #colors_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00



.wait:
    jsr wait_vsync

    ; here be stuff

.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #600, <frame_counter
    lblo .wait

    jsr wait_vsync
    jsr clearsatb
    jsr copysatb
    .if (SGX)
    jsr clearsatb2
    jsr copysatb2
    .endif
    
    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00

    rts


colors_scanline:
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

    ; here be stuff

.end:

    plx
    pla
    rti


colors_load:
    jsr d08.colors_load_VDC1

    rts



