d11.twister1_load_palettes:
    lda #bank(d11.twister1_data00)
    tam #page(d11.twister1_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d11.twister1_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.twister1_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d11.twister1_load_VDC1:
    jsr d11.twister1_load_palettes
.d11.twister100_load_tiles:
    lda #bank(d11.twister1_data00)
    tam #page(d11.twister1_data00)
    lda #LOW(TILE_START + D11.TWISTER1_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D11.TWISTER1_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.twister1_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.twister1_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D11.TWISTER1_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D11.TWISTER1_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d11.twister101_load_tiles:
    lda #bank(d11.twister1_data01)
    tam #page(d11.twister1_data01)
    lda #LOW(TILE_START + D11.TWISTER1_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D11.TWISTER1_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.twister1_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.twister1_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D11.TWISTER1_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D11.TWISTER1_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d11.twister102_load_bat:
    lda #bank(d11.twister1_data02)
    tam #page(d11.twister1_data02)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d11.twister1_bat, $0002, 1024 * 2

    rts

d11.twister1_load_VDC2:
    jsr d11.twister1_load_palettes
.d11.twister100_load_tiles:
    lda #bank(d11.twister1_data00)
    tam #page(d11.twister1_data00)
    lda #LOW(TILE_START + D11.TWISTER1_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D11.TWISTER1_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.twister1_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.twister1_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D11.TWISTER1_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D11.TWISTER1_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d11.twister101_load_tiles:
    lda #bank(d11.twister1_data01)
    tam #page(d11.twister1_data01)
    lda #LOW(TILE_START + D11.TWISTER1_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D11.TWISTER1_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.twister1_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.twister1_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D11.TWISTER1_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D11.TWISTER1_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d11.twister102_load_bat:
    lda #bank(d11.twister1_data02)
    tam #page(d11.twister1_data02)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d11.twister1_bat, $0012, 1024 * 2
    stz $000e

    rts

