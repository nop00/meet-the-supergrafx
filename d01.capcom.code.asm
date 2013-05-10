d01.capcom_load_palettes:
    lda #bank(d01.capcom_data00)
    tam #page(d01.capcom_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d01.capcom_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d01.capcom_palette01
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_palette01
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #2
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d01.capcom_palette02
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_palette02
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #3
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d01.capcom_palette03
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_palette03
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d01.capcom_load_VDC1:
    jsr d01.capcom_load_palettes
.d01.capcom00_load_tiles:
    lda #bank(d01.capcom_data00)
    tam #page(d01.capcom_data00)
    lda #LOW(TILE_START + D01.CAPCOM_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D01.CAPCOM_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d01.capcom_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D01.CAPCOM_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D01.CAPCOM_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d01.capcom01_load_tiles:
    lda #bank(d01.capcom_data01)
    tam #page(d01.capcom_data01)
    lda #LOW(TILE_START + D01.CAPCOM_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D01.CAPCOM_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d01.capcom_tile252
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_tile252
    sta HIGH_BYTE <data_ptr
    lda #LOW(D01.CAPCOM_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D01.CAPCOM_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d01.capcom02_load_bat:
    lda #bank(d01.capcom_data02)
    tam #page(d01.capcom_data02)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d01.capcom_bat, $0002, 4096 * 2

    rts

d01.capcom_load_VDC2:
    jsr d01.capcom_load_palettes
.d01.capcom00_load_tiles:
    lda #bank(d01.capcom_data00)
    tam #page(d01.capcom_data00)
    lda #LOW(TILE_START + D01.CAPCOM_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D01.CAPCOM_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d01.capcom_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D01.CAPCOM_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D01.CAPCOM_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d01.capcom01_load_tiles:
    lda #bank(d01.capcom_data01)
    tam #page(d01.capcom_data01)
    lda #LOW(TILE_START + D01.CAPCOM_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D01.CAPCOM_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d01.capcom_tile252
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d01.capcom_tile252
    sta HIGH_BYTE <data_ptr
    lda #LOW(D01.CAPCOM_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D01.CAPCOM_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d01.capcom02_load_bat:
    lda #bank(d01.capcom_data02)
    tam #page(d01.capcom_data02)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d01.capcom_bat, $0012, 4096 * 2
    stz $000e

    rts

