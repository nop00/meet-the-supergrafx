d07.sprites.bg02_load_palettes:
    lda #bank(d07.sprites.bg02_data00)
    tam #page(d07.sprites.bg02_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette01
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette01
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #2
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette02
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette02
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #3
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette03
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette03
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #4
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette04
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette04
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #5
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette05
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette05
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #6
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette06
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette06
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #7
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette07
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette07
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #8
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette08
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette08
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #9
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette09
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette09
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #10
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette10
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette10
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #11
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette11
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette11
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #12
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette12
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette12
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #13
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette13
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette13
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #14
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites.bg02_palette14
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_palette14
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d07.sprites.bg02_load_VDC1:
    jsr d07.sprites.bg02_load_palettes
.d07.sprites.bg0200_load_tiles:
    lda #bank(d07.sprites.bg02_data00)
    tam #page(d07.sprites.bg02_data00)
    lda #LOW(TILE_START + D07.SPRITES.BG02_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG02_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg02_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG02_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG02_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0201_load_tiles:
    lda #bank(d07.sprites.bg02_data01)
    tam #page(d07.sprites.bg02_data01)
    lda #LOW(TILE_START + D07.SPRITES.BG02_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG02_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg02_tile241
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_tile241
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG02_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG02_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0202_load_tiles:
    lda #bank(d07.sprites.bg02_data02)
    tam #page(d07.sprites.bg02_data02)
    lda #LOW(TILE_START + D07.SPRITES.BG02_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG02_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg02_tile497
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_tile497
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG02_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG02_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d07.sprites.bg0203_load_bat:
    lda #bank(d07.sprites.bg02_data03)
    tam #page(d07.sprites.bg02_data03)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d07.sprites.bg02_bat, $0002, 1024 * 2

    rts

d07.sprites.bg02_load_VDC2:
    ;jsr d07.sprites.bg02_load_palettes
.d07.sprites.bg0200_load_tiles:
    lda #bank(d07.sprites.bg02_data00)
    tam #page(d07.sprites.bg02_data00)
    lda #LOW(TILE_START + D07.SPRITES.BG02_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG02_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg02_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG02_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG02_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0201_load_tiles:
    lda #bank(d07.sprites.bg02_data01)
    tam #page(d07.sprites.bg02_data01)
    lda #LOW(TILE_START + D07.SPRITES.BG02_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG02_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg02_tile241
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_tile241
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG02_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG02_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0202_load_tiles:
    lda #bank(d07.sprites.bg02_data02)
    tam #page(d07.sprites.bg02_data02)
    lda #LOW(TILE_START + D07.SPRITES.BG02_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D07.SPRITES.BG02_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites.bg02_tile497
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites.bg02_tile497
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES.BG02_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES.BG02_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d07.sprites.bg0203_load_bat:
    lda #bank(d07.sprites.bg02_data03)
    tam #page(d07.sprites.bg02_data03)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d07.sprites.bg02_bat, $0012, 1024 * 2
    stz $000e

    rts

