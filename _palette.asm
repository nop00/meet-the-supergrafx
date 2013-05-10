; loadpalette
; <R0 : palette #
; <data_ptr : label where the 16-color palette is
loadpalette:
    pha
    phx
    aslw <R0
    aslw <R0
    aslw <R0
    aslw <R0
    lda LOW_BYTE <R0
    sta $402        ; select color
    lda HIGH_BYTE <R0
    sta $403        ; select color

    ldx #16
.loadcolor:
    lda [data_ptr]
    sta $404
    incw <data_ptr
    lda [data_ptr]
    sta $405
    incw <data_ptr
    dex
    bne .loadcolor
    plx
    pla
    rts


; copypalette
; \1 : source address
; \2 : destination address
copypalette .macro
    tii \1, \2, #32
    .endm


; setbackgroundcolor
; r component of color to set
; g component of color to set
; b component of color to set 
    .macro setbackgroundcolor
    lda #LOW(#16 << 4)
    sta $402   
    lda #HIGH(#16 << 4)
    sta $403  
    lda #LOW(\2 << 6 | \1 << 3 | \3)
    sta $404
    lda #HIGH(\2 << 6 | \1 << 3 | \3)
    sta $405
    .endm


; setpalettecolor
; <R0 : palette #
; <R1 : color #
; <r, <g, <b : color to set 
setpalettecolor:
    aslw <R0
    aslw <R0
    aslw <R0
    aslw <R0
    addw <R1, <R0

    lda LOW_BYTE <R0
    sta $402   
    lda HIGH_BYTE <R0
    sta $403  

    lda <r
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    tax

    lda <g
    asl a
    asl a
    asl a

    ora <b
    sta <MR0
    txa
    ora <MR0

    sta $404

    lda <r
    lsr a
    lsr a
    sta $405
    rts


; getcolorlowbyte
; <r, <g, <b : color to work with
; outputs in reg. a
getcolorlowbyte:
    lda <g
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    tax

    lda <r
    asl a
    asl a
    asl a

    ora <b
    sta <MR0
    txa
    ora <MR0

    rts


; getcolorhighbyte
; <r, <g, <b : color to work with
; outputs in reg. a
getcolorhighbyte:
    lda <g
    lsr a
    lsr a

    rts


; getpaletter
; \1 : color low byte
; parameter
; parameter 
getpaletter .macro
    lda \1
    lsr a
    lsr a
    lsr a
    and #%00000111
    .endm


; getpaletteg
; <R2 : color (2-byte value)
getpaletteg:
    clc
    lda <R2 + 1
    lsr a
    lda <R2
    ror a

    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    and #%00000111
    rts


; getpaletteb
; \1 : color low byte
getpaletteb .macro;
    lda \1
    and #%00000111
    .endm


; fadepalette
; [R0] : from palette
; [R1] : to palette
; uses <R2
; writes the resulting palette back in [R0]
fadepalette:
    phy
    phx
    cly
.x:
    lda [R0], y
    sta LOW_BYTE <MR1
    lda [R1], y
    sta LOW_BYTE <MR2
    iny
    lda [R0], y
    sta HIGH_BYTE <MR1
    lda [R1], y
    sta HIGH_BYTE <MR2

    dey

    getpaletter <MR1
    sta LOW_BYTE <MR3
    getpaletter <MR2
    sta HIGH_BYTE <MR3
    jsr interpol
    sta <r
.xg:
    lda LOW_BYTE <MR1
    sta LOW_BYTE <R2
    lda HIGH_BYTE <MR1
    sta HIGH_BYTE <R2
    jsr getpaletteg
    sta LOW_BYTE <MR3
    lda LOW_BYTE <MR2
    sta LOW_BYTE <R2
    lda HIGH_BYTE <MR2
    sta HIGH_BYTE <R2
    jsr getpaletteg
    sta HIGH_BYTE <MR3
    jsr interpol
    sta <g
.xb:
    getpaletteb <MR1
    sta LOW_BYTE <MR3
    getpaletteb <MR2
    sta HIGH_BYTE <MR3
    jsr interpol
    sta <b
.xend:
    jsr getcolorlowbyte
    sta [R0], y
    iny
    jsr getcolorhighbyte
    sta [R0], y
    iny
    cpy #$20
    lbne .x
    plx
    ply

    rts


; interpol
; <MR3 : from value
; <MR3 + 1 : to value
; outputs in reg.a 
interpol:
    clc
    lda <MR3
    cmp <MR3 + 1
    beq .end
    bpl .dec
    inc a
    bra .end
.dec:
    dec a
.end:
    rts


; setpalettecolorfast
; <R0 : palette #
; <R1 : color #
; <R2, <R2 + 1 : color
setpalettecolorfast:
    aslw <R0
    aslw <R0
    aslw <R0
    aslw <R0
    addw <R1, <R0

    lda LOW_BYTE <R0
    sta $402   
    lda HIGH_BYTE <R0
    sta $403  

    lda <R2
    sta $404

    lda <R2 + 1
    sta $405
    rts


