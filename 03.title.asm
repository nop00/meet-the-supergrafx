    .include "d03.title.code.asm"

title:
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #$00
    st2 #$00

    jsr title_load

    st0 #$08
    st1 #$00
    st2 #$00
    st0 #$07
    st1 #$00
    st2 #$00




    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

.wait:
    jsr wait_vsync

    ; fade palettes
    cmpw #40, <frame_counter
    bcs .end

    lda <frame_skip_counter
    cmp #4
    bne .end
    stz <frame_skip_counter

    ; map the location of the palettes we want to fade to
    lda #bank(d03.title_data00)
    tam #page(d03.title_data00)

    ; fade palettes
    lda LOW_BYTE #(palette)
    sta <R0
    lda HIGH_BYTE #(palette)
    sta <R0 + 1

    lda LOW_BYTE #d03.title_palette00
    sta <R1
    lda HIGH_BYTE #d03.title_palette00
    sta <R1 + 1

    jsr fadepalette

    lda LOW_BYTE #(palette + PALETTE_SIZE)
    sta <R0
    lda HIGH_BYTE #(palette + PALETTE_SIZE)
    sta <R0 + 1

    lda LOW_BYTE #d03.title_palette01
    sta <R1
    lda HIGH_BYTE #d03.title_palette01
    sta <R1 + 1

    jsr fadepalette


    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1
    stz <R0
    jsr loadpalette

    lda #LOW(palette + PALETTE_SIZE)
    sta <data_ptr
    lda #HIGH(palette + PALETTE_SIZE)
    sta <data_ptr + 1
    lda #1
    sta <R0
    jsr loadpalette


    ; here be stuff

.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(6 * 60), <frame_counter
    lblo .wait

    jsr wait_vsync
    jsr clearsatb
    jsr copysatb
    jsr clearbg
    .if (SGX)
    jsr clearsatb2
    jsr copysatb2
    .endif
    
    rts


title_load:
    lda #LOW(titlebluepalette)
    sta <data_ptr
    lda #HIGH(titlebluepalette)
    sta <data_ptr + 1
    stz <R0
    jsr loadpalette

    lda #LOW(titlebluepalette)
    sta <data_ptr
    lda #HIGH(titlebluepalette)
    sta <data_ptr + 1
    lda #1
    sta <R0
    jsr loadpalette

    jsr d03.title_load_VDC1

    copypalette #titlebluepalette, #palette
    copypalette #titlebluepalette, #(palette + PALETTE_SIZE)

    rts



