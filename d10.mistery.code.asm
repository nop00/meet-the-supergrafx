d10.mistery_load_palettes:
    lda #bank(d10.mistery_data00)
    tam #page(d10.mistery_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette01
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette01
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #2
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette02
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette02
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #3
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette03
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette03
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #4
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette04
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette04
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #5
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette05
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette05
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #6
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette06
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette06
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #7
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d10.mistery_palette07
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_palette07
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d10.mistery_load_VDC1:
    jsr d10.mistery_load_palettes
.d10.mistery00_load_tiles:
    lda #bank(d10.mistery_data00)
    tam #page(d10.mistery_data00)
    lda #LOW(TILE_START + D10.MISTERY_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D10.MISTERY_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d10.mistery_tile000
    sta HIGH_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D10.MISTERY_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D10.MISTERY_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d10.mistery00_load_bat:
    lda #bank(d10.mistery_data00)
    tam #page(d10.mistery_data00)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d10.mistery_bat, $0002, 1024 * 2

    rts

d10.mistery_load_VDC2:
    jsr d10.mistery_load_palettes
.d10.mistery00_load_tiles:
    lda #bank(d10.mistery_data00)
    tam #page(d10.mistery_data00)
    lda #LOW(TILE_START + D10.MISTERY_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D10.MISTERY_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d10.mistery_tile000
    sta HIGH_BYTE <data_ptr
    lda HIGH_BYTE #d10.mistery_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D10.MISTERY_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D10.MISTERY_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d10.mistery00_load_bat:
    lda #bank(d10.mistery_data00)
    tam #page(d10.mistery_data00)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d10.mistery_bat, $0012, 1024 * 2
    stz $000e

    rts

