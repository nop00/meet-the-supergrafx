    .include "d09.parsley.code.asm"
    .include "d09.parsley.broken.code.asm"

parsley:
    lda #LOW(whitepalette)
    sta <data_ptr
    lda #HIGH(whitepalette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    jsr parsley_load


    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #parsley_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #parsley_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00


    lda #bank(d09.parsley_data00)
    tam #page(d09.parsley_data00)

    copypalette #whitepalette, palette
    st0 #$07
    st1 #$00
    st2 #$00

.wait:
    jsr wait_vsync

    cmpw #30, <frame_counter
    bcs .afterfadein01
    lda <frame_skip_counter
    cmp #4
    lbne .end
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #d09.parsley_palette00
    sta <R1
    lda HIGH_BYTE #d09.parsley_palette00
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

.afterfadein01:
    cmpw #90, <frame_counter
    bcs .screen02
    jmp .end

.screen02:
    beq .setupfade02 ; #120
    cmpw #120, <frame_counter
    bcs .afterfadein02
    bne .fadein02

.setupfade02:
    inc $000e
    st0 #$07
    st1 #$00
    st2 #$01
    stz $000e

    copypalette #whitepalette, palette
    lda #LOW(whitepalette)
    sta <data_ptr
    lda #HIGH(whitepalette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    stz <frame_skip_counter

.fadein02:
    lda <frame_skip_counter
    cmp #4
    lbne .end
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #d09.parsley_palette00
    sta <R1
    lda HIGH_BYTE #d09.parsley_palette00
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    jmp .end

.afterfadein02:
    cmpw #190, <frame_counter
    bcs .screen03
    jmp .end

.screen03:
    beq .setupfade03 ; #240
    cmpw #220, <frame_counter
    bcs .afterfadein03
    bne .fadein03

.setupfade03:
    inc $000e
    st0 #$07
    st1 #$00
    st2 #$02
    stz $000e

    copypalette #whitepalette, palette
    lda #LOW(whitepalette)
    sta <data_ptr
    lda #HIGH(whitepalette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    stz <frame_skip_counter

.fadein03:
    lda <frame_skip_counter
    cmp #4
    lbne .end
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #d09.parsley_palette00
    sta <R1
    lda HIGH_BYTE #d09.parsley_palette00
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    bra .end

.afterfadein03:
    cmpw #290, <frame_counter
    bcs .screen04
    bra .end

.screen04:
    beq .setupfade04 ; #360
    cmpw #320, <frame_counter
    bcs .afterfadein04
    bne .fadein04

.setupfade04:
    inc $000e
    st0 #$07
    st1 #$00
    st2 #$03
    stz $000e

    copypalette #whitepalette, palette
    lda #LOW(whitepalette)
    sta <data_ptr
    lda #HIGH(whitepalette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    stz <frame_skip_counter

.fadein04:
    lda <frame_skip_counter
    cmp #4
    bne .end
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #d09.parsley_palette00
    sta <R1
    lda HIGH_BYTE #d09.parsley_palette00
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    bra .end

.afterfadein04:

.end:
    cmpw #360, <frame_counter
    bcc .fadeout
    lda <frame_skip_counter
    and #%00000011

    inc $000e
    st0 #$07
    sta $0012
    st2 #$03
    stz $000e



    cmpw #390, <frame_counter
    bne .fadeout
    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette

    st0 #$07
    st1 #$00
    st2 #$01

.fadeout:
    cmpw #(10 * 60 - 30), <frame_counter
    bcc .realend
    bne .noresetskipframe2
    copypalette #d09.parsley.broken_palette00, #palette
    stz <frame_skip_counter
.noresetskipframe2:
    lda <frame_skip_counter
    cmp #4
    bne .realend
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

    lda #1
    sta <R0
    jsr loadpalette



.


.realend
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(11 * 60 - 20), <frame_counter
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


parsley_scanline:
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


parsley_load:
    jsr clearbg2

    st0 #$09        ; set the BAT size to 64x32 tiles
    st1 #%00010000
    st2 #$00

    st0 #$07
    st1 #$00
    st2 #$00

    inc $000e
    st0 #$09        ; set the BAT size to 128x32 tiles
    st1 #%00110000
    st2 #$00

    st0 #$07
    st1 #$00
    st2 #$00
    stz $000e


    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1

    lda #0
    sta <R0
    jsr loadpalette


    jsr d09.parsley_load_VDC2

    jsr d09.parsley.broken_load_VDC1

    rts



