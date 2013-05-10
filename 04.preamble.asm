    .include "d04.preamble.code.asm"

preamble:
    jsr preamble_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    clx
    lda #128
.initstarslast:
    sta starslast, x
    inx
    sta starslast, x
    inx

    cpx #0 ; 256  (i.e STAR_COUNT * 2 when STAR_COUNT == 128)
    bne .initstarslast

    stz <R10
    stz <R10 + 1
    stz <R11
    stz <R11 + 1

.wait:
    jsr wait_vsync


    cmpw #(5 * 60), <frame_counter
    bne .starfield
    jsr d04.preamble_load_VDC1


.starfield:
    ; starfield
    lda <frame_skip_counter
    sta <R10
    stz <R10 + 1
    sta <R11

    lda #bank(d04.stars.path1)
    tam #page(d04.stars.path1)

    lda #LOW(starcoords1)
    sta <R12
    lda #HIGH(starcoords1)
    sta <R12 + 1

    ; mul R10 by 63 (64 - 1)
    aslw <R10
    aslw <R10
    aslw <R10
    aslw <R10
    aslw <R10
    aslw <R10
    subw <R11, <R10

    addw <R10, <R12

    clx
.starloop1:
    lda starslast, x
    sta <R1
    inx
    lda starslast, x
    sta <R1 + 1
    dex
    jsr computetilecoordinates

    ; color
    stz <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y

    
    lda [R12]
    incw <R12
    sta <R1
    sta starslast, x
    inx
    lda [R12]
    incw <R12
    sta <R1 + 1
    sta starslast, x
    inx
    jsr computetilecoordinates

    ; color
    lda [R12]
    incw <R12
    ;lsr a
    ;lsr a
    ;inc a
    sta <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y


    cpx #21 * 2
    lbne .starloop1



    lda #bank(d04.stars.path2)
    tam #page(d04.stars.path2)

    lda #LOW(starcoords2)
    sta <R12
    lda #HIGH(starcoords2)
    sta <R12 + 1

    addw <R10, <R12

.starloop2:
    lda starslast, x
    sta <R1
    inx
    lda starslast, x
    sta <R1 + 1
    dex
    jsr computetilecoordinates

    ; color
    stz <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y

    
    lda [R12]
    incw <R12
    sta <R1
    sta starslast, x
    inx
    lda [R12]
    incw <R12
    sta <R1 + 1
    sta starslast, x
    inx
    jsr computetilecoordinates

    ; color
    lda [R12]
    incw <R12
    ;lsr a
    ;lsr a
    ;inc a
    sta <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y


    cpx #21 * 4
    lbne .starloop2


    lda #bank(d04.stars.path3)
    tam #page(d04.stars.path3)

    lda #LOW(starcoords3)
    sta <R12
    lda #HIGH(starcoords3)
    sta <R12 + 1

    addw <R10, <R12

.starloop3:
    lda starslast, x
    sta <R1
    inx
    lda starslast, x
    sta <R1 + 1
    dex
    jsr computetilecoordinates

    ; color
    stz <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y

    
    lda [R12]
    incw <R12
    sta <R1
    sta starslast, x
    inx
    lda [R12]
    incw <R12
    sta <R1 + 1
    sta starslast, x
    inx
    jsr computetilecoordinates

    ; color
    lda [R12]
    incw <R12
    ;lsr a
    ;lsr a
    ;inc a
    sta <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y


    cpx #21 * 6
    lbne .starloop3


    lda #bank(d04.stars.path4)
    tam #page(d04.stars.path4)

    lda #LOW(starcoords4)
    sta <R12
    lda #HIGH(starcoords4)
    sta <R12 + 1

    addw <R10, <R12

.starloop4:
    lda starslast, x
    sta <R1
    inx
    lda starslast, x
    sta <R1 + 1
    dex
    jsr computetilecoordinates

    ; color
    stz <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y

    
    lda [R12]
    incw <R12
    sta <R1
    sta starslast, x
    inx
    lda [R12]
    incw <R12
    sta <R1 + 1
    sta starslast, x
    inx
    jsr computetilecoordinates

    ; color
    lda [R12]
    incw <R12
    ;lsr a
    ;lsr a
    ;inc a
    sta <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y


    cpx #21 * 8
    lbne .starloop4



    lda #bank(d04.stars.path5)
    tam #page(d04.stars.path5)

    lda #LOW(starcoords5)
    sta <R12
    lda #HIGH(starcoords5)
    sta <R12 + 1

    addw <R10, <R12

.starloop5:
    lda starslast, x
    sta <R1
    inx
    lda starslast, x
    sta <R1 + 1
    dex
    jsr computetilecoordinates

    ; color
    stz <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y

    
    lda [R12]
    incw <R12
    sta <R1
    sta starslast, x
    inx
    lda [R12]
    incw <R12
    sta <R1 + 1
    sta starslast, x
    inx
    jsr computetilecoordinates

    ; color
    lda [R12]
    incw <R12
    ;lsr a
    ;lsr a
    ;inc a
    sta <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y


    cpx #21 * 10
    lbne .starloop5



    lda #bank(d04.stars.path6)
    tam #page(d04.stars.path6)

    lda #LOW(starcoords6)
    sta <R12
    lda #HIGH(starcoords6)
    sta <R12 + 1

    addw <R10, <R12

.starloop6:
    lda starslast, x
    sta <R1
    inx
    lda starslast, x
    sta <R1 + 1
    dex
    jsr computetilecoordinates

    ; color
    stz <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y

    
    lda [R12]
    incw <R12
    sta <R1
    sta starslast, x
    inx
    lda [R12]
    incw <R12
    sta <R1 + 1
    sta starslast, x
    inx
    jsr computetilecoordinates

    ; color
    lda [R12]
    incw <R12
    ;lsr a
    ;lsr a
    ;inc a
    sta <R0

    jsr changepixelcolor ; <vram_ptr = tile, <R0 = color#, <R1 = x, <R1 + 1 = y


    cpx #21 * 12
    lbne .starloop6




    lda <frame_skip_counter
    cmp #127
    bne .end
    stz <frame_skip_counter
 

.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(15 * 60 + 15), <frame_counter
    lblo .wait

    jsr wait_vsync
    jsr clearsatb
    jsr copysatb
    .if (SGX)
    jsr clearsatb2
    jsr copysatb2
    .endif
    
    rts




preamble_load:

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #starfieldpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #starfieldpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    jsr setupbackgroundcanvas
    jsr clearbackgroundcanvas


    rts

starfieldpalette: .defpal $000,$777,$777,$555,$444,$222,$111,$111,$111,$111,$111,$111,$000,$000,$000,$000


