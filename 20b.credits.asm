    .include "d20b.credits.code.asm"

credits:
    st0 #$07
    st1 #$00
    st2 #$00
    st0 #$08
    st1 #$00
    st2 #$00
    inc $000e
    st0 #$07
    st1 #$00
    st2 #$00
    st0 #$08
    st1 #$00
    st2 #$00
    stz $000e

    jsr credits_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter


    stz <R1
    stz <R3

    stz <R10

    jsr clearsatb
    jsr copysatb

.wait:
    jsr wait_vsync

    inc $000e

    ; setup write pointer
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02


    stz <R14
    lda <R3
    sta <R13

    inc <R10

    ldy #32
.lineloop:
    ; décommenter l'adc et le sta pour un autre mouvement, sympa aussi
    lda <R1
    clc
    ;adc #5
    sta <R11
    ;lda #3
    sta <R12

    ldx #32
.tileloop:
    phx

    ldx <R11
    lda plasmaLUT, x
    ldx <R12
    clc
    adc plasmaLUT, x
    ldx <R13
    clc
    adc plasmaLUT, x
    ldx <R14
    clc
    adc plasmaLUT, x

    lsr a
    lsr a
    lsr a
    lsr a
    asl a
    sta <R0
    stz <R0 + 1

    ; write that shit
    lda #LOW(plasmatilesBAT)
    sta <data_ptr
    lda #HIGH(plasmatilesBAT)
    sta <data_ptr + 1
    addw <R0, <data_ptr

    lda [data_ptr]
    sta $0012
    incw <data_ptr
    lda [data_ptr]
    sta $0013

     

    lda <R11
    clc
    adc #7
    sta <R11
    sec
    lda <R12
    sbc #5
    sta <R12

    plx
    dex
    bne .tileloop

    lda <R14
    sec
    sbc #7
    sta <R14
    lda <R13
    clc
    adc #5
    sta <R13

    dey
    lbne .lineloop

    stz $000e

.end:
    inc <frame_skip_counter
    incw <frame_counter

    sec
    lda <R1
    sbc #2
    sta <R1
    clc
    lda <R3
    adc #3
    sta <R3


    ; change the value here to control the duration of your effect
    cmpw #(8 * 60 - 30), <frame_counter
    lblo .wait

    jsr wait_vsync
    jsr clearsatb
    jsr copysatb
    jsr clearbg2
    inc $000e
    st0 #$09        ; set the BAT size to 32x32 (tiles, not pixels :) )
    st1 #$00
    st2 #$00
    stz $000e

    .if (SGX)
    jsr clearsatb2
    jsr copysatb2
    .endif
    
    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00

    rts



credits_load:
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00

    jsr d20b.credits_load_VDC1

    inc $000e
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00
    stz $000e

    lda #bank(d20b.additional)
    tam #page(d20b.additional)

    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #plasmapalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #plasmapalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #LOW(TILE_START)
    sta <vram_ptr
    lda #HIGH(TILE_START)
    sta <vram_ptr + 1

    lda #LOW(plasmatiles00)
    sta <data_ptr
    lda #HIGH(plasmatiles00)
    sta <data_ptr + 1

    lda #08
    sta <R0
    stz <R0 + 1

    jsr loadtiles2
 
    rts


