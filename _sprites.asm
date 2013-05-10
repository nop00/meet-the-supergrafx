; loadsprites
; <vram_ptr : VRAM address to load to
; <data_ptr : label where the sprites are
; <R0 : number of sprites to load 
; modifies <R0
loadsprites:
    pha
    phy
    phx
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

.loadsprites:
    cly
.loadsprite:
    lda [data_ptr],y
    sta $0002
    iny
    lda [data_ptr],y
    sta $0003
    iny
    cpy #128
    bne .loadsprite

    clc
    lda LOW_BYTE <data_ptr
    adc #SPRITE_SIZE * 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <data_ptr
    adc #$00
    sta HIGH_BYTE <data_ptr

    decw <R0
    cmpw <R0, #0
    bne .loadsprites

    plx
    ply
    pla
    rts


; loadsprites
; <vram_ptr : VRAM address to load to
; <data_ptr : label where the sprites are
; <R0 : number of sprites to load 
; modifies <R0
loadsprites2:
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

.loadsprites:
    cly
.loadsprite:
    lda [data_ptr],y
    sta $0012
    iny
    lda [data_ptr],y
    sta $0013
    iny
    cpy #128
    bne .loadsprite

    clc
    lda LOW_BYTE <data_ptr
    adc #SPRITE_SIZE * 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <data_ptr
    adc #$00
    sta HIGH_BYTE <data_ptr

    decw <R0
    cmpw <R0, #0
    bne .loadsprites

    plx
    ply
    pla

    stz $000E

    rts


; loadsprite
; <vram_ptr : VRAM address to load to
; <data_ptr : label where the sprite is
; parameter 
loadsprite:
    phy
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02
    cly
.x:
    lda [data_ptr],y
    sta $0002
    iny
    lda [data_ptr],y
    sta $0003
    iny
    cpy #128
    bne .x
    ply
    rts


; loadsprite2
; <vram_ptr : VRAM address to load to
; <data_ptr : label where the sprite is
; parameter 
loadsprite2:
    pha
    phy

    lda #1
    sta $000E

    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0012
    lda HIGH_BYTE <vram_ptr
    sta $0013
    st0 #$02
    cly
.x:
    lda [data_ptr],y
    sta $0012
    iny
    lda [data_ptr],y
    sta $0013
    iny
    cpy #128
    bne .x
    ply

    stz $000E

    rts


