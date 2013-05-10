    .include "d20.greets.bg.code.asm"
    .include "d20.greets.names.code.asm"

greets:
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

    jsr greets_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #greets_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #greets_scanline
    sta HIGH_BYTE <scanline_handler

;    ; set first scanline interrupt
    ;st0 #$06
    ;st1 #$40
    ;st2 #$00

    lda LOW_BYTE #offsets
    sta <R1
    lda HIGH_BYTE #offsets
    sta <R1 + 1
    cla
    ldx #16
.setoffsets:
    sta [R1]
    incw <R1
    adc #16

    dex
    bne .setoffsets


    stz <R4
    stz <R4 + 1

    stz <R13


.wait:
    lda #bank(d20.greets.names_data01)
    tam #page(d20.greets.names_data01)

    jsr wait_vsync

    ; move VDC #2 background
    inc $000e
    st0 #$07
    lda <R4
    sta $0012
    lda <R4 + 1
    sta $0013

    lda <R13
    and #%00111111
    asl a
    tay
    st0 #$08
    lda boing, y
    sta $0012
    iny
    lda boing, y
    sta $0013
    stz $000e

    inc <R13

    incw <R4
    incw <R4

    ; fade palettes
    cmpw #40, <frame_counter
    bcs .doscreen

    lda <frame_skip_counter
    cmp #4
    bne .doscreen
    stz <frame_skip_counter

    ; map the location of the palettes we want to fade to
    lda #bank(d20.greets.bg_data00)
    tam #page(d20.greets.bg_data00)

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

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1
    stz <R0
    jsr loadpalette


    lda #bank(d20.greets.names_data01)
    tam #page(d20.greets.names_data01)

.doscreen:
    cmpw #(7 * 60 - 30), <frame_counter
    bcc .end
    bne .preparescanline

    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00

    jsr d20.greets.names_load_VDC1

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

.preparescanline:
    ; prepare stuff for the scanline handler
    inc <R11

    lda LOW_BYTE #offsets
    sta <R10
    lda HIGH_BYTE #offsets
    sta <R10 + 1

    lda LOW_BYTE #rainbowpalette
    sta <R12
    lda HIGH_BYTE #rainbowpalette
    sta <R12 + 1
 
.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(20 * 60), <frame_counter
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


greets_scanline:
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
    lda <R11
    adc [R10]
    lsr a
    tax
    lda sine,x
    asl a
    ldx <vdc_current_scanline
    cpx #$f0
    lblo .reallySetXScroll
    cla
.reallySetXScroll:
    st0 #$07
    sta $0002
    st2 #$00

    lda <vdc_current_scanline
    and #%00001111
    bne .changeColor
    incw <R10
    ;inc HIGH_BYTE <R11

.changeColor:
    ; change palette color
    lda [R12]
    sta <R2
    incw <R12
    lda [R12]
    sta <R2 + 1
    incw <R12
    lda #1
    sta <R0
    sta <R1
    jsr setpalettecolorfast


.end:

    plx
    pla
    rti


greets_load:
    ;st0 #$09        ; set the BAT size to 32x32 tiles
    ;st1 #%00000000
    ;st2 #$00

    ;jsr d20.greets.names_load_VDC1

    inc $000e
    st0 #$09        ; set the BAT size to 128x32 tiles
    st1 #%00100000
    st2 #$00
    stz $000e

    jsr d20.greets.bg_load_VDC2

    copypalette #blackpalette, #palette

    rts



