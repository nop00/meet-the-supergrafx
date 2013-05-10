d11.font_load_palettes:
    lda #bank(d11.font_data00)
    tam #page(d11.font_data00)
    lda #30
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #d11.font_palette00
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_palette00
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    rts

d11.font_load_VDC1:
    jsr d11.font_load_palettes
.d11.font00_load_fonts:
    lda #bank(d11.font_data00)
    tam #page(d11.font_data00)
    ; 
    lda #LOW(FONT_START + SPRITE_SIZE * 0)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 0)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;!
    lda #LOW(FONT_START + SPRITE_SIZE * 1)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 1)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite001
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite001
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;"
    lda #LOW(FONT_START + SPRITE_SIZE * 2)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 2)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite002
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite002
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;#
    lda #LOW(FONT_START + SPRITE_SIZE * 3)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 3)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite003
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite003
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;$
    lda #LOW(FONT_START + SPRITE_SIZE * 4)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 4)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;%
    lda #LOW(FONT_START + SPRITE_SIZE * 5)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 5)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;&
    lda #LOW(FONT_START + SPRITE_SIZE * 6)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 6)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;'
    lda #LOW(FONT_START + SPRITE_SIZE * 7)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 7)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite004
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite004
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;(
    lda #LOW(FONT_START + SPRITE_SIZE * 8)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 8)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite005
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite005
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;)
    lda #LOW(FONT_START + SPRITE_SIZE * 9)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 9)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite006
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite006
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;*
    lda #LOW(FONT_START + SPRITE_SIZE * 10)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 10)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;+
    lda #LOW(FONT_START + SPRITE_SIZE * 11)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 11)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite007
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite007
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;,
    lda #LOW(FONT_START + SPRITE_SIZE * 12)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 12)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite008
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite008
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;-
    lda #LOW(FONT_START + SPRITE_SIZE * 13)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 13)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite009
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite009
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;.
    lda #LOW(FONT_START + SPRITE_SIZE * 14)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 14)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite010
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite010
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;/
    lda #LOW(FONT_START + SPRITE_SIZE * 15)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 15)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;0
    lda #LOW(FONT_START + SPRITE_SIZE * 16)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 16)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite011
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite011
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;1
    lda #LOW(FONT_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite012
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite012
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;2
    lda #LOW(FONT_START + SPRITE_SIZE * 18)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 18)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite013
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite013
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;3
    lda #LOW(FONT_START + SPRITE_SIZE * 19)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 19)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite014
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite014
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;4
    lda #LOW(FONT_START + SPRITE_SIZE * 20)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 20)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite015
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite015
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;5
    lda #LOW(FONT_START + SPRITE_SIZE * 21)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 21)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite016
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite016
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;6
    lda #LOW(FONT_START + SPRITE_SIZE * 22)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 22)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite017
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite017
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;7
    lda #LOW(FONT_START + SPRITE_SIZE * 23)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 23)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite018
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite018
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;8
    lda #LOW(FONT_START + SPRITE_SIZE * 24)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 24)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite019
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite019
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;9
    lda #LOW(FONT_START + SPRITE_SIZE * 25)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 25)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite020
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite020
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;:
    lda #LOW(FONT_START + SPRITE_SIZE * 26)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 26)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite021
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite021
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;;
    lda #LOW(FONT_START + SPRITE_SIZE * 27)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 27)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite022
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite022
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;<
    lda #LOW(FONT_START + SPRITE_SIZE * 28)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 28)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;=
    lda #LOW(FONT_START + SPRITE_SIZE * 29)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 29)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;>
    lda #LOW(FONT_START + SPRITE_SIZE * 30)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 30)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;?
    lda #LOW(FONT_START + SPRITE_SIZE * 31)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 31)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite023
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite023
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;@
    lda #LOW(FONT_START + SPRITE_SIZE * 32)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 32)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;A
    lda #LOW(FONT_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite024
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite024
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;B
    lda #LOW(FONT_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite025
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite025
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;C
    lda #LOW(FONT_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite026
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite026
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;D
    lda #LOW(FONT_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite027
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite027
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;E
    lda #LOW(FONT_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite028
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite028
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;F
    lda #LOW(FONT_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite029
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite029
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;G
    lda #LOW(FONT_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite030
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite030
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;H
    lda #LOW(FONT_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite031
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite031
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;I
    lda #LOW(FONT_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite032
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite032
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;J
    lda #LOW(FONT_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite033
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite033
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;K
    lda #LOW(FONT_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite034
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite034
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;L
    lda #LOW(FONT_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite035
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite035
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;M
    lda #LOW(FONT_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite036
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite036
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;N
    lda #LOW(FONT_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite037
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite037
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;O
    lda #LOW(FONT_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite038
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite038
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;P
    lda #LOW(FONT_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite039
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite039
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;Q
    lda #LOW(FONT_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite040
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite040
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;R
    lda #LOW(FONT_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite041
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite041
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;S
    lda #LOW(FONT_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite042
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite042
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;T
    lda #LOW(FONT_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite043
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite043
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;U
    lda #LOW(FONT_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite044
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite044
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;V
    lda #LOW(FONT_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite045
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite045
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;W
    lda #LOW(FONT_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite046
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite046
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;X
    lda #LOW(FONT_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite047
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite047
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;Y
    lda #LOW(FONT_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite048
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite048
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    ;Z
    lda #LOW(FONT_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite049
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite049
    sta HIGH_BYTE <data_ptr
    jsr loadsprite


    rts

d11.font_load_VDC2:
    jsr d11.font_load_palettes
.d11.font00_load_fonts:
    lda #bank(d11.font_data00)
    tam #page(d11.font_data00)
    ; 
    lda #LOW(FONT_START + SPRITE_SIZE * 0)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 0)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;!
    lda #LOW(FONT_START + SPRITE_SIZE * 1)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 1)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite001
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite001
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;"
    lda #LOW(FONT_START + SPRITE_SIZE * 2)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 2)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite002
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite002
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;#
    lda #LOW(FONT_START + SPRITE_SIZE * 3)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 3)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite003
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite003
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;$
    lda #LOW(FONT_START + SPRITE_SIZE * 4)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 4)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;%
    lda #LOW(FONT_START + SPRITE_SIZE * 5)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 5)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;&
    lda #LOW(FONT_START + SPRITE_SIZE * 6)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 6)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;'
    lda #LOW(FONT_START + SPRITE_SIZE * 7)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 7)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite004
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite004
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;(
    lda #LOW(FONT_START + SPRITE_SIZE * 8)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 8)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite005
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite005
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;)
    lda #LOW(FONT_START + SPRITE_SIZE * 9)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 9)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite006
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite006
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;*
    lda #LOW(FONT_START + SPRITE_SIZE * 10)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 10)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;+
    lda #LOW(FONT_START + SPRITE_SIZE * 11)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 11)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite007
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite007
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;,
    lda #LOW(FONT_START + SPRITE_SIZE * 12)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 12)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite008
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite008
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;-
    lda #LOW(FONT_START + SPRITE_SIZE * 13)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 13)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite009
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite009
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;.
    lda #LOW(FONT_START + SPRITE_SIZE * 14)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 14)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite010
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite010
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;/
    lda #LOW(FONT_START + SPRITE_SIZE * 15)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 15)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;0
    lda #LOW(FONT_START + SPRITE_SIZE * 16)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 16)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite011
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite011
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;1
    lda #LOW(FONT_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite012
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite012
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;2
    lda #LOW(FONT_START + SPRITE_SIZE * 18)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 18)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite013
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite013
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;3
    lda #LOW(FONT_START + SPRITE_SIZE * 19)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 19)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite014
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite014
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;4
    lda #LOW(FONT_START + SPRITE_SIZE * 20)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 20)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite015
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite015
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;5
    lda #LOW(FONT_START + SPRITE_SIZE * 21)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 21)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite016
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite016
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;6
    lda #LOW(FONT_START + SPRITE_SIZE * 22)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 22)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite017
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite017
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;7
    lda #LOW(FONT_START + SPRITE_SIZE * 23)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 23)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite018
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite018
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;8
    lda #LOW(FONT_START + SPRITE_SIZE * 24)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 24)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite019
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite019
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;9
    lda #LOW(FONT_START + SPRITE_SIZE * 25)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 25)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite020
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite020
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;:
    lda #LOW(FONT_START + SPRITE_SIZE * 26)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 26)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite021
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite021
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;;
    lda #LOW(FONT_START + SPRITE_SIZE * 27)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 27)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite022
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite022
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;<
    lda #LOW(FONT_START + SPRITE_SIZE * 28)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 28)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;=
    lda #LOW(FONT_START + SPRITE_SIZE * 29)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 29)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;>
    lda #LOW(FONT_START + SPRITE_SIZE * 30)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 30)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;?
    lda #LOW(FONT_START + SPRITE_SIZE * 31)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 31)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite023
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite023
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;@
    lda #LOW(FONT_START + SPRITE_SIZE * 32)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 32)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite000
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite000
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;A
    lda #LOW(FONT_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite024
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite024
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;B
    lda #LOW(FONT_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite025
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite025
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;C
    lda #LOW(FONT_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite026
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite026
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;D
    lda #LOW(FONT_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite027
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite027
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;E
    lda #LOW(FONT_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite028
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite028
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;F
    lda #LOW(FONT_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite029
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite029
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;G
    lda #LOW(FONT_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite030
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite030
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;H
    lda #LOW(FONT_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite031
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite031
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;I
    lda #LOW(FONT_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite032
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite032
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;J
    lda #LOW(FONT_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite033
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite033
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;K
    lda #LOW(FONT_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite034
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite034
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;L
    lda #LOW(FONT_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite035
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite035
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;M
    lda #LOW(FONT_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite036
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite036
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;N
    lda #LOW(FONT_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite037
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite037
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;O
    lda #LOW(FONT_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite038
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite038
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;P
    lda #LOW(FONT_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite039
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite039
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;Q
    lda #LOW(FONT_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite040
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite040
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;R
    lda #LOW(FONT_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite041
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite041
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;S
    lda #LOW(FONT_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite042
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite042
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;T
    lda #LOW(FONT_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite043
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite043
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;U
    lda #LOW(FONT_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite044
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite044
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;V
    lda #LOW(FONT_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite045
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite045
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;W
    lda #LOW(FONT_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite046
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite046
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;X
    lda #LOW(FONT_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite047
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite047
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;Y
    lda #LOW(FONT_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite048
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite048
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2

    ;Z
    lda #LOW(FONT_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(FONT_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #d11.font_sprite049
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #d11.font_sprite049
    sta HIGH_BYTE <data_ptr
    jsr loadsprite2


    rts

