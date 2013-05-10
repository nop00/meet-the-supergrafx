d06.background_load_palettes:
    lda #bank(d06.background_data00)
    tam #page(d06.background_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d06.background_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d06.background_load_VDC1:
;    jsr d06.background_load_palettes
.d06.background00_load_tiles:
    lda #bank(d06.background_data00)
    tam #page(d06.background_data00)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d06.background01_load_tiles:
    lda #bank(d06.background_data01)
    tam #page(d06.background_data01)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d06.background02_load_tiles:
    lda #bank(d06.background_data02)
    tam #page(d06.background_data02)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d06.background03_load_tiles:
    lda #bank(d06.background_data03)
    tam #page(d06.background_data03)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d06.background04_load_tiles:
    lda #bank(d06.background_data04)
    tam #page(d06.background_data04)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES04_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES04_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile1023
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile1023
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES04_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES04_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d06.background05_load_bat:
    lda #bank(d06.background_data05)
    tam #page(d06.background_data05)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d06.background_bat, $0002, 4096 * 2

    rts

d06.background_load_VDC2:
;    lda #bank(d06.background_data04)
    ;tam #page(d06.background_data04)
    ;lda #1
    ;sta <R0
    ;stz <R0 + 1
    ;lda LOW_BYTE #d06.background_palette01
    ;sta LOW_BYTE <data_ptr
    ;lda HIGH_BYTE #d06.background_palette01
    ;sta HIGH_BYTE <data_ptr
    ;jsr loadpalette

.d06.background00_load_tiles:
    lda #bank(d06.background_data00)
    tam #page(d06.background_data00)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d06.background01_load_tiles:
    lda #bank(d06.background_data01)
    tam #page(d06.background_data01)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d06.background02_load_tiles:
    lda #bank(d06.background_data02)
    tam #page(d06.background_data02)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d06.background03_load_tiles:
    lda #bank(d06.background_data03)
    tam #page(d06.background_data03)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d06.background04_load_tiles:
    lda #bank(d06.background_data04)
    tam #page(d06.background_data04)
    lda #LOW(TILE_START + D06.BACKGROUND_TILES04_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D06.BACKGROUND_TILES04_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.background_tile1023
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.background_tile1023
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BACKGROUND_TILES04_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BACKGROUND_TILES04_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d06.background05_load_bat:
    lda #bank(d06.background_data06)
    tam #page(d06.background_data06)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d06.background_bat2, $0012, 4096 * 2
    stz $000e

    rts

