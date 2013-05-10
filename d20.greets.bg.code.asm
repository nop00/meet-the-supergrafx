d20.greets.bg_load_palettes:
    lda #bank(d20.greets.bg_data00)
    tam #page(d20.greets.bg_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d20.greets.bg_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d20.greets.bg_load_VDC1:
    jsr d20.greets.bg_load_palettes
.d20.greets.bg00_load_tiles:
    lda #bank(d20.greets.bg_data00)
    tam #page(d20.greets.bg_data00)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg01_load_tiles:
    lda #bank(d20.greets.bg_data01)
    tam #page(d20.greets.bg_data01)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg02_load_tiles:
    lda #bank(d20.greets.bg_data02)
    tam #page(d20.greets.bg_data02)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg03_load_tiles:
    lda #bank(d20.greets.bg_data03)
    tam #page(d20.greets.bg_data03)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg04_load_tiles:
    lda #bank(d20.greets.bg_data04)
    tam #page(d20.greets.bg_data04)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES04_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES04_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile1023
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile1023
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES04_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES04_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg05_load_tiles:
    lda #bank(d20.greets.bg_data05)
    tam #page(d20.greets.bg_data05)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES05_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES05_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile1279
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile1279
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES05_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES05_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg06_load_tiles:
    lda #bank(d20.greets.bg_data06)
    tam #page(d20.greets.bg_data06)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES06_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES06_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile1535
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile1535
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES06_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES06_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d20.greets.bg07_load_bat:
    lda #bank(d20.greets.bg_data07)
    tam #page(d20.greets.bg_data07)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d20.greets.bg_bat, $0002, 4096 * 2

    rts

d20.greets.bg_load_VDC2:
    ;jsr d20.greets.bg_load_palettes
.d20.greets.bg00_load_tiles:
    lda #bank(d20.greets.bg_data00)
    tam #page(d20.greets.bg_data00)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg01_load_tiles:
    lda #bank(d20.greets.bg_data01)
    tam #page(d20.greets.bg_data01)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg02_load_tiles:
    lda #bank(d20.greets.bg_data02)
    tam #page(d20.greets.bg_data02)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile511
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile511
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg03_load_tiles:
    lda #bank(d20.greets.bg_data03)
    tam #page(d20.greets.bg_data03)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile767
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile767
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES03_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES03_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg04_load_tiles:
    lda #bank(d20.greets.bg_data04)
    tam #page(d20.greets.bg_data04)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES04_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES04_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile1023
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile1023
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES04_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES04_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg05_load_tiles:
    lda #bank(d20.greets.bg_data05)
    tam #page(d20.greets.bg_data05)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES05_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES05_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile1279
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile1279
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES05_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES05_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg06_load_tiles:
    lda #bank(d20.greets.bg_data06)
    tam #page(d20.greets.bg_data06)
    lda #LOW(TILE_START + D20.GREETS.BG_TILES06_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D20.GREETS.BG_TILES06_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d20.greets.bg_tile1535
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d20.greets.bg_tile1535
    sta HIGH_BYTE <data_ptr
    lda #LOW(D20.GREETS.BG_TILES06_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D20.GREETS.BG_TILES06_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d20.greets.bg07_load_bat:
    lda #bank(d20.greets.bg_data07)
    tam #page(d20.greets.bg_data07)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d20.greets.bg_bat, $0012, 4096 * 2
    stz $000e

    rts

    .include "d20.boing.asm"

