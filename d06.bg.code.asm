d06.bg_load_palettes:
    lda #bank(d06.bg_data00)
    tam #page(d06.bg_data00)
    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d06.bg_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d06.bg_load_VDC1:
    jsr d06.bg_load_palettes
.d06.bg00_load_sprites:
    lda #bank(d06.bg_data00)
    tam #page(d06.bg_data00)
    lda #LOW(SPRITE_START + D06.BG_SPRITES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D06.BG_SPRITES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.bg_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_sprite000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BG_SPRITES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BG_SPRITES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites

.d06.bg01_load_sprites:
    lda #bank(d06.bg_data01)
    tam #page(d06.bg_data01)
    lda #LOW(SPRITE_START + D06.BG_SPRITES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D06.BG_SPRITES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.bg_sprite063
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_sprite063
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BG_SPRITES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BG_SPRITES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites

.d06.bg02_load_sprites:
    lda #bank(d06.bg_data02)
    tam #page(d06.bg_data02)
    lda #LOW(SPRITE_START + D06.BG_SPRITES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D06.BG_SPRITES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.bg_sprite127
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_sprite127
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BG_SPRITES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BG_SPRITES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites

    rts

d06.bg_load_VDC2:
    jsr d06.bg_load_palettes
.d06.bg00_load_sprites:
    lda #bank(d06.bg_data00)
    tam #page(d06.bg_data00)
    lda #LOW(SPRITE_START + D06.BG_SPRITES00_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D06.BG_SPRITES00_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.bg_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_sprite000
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BG_SPRITES00_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BG_SPRITES00_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites2

.d06.bg01_load_sprites:
    lda #bank(d06.bg_data01)
    tam #page(d06.bg_data01)
    lda #LOW(SPRITE_START + D06.BG_SPRITES01_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D06.BG_SPRITES01_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.bg_sprite063
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_sprite063
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BG_SPRITES01_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BG_SPRITES01_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites2

.d06.bg02_load_sprites:
    lda #bank(d06.bg_data02)
    tam #page(d06.bg_data02)
    lda #LOW(SPRITE_START + D06.BG_SPRITES02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + D06.BG_SPRITES02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d06.bg_sprite127
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d06.bg_sprite127
    sta HIGH_BYTE <data_ptr
    lda #LOW(D06.BG_SPRITES02_COUNT)
    sta LOW_BYTE <R0
    lda #HIGH(D06.BG_SPRITES02_COUNT)
    sta HIGH_BYTE <R0
    jsr loadsprites2

    rts

