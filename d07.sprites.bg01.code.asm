d07.sprites.bg01_load_palettes:
    lda #bank(d07.sprites.bg01_data00)
    tam #page(d07.sprites.bg01_data00)
    lda #15
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg01_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d07.sprites.bg01_load_VDC1:
    ;jsr d07.sprites.bg01_load_palettes
.d07.sprites.bg0100_load_tiles:
    lda #bank(d07.sprites.bg01_data00)
    tam #page(d07.sprites.bg01_data00)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0101_load_tiles:
    lda #bank(d07.sprites.bg01_data01)
    tam #page(d07.sprites.bg01_data01)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0102_load_tiles:
    lda #bank(d07.sprites.bg01_data02)
    tam #page(d07.sprites.bg01_data02)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0103_load_tiles:
    lda #bank(d07.sprites.bg01_data03)
    tam #page(d07.sprites.bg01_data03)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0104_load_bat:
    lda #bank(d07.sprites.bg01_data04)
    tam #page(d07.sprites.bg01_data04)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d07.sprites.bg01_bat, $0002, 4096 * 2

    rts

d07.sprites.bg01_load_VDC2:
    jsr d07.sprites.bg01_load_palettes
.d07.sprites.bg0100_load_tiles:
    lda #bank(d07.sprites.bg01_data00)
    tam #page(d07.sprites.bg01_data00)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0101_load_tiles:
    lda #bank(d07.sprites.bg01_data01)
    tam #page(d07.sprites.bg01_data01)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0102_load_tiles:
    lda #bank(d07.sprites.bg01_data02)
    tam #page(d07.sprites.bg01_data02)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0103_load_tiles:
    lda #bank(d07.sprites.bg01_data03)
    tam #page(d07.sprites.bg01_data03)
    lda #LOW(TILE_START + D07.SPRITES.BG01_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG01_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg01_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg01_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG01_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG01_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0104_load_bat:
    lda #bank(d07.sprites.bg01_data04)
    tam #page(d07.sprites.bg01_data04)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d07.sprites.bg01_bat, $0012, 4096 * 2
    stz $000e

    rts

