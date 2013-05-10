;
; /!\   CAUTION   /!\
;
; These routines write pixels in the background layer. To do that,
; they need to have a background composed of 1024 different tiles,
; which is way more than allowed by the usual memory model of our
; demos. Please be aware of this since a call to, for example,
; copysatb, will write into memory used by the tiles, hence messing
; up the display.
;
;

; setupbackgroundcanvas
; sets up the bat for a background composed of 1024 different tiles
; defined linearly in memory starting at address TILE_START
; modifies <vram_ptr
setupbackgroundcanvas:
    inc $000e
    ; fill the bat
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02

	lda #LOW(TILE_START >> 4)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START >> 4)
    sta HIGH_BYTE <vram_ptr

    ldx #$ff
.fillbat:
    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013
    incw <vram_ptr

    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013
    incw <vram_ptr

    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013
    incw <vram_ptr

    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013
    incw <vram_ptr

    dex
    bne .fillbat

    stz $000e

    rts


; clearbackgroundcanvas
; clears 1024 * $10 words of memory starting at TILE_START,
; i.e creates 1024 blank tiles
clearbackgroundcanvas: 
    inc $000e
    st0 #$00
    lda #LOW(TILE_START)
    sta $0012
    lda #HIGH(TILE_START)
    sta $0013
    st0 #$02

    ldx #$ff
.filltiles:
    cla
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013

    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013

    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013

    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013
    sta $0012
    sta $0013


    dex
    lbne .filltiles

    stz $000e
    rts


; oramask
; ORs \1 with \2, putting the result back in \1
oramask:    .macro
    lda \1
    ora \2
    sta \1
    .endm


; andmask
; ANDs \1 with \2, putting the result back in \1
andmask:    .macro
    lda \1
    and \2
    sta \1
    .endm


; computetilecoordinates
; <R1 = x, <R1 + 1 = y
; outputs tile address in <vram_ptr
; outputs tile-relative coordinates in <R1/<R1 + 1
; modifies <R2, <R3
computetilecoordinates:
    phx
    ; y
    lda <R1 + 1
    lsr a
    lsr a
    lsr a
    asl a           ; mul by 2 because we are indexing a word array
    tax
    lda y_tiles, x
    sta <R2
    inx
    lda y_tiles, x
    sta <R2 + 1

    ; x
    lda <R1
    lsr a
    lsr a
    lsr a
    asl a           ; mul by 2 because we are indexing a word array
    tax
    lda x_tiles, x
    sta <R3
    inx
    lda x_tiles, x
    sta <R3 + 1

    addw <R3, <R2

    ; tile
	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    addw <R2, <vram_ptr

    ; pixel location inside the tile
    lda <R1
    and #7 ; == and (8 - 1) == mod 8 (you better believe! :) )
    sta <R1
    lda <R1 + 1
    and #7 ; == and (8 - 1) == mod 8 (you better believe! :) )
    sta <R1 + 1

    plx
    rts


; changepixelcolor
; <R1 = x, <R1 + 1 = y (inside the tile, so 0 <= x, y <= 7)
; <vram_ptr = tile address
; <R0 = color #
; modifies <R2, <R3
; /!\ use computetilecoordinates to generate the tile-relative coordinates
; from absolute screen coordinates if you don't want to go crazy :) /!\
changepixelcolor:
    phx
    inc $000e

    ; on récupère un masque en fonction du x (<R1)
    ; on applique ce masque à chaque plan en fonction de la couleur (<R0)
    ; x et y doivent être entre 0 et 7

    ; <R2 = OR mask, <R2 + 1 = AND mask
    ldx <R1
    lda or_masks, x
    sta <R2
    lda and_masks, x
    sta <R2 + 1

    lda <R1 + 1
    sta <R3
    stz <R3 + 1

    addw <R3, <vram_ptr

    ; setup write pointer
    st0 #$00
    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013

    ; setup read pointer
    st0 #$01
    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013

    st0 #$02


.plane0:
    bbr0 <R0, .set0to0
    oramask $0012, <R2
    bra .plane1

    .set0to0:
    andmask $0012, <R2 + 1

.plane1:
    bbr1 <R0, .set1to0
    oramask $0013, <R2
    bra .movetoplane2

    .set1to0:
    andmask $0013, <R2 + 1


.movetoplane2:


    ; add 8 to move to the corresponding #3 and #4 planes
    addw #8, <vram_ptr

    ; setup write pointer
    st0 #$00
    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013

    ; setup read pointer
    st0 #$01
    lda <vram_ptr
    sta $0012
    lda <vram_ptr + 1
    sta $0013

    st0 #$02


 .plane2:
    bbr2 <R0, .set2to0
    oramask $0012, <R2
    bra .plane3

    .set2to0:
    andmask $0012, <R2 + 1

.plane3:
    bbr3 <R0, .set3to0
    oramask $0013, <R2
    bra .end

    .set3to0:
    andmask $0013, <R2 + 1


.end:
    ; set to 1 : ora w/ mask 00010000
    ; set to 0 : and w/ mask 11101111
    stz $000e
    plx
    rts


; changecolor
; changes the color of every pixels in a given tile
; <vram_ptr = address of the tile
; <R0 = color #
changecolor:
    st0 #$00
    lda <vram_ptr
    sta $0002
    lda <vram_ptr + 1
    sta $0003
    st0 #$02

    ldx #$08
.change01:
    bbs0 <R0, .change0to1
    stz $0002
    bra .change1
.change0to1:
    lda #$ff
    sta $0002

.change1:
    bbs1 <R0, .change1to1
    stz $0003
    bra .endchange01
.change1to1:
    lda #$ff
    sta $0003

.endchange01
    dex
    bne .change01


    ldx #$08
.change23:
    bbs2 <R0, .change2to1
    stz $0002
    bra .change3
.change2to1:
    lda #$ff
    sta $0002

.change3:
    bbs3 <R0, .change3to1
    stz $0003
    bra .endchange23
.change3to1:
    lda #$ff
    sta $0003

.endchange23:
    dex
    bne .change23

    rts


