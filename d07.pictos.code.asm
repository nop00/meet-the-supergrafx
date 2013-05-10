d07.pictos_load_palettes:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)
    lda #18
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.pictos_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.pictos_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #19
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.pictos_palette01
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.pictos_palette01
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #20
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.pictos_palette02
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.pictos_palette02
    sta HIGH_BYTE <data_ptr
    jsr loadpalette
    lda #21
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d07.pictos_palette03
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.pictos_palette03
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d07.pictos_load_VDC1:
    jsr d07.pictos_load_palettes
.d07.pictos00_load_sprites:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)
    lda #LOW(SPRITE_START + 1024)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + 1024)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.pictos_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.pictos_sprite000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.PICTOS_SPRITES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.PICTOS_SPRITES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites

    rts

d07.pictos_load_VDC2:
    jsr d07.pictos_load_palettes
.d07.pictos00_load_sprites:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)
    lda #LOW(SPRITE_START + D07.PICTOS_SPRITES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D07.PICTOS_SPRITES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d07.pictos_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d07.pictos_sprite000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D07.PICTOS_SPRITES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D07.PICTOS_SPRITES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites2

    rts

