d07.sprites_load_palettes:
    lda #bank(d07.sprites_data00)
    tam #page(d07.sprites_data00)
    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.sprites_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d07.sprites_load_VDC1:
    jsr d07.sprites_load_palettes
.d07.sprites00_load_sprites:
    lda #bank(d07.sprites_data00)
    tam #page(d07.sprites_data00)
    lda #LOW(SPRITE_START + D07.SPRITES_SPRITES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D07.SPRITES_SPRITES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites_sprite000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES_SPRITES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES_SPRITES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites

    rts

d07.sprites_load_VDC2:
    jsr d07.sprites_load_palettes
.d07.sprites00_load_sprites:
    lda #bank(d07.sprites_data00)
    tam #page(d07.sprites_data00)
    lda #LOW(SPRITE_START + D07.SPRITES_SPRITES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D07.SPRITES_SPRITES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.sprites_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.sprites_sprite000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.SPRITES_SPRITES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.SPRITES_SPRITES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites2

    rts

