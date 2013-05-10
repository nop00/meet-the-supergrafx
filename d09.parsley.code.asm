d09.parsley_load_palettes:
    lda #bank(d09.parsley_data00)
    tam #page(d09.parsley_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d09.parsley_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d09.parsley_load_VDC1:
    ;jsr d09.parsley_load_palettes
.d09.parsley00_load_tiles:
    lda #bank(d09.parsley_data00)
    tam #page(d09.parsley_data00)
    lda #LOW(TILE_START + D09.PARSLEY_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d09.parsley01_load_tiles:
    lda #bank(d09.parsley_data01)
    tam #page(d09.parsley_data01)
    lda #LOW(TILE_START + D09.PARSLEY_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d09.parsley02_load_tiles:
    lda #bank(d09.parsley_data02)
    tam #page(d09.parsley_data02)
    lda #LOW(TILE_START + D09.PARSLEY_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d09.parsley03_load_tiles:
    lda #bank(d09.parsley_data03)
    tam #page(d09.parsley_data03)
    lda #LOW(TILE_START + D09.PARSLEY_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d09.parsley04_load_bat:
    lda #bank(d09.parsley_data04)
    tam #page(d09.parsley_data04)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d09.parsley_bat, $0002, 4096 * 2

    rts

d09.parsley_load_VDC2:
    ;jsr d09.parsley_load_palettes
.d09.parsley00_load_tiles:
    lda #bank(d09.parsley_data00)
    tam #page(d09.parsley_data00)
    lda #LOW(TILE_START + D09.PARSLEY_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d09.parsley01_load_tiles:
    lda #bank(d09.parsley_data01)
    tam #page(d09.parsley_data01)
    lda #LOW(TILE_START + D09.PARSLEY_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d09.parsley02_load_tiles:
    lda #bank(d09.parsley_data02)
    tam #page(d09.parsley_data02)
    lda #LOW(TILE_START + D09.PARSLEY_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d09.parsley03_load_tiles:
    lda #bank(d09.parsley_data03)
    tam #page(d09.parsley_data03)
    lda #LOW(TILE_START + D09.PARSLEY_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d09.parsley04_load_bat:
    lda #bank(d09.parsley_data04)
    tam #page(d09.parsley_data04)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d09.parsley_bat, $0012, 4096 * 2
    stz $000e

    rts

