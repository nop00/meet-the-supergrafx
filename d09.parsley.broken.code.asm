d09.parsley.broken_load_palettes:
    lda #bank(d09.parsley.broken_data00)
    tam #page(d09.parsley.broken_data00)
    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d09.parsley.broken_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley.broken_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d09.parsley.broken_load_VDC1:
    jsr d09.parsley.broken_load_palettes
.d09.parsley.broken00_load_tiles:
    lda #bank(d09.parsley.broken_data00)
    tam #page(d09.parsley.broken_data00)
    lda #LOW(TILE_START + D09.PARSLEY.BROKEN_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY.BROKEN_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley.broken_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley.broken_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY.BROKEN_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY.BROKEN_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d09.parsley.broken01_load_tiles:
    lda #bank(d09.parsley.broken_data01)
    tam #page(d09.parsley.broken_data01)
    lda #LOW(TILE_START + D09.PARSLEY.BROKEN_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY.BROKEN_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley.broken_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley.broken_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY.BROKEN_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY.BROKEN_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d09.parsley.broken02_load_bat:
    lda #bank(d09.parsley.broken_data02)
    tam #page(d09.parsley.broken_data02)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d09.parsley.broken_bat, $0002, 2048 * 2

    rts

d09.parsley.broken_load_VDC2:
    jsr d09.parsley.broken_load_palettes
.d09.parsley.broken00_load_tiles:
    lda #bank(d09.parsley.broken_data00)
    tam #page(d09.parsley.broken_data00)
    lda #LOW(TILE_START + D09.PARSLEY.BROKEN_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY.BROKEN_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley.broken_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley.broken_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY.BROKEN_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY.BROKEN_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d09.parsley.broken01_load_tiles:
    lda #bank(d09.parsley.broken_data01)
    tam #page(d09.parsley.broken_data01)
    lda #LOW(TILE_START + D09.PARSLEY.BROKEN_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D09.PARSLEY.BROKEN_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d09.parsley.broken_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d09.parsley.broken_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D09.PARSLEY.BROKEN_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D09.PARSLEY.BROKEN_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d09.parsley.broken02_load_bat:
    lda #bank(d09.parsley.broken_data02)
    tam #page(d09.parsley.broken_data02)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d09.parsley.broken_bat, $0012, 2048 * 2
    stz $000e

    rts

