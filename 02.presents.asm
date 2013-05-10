    .include "d02.presents.code.asm"

presents:
    st0 #$09        ; set the BAT size to 64x32 tiles
    st1 #%00010000
    st2 #$00

    ; display leftmost part of the BAT
    st0 #$07
    st1 #$00
    st2 #$00


    jsr presents_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #presents_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #presents_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

    lda #bank(music)
    sta <music_bank

    lda #LOW(music)
    sta <music_offset
    lda #HIGH(music)
    sta <music_offset + 1

    lda #1
    sta <vgm_play


.wait:

    jsr wait_vsync

    ; here be stuff
    cmpw #60, <frame_counter
    bcc .blank
    beq .loadpalette
    cmpw #120, <frame_counter
    bcc .line0
    cmpw #180, <frame_counter
    bcc .line1
    cmpw #240, <frame_counter
    bcc .line2

    bra .line3

.blank:
    cla
    bra .setvalue
.loadpalette:
    jsr d02.presents_load_palettes
.line0:
    lda #40
    bra .setvalue
.line1:
    lda #80
    bra .setvalue
.line2:
    lda #120
    bra .setvalue
.line3:
    lda #240

.setvalue:
    sta <R10

    ; handle screen end's palette fade to blue
    cmpw #390, <frame_counter
    bne .nextpaltest
    stz <frame_skip_counter

.nextpaltest:
;    cmpw #400, <frame_counter
    bcc .end
    lda <frame_skip_counter
    cmp #4
    bne .end
    stz <frame_skip_counter

    ; fade palettes
    lda LOW_BYTE #(palette + PALETTE_SIZE)
    sta <R0
    lda HIGH_BYTE #(palette + PALETTE_SIZE)
    sta <R0 + 1

    lda LOW_BYTE #palette
    sta <R1
    lda HIGH_BYTE #palette
    sta <R1 + 1

    jsr fadepalette


    lda #LOW(palette + PALETTE_SIZE)
    sta <data_ptr
    lda #HIGH(palette + PALETTE_SIZE)
    sta <data_ptr + 1

    stz <R0
    jsr loadpalette



.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(7 * 60), <frame_counter
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


presents_scanline:
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
    cmp <R10
    bcs .blank

    bra .set_scroll

.blank:
    cla

.set_scroll:
    cmp #0
    bne .go

    ; shift one screen to the right
    st0 #$07
    st1 #$00
    st2 #$01


.go
    st0 #$08
    sta $0002
    st2 #$00

.end:

    plx
    pla
    rti


presents_load:
    ; prepare palettes for screen end's fade
    copypalette #titlebluepalette, palette

    lda #bank(d02.presents_data00)
    tam #page(d02.presents_data00)
    copypalette #d02.presents_palette00, palette + PALETTE_SIZE

    jsr d02.presents_load_VDC1


    rts



