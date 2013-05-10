d08.colors_load_palettes:
    lda #bank(d08.colors_data00)
    tam #page(d08.colors_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d08.colors_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d08.colors_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d08.colors_load_VDC1:
    jsr d08.colors_load_palettes
.d08.colors00_load_tiles:
    lda #bank(d08.colors_data00)
    tam #page(d08.colors_data00)
    lda #LOW(TILE_START + D08.COLORS_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D08.COLORS_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d08.colors_tile000
    sta HIGH_BYTE <data_ptr
    lda HIGH_BYTE #d08.colors_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D08.COLORS_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D08.COLORS_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d08.colors00_load_bat:
    lda #bank(d08.colors_data00)
    tam #page(d08.colors_data00)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d08.colors_bat, $0002, 1024 * 2

    rts

d08.colors_load_VDC2:
    jsr d08.colors_load_palettes
.d08.colors00_load_tiles:
    lda #bank(d08.colors_data00)
    tam #page(d08.colors_data00)
    lda #LOW(TILE_START + D08.COLORS_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D08.COLORS_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d08.colors_tile000
    sta HIGH_BYTE <data_ptr
    lda HIGH_BYTE #d08.colors_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D08.COLORS_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D08.COLORS_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d08.colors00_load_bat:
    lda #bank(d08.colors_data00)
    tam #page(d08.colors_data00)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d08.colors_bat, $0012, 1024 * 2
    stz $000e

    rts

