    .include "d07.sprites.bg01.code.asm"
    .include "d07.sprites.bg02.code.asm"
    .include "d07.sprites.code.asm"
    .include "d07.pictos.code.asm"

sprites:
    jsr sprites_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; reset bxr & byr
    st0 #$08
    st1 #$00
    st2 #$00
    st0 #$07
    st1 #$00
    st2 #$00

    inc $000e
    st0 #$08
    st1 #$00
    st2 #$00
    st0 #$07
    st1 #$00
    st2 #$00
    stz $000e

    ; set bg prio
    lda #%11111111
    sta $0008
    sta $0009

    stz $000A
    stz $000B
    stz $000C
    stz $000D


    stz <R12
    stz <R12 + 1

    stz <R14
    stz <R14 + 1


    stz <R10
    stz <R10 + 1

    ; pictos coord index
    stz <R11
    stz <R11 + 1
    ; pictos satb index
    stz <R13
    stz <R13 + 1

    sta <r

    jsr d07.sprites.bg02_load_palettes
    jsr d07.sprites.bg01_load_palettes
.wait:
    lda <frame_skip_counter
    cmp #2
    bne .go
    inc <r
    stz <frame_skip_counter
.go:
    jsr copysatb
    jsr copysatb2
    jsr wait_vsync


    inc $000e
    st0 #$07
    lda <r
    sta $0012
    stz $0013
    stz $000e


    ; scroll bg #1
    cmpw #180, <frame_counter
    lbcc .sprites
    beq .scroll
    cmpw #308, <frame_counter
    lbcc .scroll

    cmpw #488, <frame_counter
    lbcc .sprites
    beq .scroll256init
    cmpw #616, <frame_counter
    bcc .scroll

    cmpw #796, <frame_counter
    lbcc .sprites
    beq .scroll512init
    cmpw #924, <frame_counter
    bcc .scroll

    jmp .sprites

.scroll256init:
    stz <R12
    stz <R12 + 1
    lda #LOW(256)
    sta <R10
    lda #HIGH(256)
    sta <R10 + 1
    bra .scroll

.scroll512init:
    stz <R12
    stz <R12 + 1
    lda #LOW(512)
    sta <R10
    lda #HIGH(512)
    sta <R10 + 1
    bra .scroll

.scroll:
    lda #LOW(easeinout)
    sta <R14
    lda #HIGH(easeinout)
    sta <R14 + 1
    addw <R12, <R14

    lda [R14]
    sta <R4
    incw <R14
    lda [R14]
    sta <R4 + 1
    addw <R10, <R4

    st0 #$07
    lda <R4
    sta $0002
    lda <R4 + 1
    sta $0003

    incw <R12
    incw <R12
    incw <R12
    incw <R12

.sprites:
    ; move foreground squids 
    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1
    addw #(2 + SATB_ITEM_SIZE * 4), <satb_ptr
    ldy #1
    ldx #60
.sety:
    ; read x coord
    lda [satb_ptr]
    sta <R0
    lda [satb_ptr], y
    sta <R0 + 1

    subw #2, <R0
    cmpw #16, <R0
    bcs .noreset
    ;wrap x-coord
    lda #31
    sta <R0
    lda #1
    sta <R0 + 1

.noreset:
    ; write x-coord
    lda <R0
    sta [satb_ptr]
    lda <R0 + 1
    sta [satb_ptr], y

    ; prepare index for reading y-coord table
    subw #16, <R0
    aslw <R0
    ; move satb pointer to y-coord slot
    subw #2, <satb_ptr

    cpx #16
    bcs .setsin2
    lda #LOW(poulpesin)
    sta <data_ptr
    lda #HIGH(poulpesin)
    sta <data_ptr + 1
    bra .gosety
.setsin2:
    cpx #31
    bcs .setantisin
    lda #LOW(poulpesin2)
    sta <data_ptr
    lda #HIGH(poulpesin2)
    sta <data_ptr + 1
    bra .gosety
.setantisin:
    cpx #46
    bcs .setantisin2
    lda #LOW(poulpeantisin)
    sta <data_ptr
    lda #HIGH(poulpeantisin)
    sta <data_ptr + 1
    bra .gosety
.setantisin2:
    lda #LOW(poulpeantisin2)
    sta <data_ptr
    lda #HIGH(poulpeantisin2)
    sta <data_ptr + 1

.gosety:
    addw <R0, <data_ptr
    lda [data_ptr]
    sta [satb_ptr]
    lda [data_ptr], y
    sta [satb_ptr], y
    addw #10, satb_ptr

    dex
    lbne .sety

    ; satb2shiftx
    ; <R0 : amount to add or subtract to the x coordinate
    ; <R1 : 1 = increment, 0 = decrement
    ; <R2 : number of satb items to shift
    ; <R3 : offset of the items to begin with (in items)
      
    ; move bg squids
    lda #1
    sta <R0
    stz <R0 + 1
    stz <R1 + 1
    lda #16
    sta <R2
    stz <R2 + 1
    stz <R3 + 1
    
    stz <R1
    stz <R3
    jsr satb2shiftx

    lda #1
    sta <R1
    lda #16
    sta <R3
    jsr satb2shiftx

    stz <R1
    lda #32
    sta <R3
    jsr satb2shiftx

    lda #1
    sta <R1
    lda #48
    sta <R3
    jsr satb2shiftx


    ; wrap satb2 squids that went offscreen (x-wise)
    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr
    subw #6, <satb_ptr
    ldy #1
    ldx #64
.wrap:
    ; go to next x-coord and load it (note that satb_ptr is inited at satb2 - 6)
    addw #8, <satb_ptr
    lda [satb_ptr]
    sta <R0
    lda [satb_ptr], y
    sta <R0 + 1
    ; going off-screen on the left ?
    cmpw #16, <R0
    bne .wrapright
    ; set x coord to 287
    lda #31
    sta [satb_ptr]
    lda #1
    sta [satb_ptr], y
    bra .endwrap
.wrapright:
    ; going off-screen on the right ?
    cmpw #288, <R0
    bne .endwrap
    lda #17
    sta [satb_ptr]
    lda #0
    sta [satb_ptr], y
.endwrap:
    dex
    bne .wrap

    ;move pictos
    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1

    lda #LOW(pictosx)
    sta <data_ptr
    lda #HIGH(pictosx)
    sta <data_ptr + 1
    addw <R11, <data_ptr

    lda #LOW(pictosy)
    sta <vram_ptr
    lda #HIGH(pictosy)
    sta <vram_ptr + 1
    addw <R11, <vram_ptr

    cmpw #0, <R11
    lbeq .loadpictoone
    cmpw #64, <R11
    lbeq .loadpictotwo
    bcc .onepicto
    cmpw #128, <R11
    lbeq .loadpictothree
    lbcc .twopictos
    cmpw #192, <R11
    lbeq .loadpictofour
    lbcc .threepictos
    jmp .fourpictos
.loadpictoone:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)

    lda <R13
    bne .nextpicto11
    tii d07.picto1_satb, satb, 8
    bra .endloadpictoone
.nextpicto11:
    cmp #1
    bne .nextpicto12
    tii d07.picto2_satb, satb, 8
    bra .endloadpictoone
.nextpicto12:
    cmp #2
    bne .nextpicto13
    tii d07.picto3_satb, satb, 8
    bra .endloadpictoone
.nextpicto13:
    tii d07.picto4_satb, satb, 8

.endloadpictoone:
    lda #bank(d07.additional)
    tam #page(d07.additional)
.onepicto:
    lda <R13
    lbne .fourpictos
    ldy #1
    jmp .movepictos

.loadpictotwo:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)

    lda <R13
    bne .nextpicto21
    tii d07.picto1_satb, satb + 8, 8
    bra .endloadpictotwo
.nextpicto21:
    cmp #1
    bne .nextpicto22
    tii d07.picto2_satb, satb + 8, 8
    bra .endloadpictotwo
.nextpicto22:
    cmp #2
    bne .nextpicto23
    tii d07.picto3_satb, satb + 8, 8
    bra .endloadpictotwo
.nextpicto23:
    tii d07.picto4_satb, satb + 8, 8

.endloadpictotwo:
    lda #bank(d07.additional)
    tam #page(d07.additional)
.twopictos:
    lda <R13
    lbne .fourpictos
    ldy #2
    bra .movepictos

.loadpictothree:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)

    lda <R13
    bne .nextpicto31
    tii d07.picto1_satb, satb + 16, 8
    bra .endloadpictothree
.nextpicto31:
    cmp #1
    bne .nextpicto32
    tii d07.picto2_satb, satb + 16, 8
    bra .endloadpictothree
.nextpicto32:
    cmp #2
    bne .nextpicto33
    tii d07.picto3_satb, satb + 16, 8
    bra .endloadpictothree
.nextpicto33:
    tii d07.picto4_satb, satb + 16, 8

.endloadpictothree:
    lda #bank(d07.additional)
    tam #page(d07.additional)
.threepictos:
    lda <R13
    lbne .fourpictos
    ldy #3
    bra .movepictos

.loadpictofour:
    lda #bank(d07.pictos_data00)
    tam #page(d07.pictos_data00)

    lda <R13
    bne .nextpicto41
    tii d07.picto1_satb, satb + 24, 8
    bra .endloadpictofour
.nextpicto41:
    cmp #1
    bne .nextpicto42
    tii d07.picto2_satb, satb + 24, 8
    bra .endloadpictofour
.nextpicto42:
    cmp #2
    bne .nextpicto43
    tii d07.picto3_satb, satb + 24, 8
    bra .endloadpictofour
.nextpicto43:
    tii d07.picto4_satb, satb + 24, 8

.endloadpictofour:
    lda #bank(d07.additional)
    tam #page(d07.additional)
.fourpictos:
    ldy #4
    bra .movepictos

.movepictos:
    lda [data_ptr]
    sta <R0
    incw <data_ptr
    lda [data_ptr]
    sta <R0 + 1
    incw <data_ptr

    lda [vram_ptr]
    sta <R1
    incw <vram_ptr
    lda [vram_ptr]
    sta <R1 + 1
    incw <vram_ptr

    jsr setsatbcoords

    ; normalement en faisant on devrait tomber en dehors du tableau de coordonnées
    ; si <R11 est inférieur à 64 : du coup j'ai mis les coordonnées en double sur la rom
    ; et du coup on tombe dans la copie précédente su <R11 est < 64 \0/
    ; I'm a porcasse and i like it \0/
    subw #64, <data_ptr
    subw #64, <vram_ptr

    dey
    bne .movepictos

    ; stop displaying the pictos after a while
    cmpw #1230, <frame_counter
    bcc .endmove

    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1
    
    stz <R0
    stz <R0 + 1
    stz <R1
    stz <R1 + 1
    jsr setsatbcoords

    cmpw #1270, <frame_counter
    bcc .endmove

    jsr setsatbcoords



.endmove:
 
    incw <R11
    incw <R11
    cmpw #(309 * 2), <R11
    bne .end
    stz <R11
    stz <R11 + 1
    inc <R13

.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(21 * 60 + 30), <frame_counter
    lblo .wait

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #16
    sta <R0
    jsr loadpalette

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1
    lda #17
    sta <R0
    jsr loadpalette


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
    jsr clearsatb
    jsr copysatb
    .if (SGX)
    jsr clearsatb2
    jsr copysatb2
    .endif
    
    rts


sprites_load:

    inc $000e
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00
    st2 #$00
    stz $000e

    jsr d07.sprites.bg02_load_VDC2

    st0 #$09        ; set the BAT size to 128x32 tiles
    st1 #%00110000
    st2 #$00

    jsr d07.sprites.bg01_load_VDC1


    jsr d07.sprites_load_VDC2
    lda #bank(d07.additional)
    tam #page(d07.additional)
    tii d07.sprites_satb_fg, satb2, 64 * 4 * 2
    jsr d07.sprites_load_VDC1
    lda #bank(d07.additional)
    tam #page(d07.additional)
    tii d07.sprites_satb_bg, satb + 4 * 4 * 2, 60 * 4 * 2


    ; prepare satb coords
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr
    addw #(SATB_ITEM_SIZE * 4), <satb_ptr

    ldy #4
.prepsatb1line:
    ldx #15
    lda #70
    sta <R0
    lda #1
    sta <R0 + 1
.prepsatb1:
    ; prepare x coord
    addw #18, <R0
   
    ; prepare y coord
    stz <R1
    stz <R1 + 1

    jsr setsatbcoords

    dex
    bne .prepsatb1

    dey
    bne .prepsatb1line


    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    ldy #4
    lda #(92 + 64 - 36)
    sta <R1
    stz <R1 + 1
.prepsatb2line:
    ldx #16
    tya
    and #%00000001
    bne .oddline
    lda #20
    sta <R0
    lda #1
    sta <R0 + 1
    bra .prepsatb2
.oddline:
    lda #10
    sta <R0
    lda #$ff
    sta <R0 + 1
.prepsatb2:
    ; prepare x coord
    addw #17, <R0
   
    ; prepare y coord
    ; already done :)

    jsr setsatbcoords
    dex
    bne .prepsatb2

    clc
    lda <R1
    adc #18
    sta <R1
    dey
    bne .prepsatb2line

    ; load pictos
    jsr d07.pictos_load_VDC1


    lda #bank(d07.additional)
    tam #page(d07.additional)

    rts


