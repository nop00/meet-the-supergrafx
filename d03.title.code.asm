d03.title_load_palettes:
    lda #bank(d03.title_data00)
    tam #page(d03.title_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d03.title_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d03.title_palette01
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_palette01
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d03.title_load_VDC1:
;    jsr d03.title_load_palettes
.d03.title00_load_tiles:
    lda #bank(d03.title_data00)
    tam #page(d03.title_data00)
    lda #LOW(TILE_START + D03.TITLE_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D03.TITLE_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d03.title_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D03.TITLE_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D03.TITLE_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d03.title01_load_tiles:
    lda #bank(d03.title_data01)
    tam #page(d03.title_data01)
    lda #LOW(TILE_START + D03.TITLE_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D03.TITLE_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d03.title_tile254
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_tile254
    sta HIGH_BYTE <data_ptr
    lda #LOW(D03.TITLE_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D03.TITLE_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d03.title02_load_tiles:
    lda #bank(d03.title_data02)
    tam #page(d03.title_data02)
    lda #LOW(TILE_START + D03.TITLE_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D03.TITLE_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d03.title_tile510
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_tile510
    sta HIGH_BYTE <data_ptr
    lda #LOW(D03.TITLE_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D03.TITLE_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d03.title02_load_bat:
    lda #bank(d03.title_data02)
    tam #page(d03.title_data02)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d03.title_bat, $0002, 1024 * 2

    rts

d03.title_load_VDC2:
    jsr d03.title_load_palettes
.d03.title00_load_tiles:
    lda #bank(d03.title_data00)
    tam #page(d03.title_data00)
    lda #LOW(TILE_START + D03.TITLE_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D03.TITLE_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d03.title_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D03.TITLE_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D03.TITLE_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d03.title01_load_tiles:
    lda #bank(d03.title_data01)
    tam #page(d03.title_data01)
    lda #LOW(TILE_START + D03.TITLE_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D03.TITLE_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d03.title_tile254
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_tile254
    sta HIGH_BYTE <data_ptr
    lda #LOW(D03.TITLE_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D03.TITLE_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d03.title02_load_tiles:
    lda #bank(d03.title_data02)
    tam #page(d03.title_data02)
    lda #LOW(TILE_START + D03.TITLE_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D03.TITLE_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d03.title_tile510
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d03.title_tile510
    sta HIGH_BYTE <data_ptr
    lda #LOW(D03.TITLE_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D03.TITLE_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d03.title02_load_bat:
    lda #bank(d03.title_data02)
    tam #page(d03.title_data02)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d03.title_bat, $0012, 1024 * 2
    stz $000e

    rts

