    ;lda #LOW(SPR_VRAM(SPRITE_START + SPRITE_SIZE * 48))
    ;lda #HIGH(SPR_VRAM(SPRITE_START + SPRITE_SIZE * 48))

; getcharaddress
; \1 : char ascii code
; \2 : where to output the address (somewhere in zp would be nice :) )
    .macro getcharaddress
    pha
    phx

    lda \1
    sec             ; set the carry flag before a subtraction (similar to clearing it before an add, it just "works in reverse" when you sub)
    sbc #$20
    tax             ; save a copy of a in x

    ; multiply by 64 by shifting left 6 times
    ; we do it in two parts, since we will have a 16bits result
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    clc
    adc #LOW(FONT_START)
    sta LOW_BYTE \2

    txa
    lsr a
    lsr a
    clc
    adc #HIGH(FONT_START)
    sta HIGH_BYTE \2

    plx
    pla
    .endm


; getcharvramaddress
; \1 : char ascii code
; \2 : where to output the address (somewhere in zp would be nice :) )
    .macro getcharvramaddress

    getcharaddress \1, \2

    ; now, shift right 5 bits to get the vram address

    ; first, shift the lower byte
    lda LOW_BYTE \2
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    sta LOW_BYTE \2

    ; then, shift the upper byte, taking into account the bits the shift to the lower byte
    lda HIGH_BYTE \2
    asl a
    asl a
    asl a
    ora LOW_BYTE \2
    sta LOW_BYTE \2

    lda HIGH_BYTE \2
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    sta HIGH_BYTE \2
    .endm


; copytovram
copytovram .macro
    ; setup write pointer
    st0 #$00
    lda LOW_BYTE \1
    sta $0002
    lda HIGH_BYTE \1
    sta $0003

    st0 #$02

    tia $2000, $0002, #SPRITE_SIZE
    ;tia <_composespriteoutput, $0002, #SPRITE_SIZE

    .endm
 

; maketextsatb
; <data_ptr : text
; <satb_ptr : satb
; <R0 : letter spacing
; <R1 : x coordinate start position
; <R2 ; y coordinate start position
; uses <R3, <R4
maketextsatb: 

    lda <R1
    sta <R3
    lda <R1 + 1
    sta <R3 + 1
.satb:
    lda [data_ptr]
    lbeq .end
    cmp #$20        ; if the char is a space, just offset the x coordinates, no need to waste a satb slot on that
    bne .gogogo
    clc
    lda LOW_BYTE <R3
    adc #$10
    sta LOW_BYTE <R3
    lda HIGH_BYTE <R3
    adc #$00
    sta HIGH_BYTE <R3

    incw data_ptr
    bra .satb


.gogogo:
    sta LOW_BYTE <R4
    getcharvramaddress LOW_BYTE <R4, <vram_ptr

    ; y position
    lda <R2
    sta [satb_ptr]
    incw <satb_ptr
    lda <R2 + 1
    sta [satb_ptr]
    incw <satb_ptr

    ; x position
    clc
    lda LOW_BYTE <R3
    sta [satb_ptr]
    adc #$10
    sta LOW_BYTE <R3
    incw <satb_ptr
    lda HIGH_BYTE <R3
    sta [satb_ptr]
    adc #$00
    sta HIGH_BYTE <R3
    incw <satb_ptr

    ;lda LOW_BYTE <R3
    ;adc <R0
    ;sta LOW_BYTE <R3
    ;lda HIGH_BYTE <R3
    ;adc #$00
    ;sta HIGH_BYTE <R3

    ; sprite address in VRAM
    lda LOW_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr

    ; sprite attributes
    lda #%10001110
    sta [satb_ptr]
    incw <satb_ptr
    cla
    sta [satb_ptr]
    incw <satb_ptr

    incw <data_ptr
    
    jmp .satb

.end:

    rts
 


loadtypewriterfont .macro
    lda #bank(typewriter)
    tam #page(typewriter)

    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #typewriterpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriterpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #LOW(SPRITE_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter1    ; 1
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter1    ; 1
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter4    ; A
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter4    ; A
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter5    ; B
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter5    ; B
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter6    ; C
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter6    ; C
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter7    ; D
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter7    ; D
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter8    ; E
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter8    ; E
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter9    ; F
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter9    ; F
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter10    ; G
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter10    ; G
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter11    ; H
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter11    ; H
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter12    ; I
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter12    ; I
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter13    ; J
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter13    ; J
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter14    ; K
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter14    ; K
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter15    ; L
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter15    ; L
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter16    ; M
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter16    ; M
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter17    ; N
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter17    ; N
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter18    ; O
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter18    ; O
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter19    ; P
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter19    ; P
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter20    ; Q
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter20    ; Q
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter21    ; R
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter21    ; R
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter22    ; S
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter22    ; S
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter23    ; T
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter23    ; T
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter24    ; U
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter24    ; U
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter25    ; V
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter25    ; V
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter26    ; W
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter26    ; W
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter27    ; X
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter27    ; X
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter28    ; Y
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter28    ; Y
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #typewriter29    ; Z
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #typewriter29    ; Z
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    .endm

loadasteroidfont .macro
    lda #bank(fontasteroids)
    tam #page(fontasteroids)

    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #fontasteroidspalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroidspalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette



    lda #LOW(SPRITE_START + SPRITE_SIZE *  0)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  0)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids3     ; SPACE
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids3     ; SPACE
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE *  1)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  1)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids1     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids1     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; !
 
    lda #LOW(SPRITE_START + SPRITE_SIZE * 16)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 16)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids4    ; 0
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids4    ; 0
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids5    ; 1
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids5    ; 1
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 18)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 18)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids6    ; 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids6    ; 2
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 19)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 19)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids7    ; 3
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids7    ; 3
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 20)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 20)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids8    ; 4
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids8    ; 4
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 21)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 21)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids9    ; 5
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids9    ; 5
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 22)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 22)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids10    ; 6
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids10    ; 6
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 23)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 23)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids11    ; 7
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids11    ; 7
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 24)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 24)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids12    ; 8
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids12    ; 8
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 25)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 25)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids13    ; 9
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids13    ; 9
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids14    ; A
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids14    ; A
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids15    ; B
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids15    ; B
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids16    ; C
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids16    ; C
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids17    ; D
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids17    ; D
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids18    ; E
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids18    ; E
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids19    ; F
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids19    ; F
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids20    ; G
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids20    ; G
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids21    ; H
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids21    ; H
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids22    ; I
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids22    ; I
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids23    ; J
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids23    ; J
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids24    ; K
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids24    ; K
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids25    ; L
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids25    ; L
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids26    ; M
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids26    ; M
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids27    ; N
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids27    ; N
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids28    ; O
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids28    ; O
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids29    ; P
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids29    ; P
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids30    ; Q
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids30    ; Q
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids31    ; R
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids31    ; R
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids32    ; S
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids32    ; S
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids33    ; T
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids33    ; T
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids34    ; U
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids34    ; U
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids35    ; V
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids35    ; V
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids36    ; W
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids36    ; W
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids37    ; X
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids37    ; X
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids38    ; Y
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids38    ; Y
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids39    ; Z
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids39    ; Z
    sta HIGH_BYTE <data_ptr
    jsr loadsprite



    .endm

