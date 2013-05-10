d11.bender_load_palettes:
    lda #bank(d11.bender_data00)
    tam #page(d11.bender_data00)
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d11.bender_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.bender_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d11.bender_load_VDC1:
    jsr d11.bender_load_palettes
.d11.bender00_load_tiles:
    lda #bank(d11.bender_data00)
    tam #page(d11.bender_data00)
    lda #LOW(TILE_START + D11.BENDER_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D11.BENDER_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.bender_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.bender_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D11.BENDER_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D11.BENDER_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d11.bender00_load_bat:
    lda #bank(d11.bender_data00)
    tam #page(d11.bender_data00)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d11.bender_bat, $0002, 1024 * 2

    rts

d11.bender_load_VDC2:
    jsr d11.bender_load_palettes
.d11.bender00_load_tiles:
    lda #bank(d11.bender_data00)
    tam #page(d11.bender_data00)
    lda #LOW(TILE_START + D11.BENDER_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D11.BENDER_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.bender_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.bender_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D11.BENDER_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D11.BENDER_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d11.bender00_load_bat:
    lda #bank(d11.bender_data00)
    tam #page(d11.bender_data00)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d11.bender_bat, $0012, 1024 * 2
    stz $000e

    rts

