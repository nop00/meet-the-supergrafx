d05.cpu_load_palettes:
    lda #bank(d05.cpu_data00)
    tam #page(d05.cpu_data00)
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d05.cpu_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d05.cpu_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d05.cpu_load_VDC1:
    jsr d05.cpu_load_palettes
.d05.cpu00_load_tiles:
    lda #bank(d05.cpu_data00)
    tam #page(d05.cpu_data00)
    lda #LOW(TILE_START + D05.CPU_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D05.CPU_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d05.cpu_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d05.cpu_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D05.CPU_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D05.CPU_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d05.cpu01_load_tiles:
    lda #bank(d05.cpu_data01)
    tam #page(d05.cpu_data01)
    lda #LOW(TILE_START + D05.CPU_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D05.CPU_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d05.cpu_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d05.cpu_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D05.CPU_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D05.CPU_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles

.d05.cpu01_load_bat:
    lda #bank(d05.cpu_data01)
    tam #page(d05.cpu_data01)
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d05.cpu_bat, $0002, 2048 * 2

    rts

d05.cpu_load_VDC2:
    jsr d05.cpu_load_palettes
.d05.cpu00_load_tiles:
    lda #bank(d05.cpu_data00)
    tam #page(d05.cpu_data00)
    lda #LOW(TILE_START + D05.CPU_TILES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D05.CPU_TILES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d05.cpu_tile000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d05.cpu_tile000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D05.CPU_TILES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D05.CPU_TILES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d05.cpu01_load_tiles:
    lda #bank(d05.cpu_data01)
    tam #page(d05.cpu_data01)
    lda #LOW(TILE_START + D05.CPU_TILES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + D05.CPU_TILES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d05.cpu_tile255
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d05.cpu_tile255
    sta HIGH_BYTE <data_ptr
    lda #LOW(D05.CPU_TILES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D05.CPU_TILES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadtiles2

.d05.cpu01_load_bat:
    lda #bank(d05.cpu_data01)
    tam #page(d05.cpu_data01)
    inc $000e
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02
    tia d05.cpu_bat, $0012, 2048 * 2
    stz $000e

    rts

