d04.preamble_load_palettes:
    lda #bank(d04.preamble_data00)
    tam #page(d04.preamble_data00)
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d04.preamble_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d04.preamble_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d04.preamble_load_VDC1:
    jsr d04.preamble_load_palettes
.d04.preamble00_load_tiles:
    lda #bank(d04.preamble_data00)
    tam #page(d04.preamble_data00)
    lda #LOW(TILE_START + D04.PREAMBLE_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D04.PREAMBLE_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d04.preamble_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d04.preamble_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D04.PREAMBLE_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D04.PREAMBLE_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d04.preamble01_load_tiles:
    lda #bank(d04.preamble_data01)
    tam #page(d04.preamble_data01)
    lda #LOW(TILE_START + D04.PREAMBLE_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D04.PREAMBLE_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d04.preamble_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d04.preamble_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D04.PREAMBLE_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D04.PREAMBLE_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d04.preamble02_load_bat:
    lda #bank(d04.preamble_data02)
    tam #page(d04.preamble_data02)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d04.preamble_bat, $0002, 1024 * 2

    rts

d04.preamble_load_VDC2:
    jsr d04.preamble_load_palettes
.d04.preamble00_load_tiles:
    lda #bank(d04.preamble_data00)
    tam #page(d04.preamble_data00)
    lda #LOW(TILE_START + D04.PREAMBLE_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D04.PREAMBLE_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d04.preamble_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d04.preamble_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D04.PREAMBLE_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D04.PREAMBLE_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d04.preamble01_load_tiles:
    lda #bank(d04.preamble_data01)
    tam #page(d04.preamble_data01)
    lda #LOW(TILE_START + D04.PREAMBLE_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D04.PREAMBLE_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d04.preamble_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d04.preamble_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D04.PREAMBLE_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D04.PREAMBLE_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d04.preamble02_load_bat:
    lda #bank(d04.preamble_data02)
    tam #page(d04.preamble_data02)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d04.preamble_bat, $0012, 1024 * 2
    stz $000e

    rts

