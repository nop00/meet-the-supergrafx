    .include "d06.background.code.asm"
    .include "d06.bg.code.asm"

background:
    jsr background_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #background_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #background_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    ;st0 #$06
    ;st1 #$40
    ;st2 #$00


    st0 #$09        ; set the BAT size to 64x64 tiles
    st1 #%01010000
    st2 #$00

    inc $000e
    st0 #$09        ; set the BAT size to 64x64 tiles
    st1 #%01010000
    st2 #$00
    stz $000e


    stz <R10
    stz <R11
    stz <R12
    stz <R12 + 1


    lda #%01110111
    sta $0008
    sta $0009

    stz $000A
    stz $000B
    stz $000C
    stz $000D

    lda #bank(d06.background_data04)
    tam #page(d06.background_data04)

.wait:
    ; fade palettes
    cmpw #40, <frame_counter
    bcs .doscreen

    lda <frame_skip_counter
    cmp #4
    bne .doscreen
    stz <frame_skip_counter

    ; map the location of the palettes we want to fade to
    lda #bank(d06.background_data00)
    tam #page(d06.background_data00)

    ; fade palettes
    lda LOW_BYTE #(palette)
    sta <R0
    lda HIGH_BYTE #(palette)
    sta <R0 + 1

    lda LOW_BYTE #d06.background_palette00
    sta <R1
    lda HIGH_BYTE #d06.background_palette00
    sta <R1 + 1

    jsr fadepalette

    lda #bank(d06.background_data04)
    tam #page(d06.background_data04)

    lda LOW_BYTE #(palette + PALETTE_SIZE)
    sta <R0
    lda HIGH_BYTE #(palette + PALETTE_SIZE)
    sta <R0 + 1

    lda LOW_BYTE #d06.background_palette01
    sta <R1
    lda HIGH_BYTE #d06.background_palette01
    sta <R1 + 1

    jsr fadepalette


    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1
    stz <R0
    jsr loadpalette

    lda #LOW(palette + PALETTE_SIZE)
    sta <data_ptr
    lda #HIGH(palette + PALETTE_SIZE)
    sta <data_ptr + 1
    lda #1
    sta <R0
    jsr loadpalette


.doscreen:
    cmpw #300, <frame_counter
    lbcc .copysatb
    cmpw #428, <frame_counter
    beq .initsatb2
    bcs .movesatb2

    lda #LOW(d06.easeout)
    sta <R14
    lda #HIGH(d06.easeout)
    sta <R14 + 1
    addw <R12, <R14

    lda [R14]
    sta <R0
    incw <R14
    lda [R14]
    sta <R0 + 1

    incw <R12
    incw <R12

    ; satbshiftx
    ; <R0 : amount to add or subtract to the coordinate
    ; <R1 : 1 = increment, 0 = decrement
    ; <R2 : number of satb items to shift
    ; <R3 : offset of the items to begin with (in items)
    lda #1
    sta <R1
    lda #63
    sta <R2
    jsr satbshiftx
    lda #9
    sta <R2
    jsr satb2shiftx

    bra .copysatb



.initsatb2:
    lda #bank(d06.bg_data02)
    tam #page(d06.bg_data02)

    tii d06.bg_satb2, satb, 61 * 4 * 2
    jsr clearsatb2

    lda #bank(d06.background_data04)
    tam #page(d06.background_data04)

    ; satbshifty
    ; <R0 : amount to add or subtract to the coordinate
    ; <R1 : 1 = increment, 0 = decrement
    ; <R2 : number of satb items to shift
    ; <R3 : offset of the items to begin with (in items)
    lda #60
    sta <R0
    stz <R0 + 1
    lda #1
    sta <R1
    lda #61
    sta <R2
    stz <R3
    jsr satbshifty

    lda #255
    sta <R0
    lda #61
    sta <R2
    jsr satbshiftx

    stz <R12
    stz <R12 + 1

    bra .copysatb

.movesatb2:
    cmpw #556, <frame_counter
    bcs .copysatb

    lda #LOW(d06.easein)
    sta <R14
    lda #HIGH(d06.easein)
    sta <R14 + 1
    addw <R12, <R14

    lda [R14]
    sta <R0
    incw <R14
    lda [R14]
    sta <R0 + 1

    incw <R12
    incw <R12

    ; satbshiftx
    ; <R0 : amount to add or subtract to the coordinate
    ; <R1 : 1 = increment, 0 = decrement
    ; <R2 : number of satb items to shift
    ; <R3 : offset of the items to begin with (in items)
    lda #1
    sta <R1
    lda #61
    sta <R2
    jsr satbshiftx

.copysatb:
    jsr copysatb
    jsr copysatb2
    jsr wait_vsync

    ; here be stuff
    lda <R10
    tax
    tay

.setoffset:
    st0 #$07
    lda bg00coords, x
    sta $0002
    st2 #$00

    inx

    st0 #$08
    lda bg00coords, x
    sta $0002
    st2 #$00


    inc $000E

    st0 #$07
    lda bg01coords, y
    sta $0012
    st2 #$00

    iny

    st0 #$08
    lda bg01coords, y
    sta $0012
    st2 #$00

    stz $000E

    inc <R10
    inc <R10
 
.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(15 * 60), <frame_counter
    lblo .wait

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    stz <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #1
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #2
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #3
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #4
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #5
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #6
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #7
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #8
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #9
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #10
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #11
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #12
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #13
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #14
    sta <R0
    jsr loadpalette


    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #15
    sta <R0
    jsr loadpalette


    jsr wait_vsync

    jsr clearbg
    jsr clearbg2

    jsr clearsatb
    jsr copysatb
    .if (SGX)
    jsr clearsatb2
    jsr copysatb2
    .endif
    
    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00

    rts


background_scanline:
    pha
    phx

    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f0
    lda <vdc_current_scanline
    cmp #$f0
    bne .set_scanline_int

    stz <vdc_current_scanline

.set_scanline_int:
    clc
    lda <vdc_current_scanline
    adc #$40
    st0 #$06
    sta $0002
    cla
    adc #$00
    sta $0003

    ; here be stuff

.end:

    plx
    pla
    rti


background_load:
    ; load fully brown palettes
    lda #0
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #bgbrownpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #bgbrownpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #bgbrownpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #bgbrownpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    copypalette #bgbrownpalette, #palette
    copypalette #bgbrownpalette, #(palette + PALETTE_SIZE)



    jsr d06.background_load_VDC1
    jsr d06.background_load_VDC2
    ; load sprites
    jsr d06.bg_load_VDC1
    jsr d06.bg_load_VDC2

    lda #bank(d06.bg_data02)
    tam #page(d06.bg_data02)

     
    tii d06.bg_satb, satb, 63 * 4 * 2
    tii d06.bg_satb + 63 * 4 * 2, satb2, 9 * 4 * 2

    ; satbshifty
    ; <R0 : amount to add or subtract to the coordinate
    ; <R1 : 1 = increment, 0 = decrement
    ; <R2 : number of satb items to shift
    ; <R3 : offset of the items to begin with (in items)
    lda #174
    sta <R0
    lda #1
    sta <R1
    lda #63
    sta <R2
    stz <R3
    jsr satbshifty
    lda #9
    sta <R2
    jsr satb2shifty

    lda #84
    sta <R0
    lda #63
    sta <R2
    jsr satbshiftx
    lda #9
    sta <R2
    jsr satb2shiftx


    rts

    .include "d06.easeinout.asm"

