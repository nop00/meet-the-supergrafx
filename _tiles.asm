; loadtilesmacro
; <vram_ptr : VRAM address to load to
; \1 : label where the tiles are
; \2 : numberof tiles to load 
loadtilesmacro .macro
    pha

    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

    jsr wait_vsync
    tia \1, $0002, \2

    pla
    .endm


; loadtiles
; <vram_ptr : VRAM address to load to
; <data_ptr : label where the tiles are
; <R0 : number of tiles to load
; modifies <R0
loadtiles:
    pha
    phy
    phx
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

.loadtiles:
    cly
.loadtile:
    lda [data_ptr],y
    sta $0002
    iny
    lda [data_ptr],y
    sta $0003
    iny
    cpy #32
    bne .loadtile

    clc
    lda LOW_BYTE <data_ptr
    adc #TILE_SIZE * 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <data_ptr
    adc #$00
    sta HIGH_BYTE <data_ptr

    decw <R0
    cmpw <R0, #0
    bne .loadtiles

    plx
    ply
    pla
    rts


; loadtiles
; <vram_ptr : VRAM address to load to
; <data_ptr : label where the tiles are
; <R0 : number of tiles to load
; modifies <R0
loadtiles2:
    pha
    phy
    phx

    lda #1
    sta $000E

    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0012
    lda HIGH_BYTE <vram_ptr
    sta $0013
    st0 #$02

.loadtiles:
    cly
.loadtile:
    lda [data_ptr],y
    sta $0012
    iny
    lda [data_ptr],y
    sta $0013
    iny
    cpy #32
    bne .loadtile

    clc
    lda LOW_BYTE <data_ptr
    adc #TILE_SIZE * 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <data_ptr
    adc #$00
    sta HIGH_BYTE <data_ptr

    decw <R0
    cmpw <R0, #0
    bne .loadtiles

    stz $000E

    plx
    ply
    pla
    rts


clearbg:
    ; set the first color to black
    stz <R0
    stz <R1
    stz <r
    stz <g
    stz <b
    jsr setpalettecolor
 
    ; create a blank tile
    st0 #$00
    lda #LOW(TILE_START)
    sta $0002
    lda #HIGH(TILE_START)
    sta $0003
    st0 #$02

    ldx #TILE_SIZE
.writetile:
    stz $0002
    stz $0003
    dex
    bne .writetile

    ; set the whole BAT to this tile
    st0 #$00
    stz $0002
    stz $0003
    st0 #$02

    ; we clear a 64x32 bat
    ldx #32
.writebatline:
    ldy #64
.writebat:
    lda #LOW(BATVAL(0, TILE_START))
    sta $0002
    lda #HIGH(BATVAL(0, TILE_START))
    sta $0003
    dey
    bne .writebat

    dex
    bne .writebatline

    rts

clearbg2:
    inc $000e
    ; set the first color to black
    stz <R0
    stz <R1
    stz <r
    stz <g
    stz <b
    jsr setpalettecolor
 
    ; create a blank tile
    st0 #$00
    lda #LOW(TILE_START)
    sta $0012
    lda #HIGH(TILE_START)
    sta $0013
    st0 #$02

    ldx #TILE_SIZE
.writetile:
    stz $0012
    stz $0013
    dex
    bne .writetile

    ; set the whole BAT to this tile
    st0 #$00
    stz $0012
    stz $0013
    st0 #$02

    ldx #32
.writebatline:
    ldy #32
.writebat:
    lda #LOW(BATVAL(0, TILE_START))
    sta $0012
    lda #HIGH(BATVAL(0, TILE_START))
    sta $0013
    dey
    bne .writebat

    dex
    bne .writebatline

    stz $000e
    rts

