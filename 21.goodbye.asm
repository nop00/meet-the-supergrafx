    .include "d21.goodbye.code.asm"

goodbye:
    jsr goodbye_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #goodbye_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #goodbye_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00



.wait:
    jsr wait_vsync

    ; here be stuff
    inc <R10
    stz <R11

    ; fade to black
    cmpw #(60 * 6 + 30), <frame_counter
    bcs .end
    cmpw #(60 * 6), <frame_counter
    bcc .end
    bne .noresetskipframe2
    copypalette #d21.goodbye_palette00, palette
    stz <frame_skip_counter
.noresetskipframe2:
    lda <frame_skip_counter
    cmp #4
    bne .end
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #blackpalette
    sta <R1
    lda HIGH_BYTE #blackpalette
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    stz <R0
    jsr loadpalette



.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(200 * 60), <frame_counter
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


goodbye_scanline:
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
    lda <vdc_current_scanline
    cmp #74
    bcc .reset
    cmp #100
    bcs .reset

    inc <R11
    inc <R11
    inc <R11
    inc <R11

    lda <R10
    clc
    adc <R11
    lsr a
    lsr a
    lsr a
    tax
    lda reflectionx, x

    st0 #$07
    sta $0002
    st2 #$00

    st0 #$08
    clc
    lda reflectiony, x
    adc <vdc_current_scanline
    sta $0002
    st2 #$00

    bra .end

.reset:
    st0 #$07
    st1 #$00
    st2 #$00

    st0 #$08
    lda <vdc_current_scanline
    sta $0002
    st2 #$00


.end:

    plx
    pla
    rti


goodbye_load:
    jsr d21.goodbye_load_VDC1

    rts

reflectionx:
    .db 00, 03, 04, 03, 00, -03, -04, -03
    .db 00, 03, 04, 03, 00, -03, -04, -03
    .db 00, 03, 04, 03, 00, -03, -04, -03
    .db 00, 03, 04, 03, 00, -03, -04, -03
    ;.db 00, 01, 02, 02, 03, 03, 04, 04, 04, 04, 04, 03, 03, 02, 02, 01
    ;.db 00, -01, -02, -02, -03, -03, -04, -04, -04, -04, -04, -03, -03, -02, -02, -01

reflectiony:
    ;.db 03, 04, 05, 06, 06, 06, 05, 04, 03, 02, 01, 00, 00, 00, 01, 02
    ;.db 03, 04, 05, 06, 06, 06, 05, 04, 03, 02, 01, 00, 00, 00, 01, 02
    .db 02, 03, 03, 04, 04, 04, 03, 03, 02, 01, 01, 00, 00, 00, 01, 01
    .db 02, 03, 03, 04, 04, 04, 03, 03, 02, 01, 01, 00, 00, 00, 01, 01


