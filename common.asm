; masks used when writing pixels to the background
or_masks:
    .db %10000000
    .db %01000000
    .db %00100000
    .db %00010000
    .db %00001000
    .db %00000100
    .db %00000010
    .db %00000001

and_masks:
    .db %01111111
    .db %10111111
    .db %11011111
    .db %11101111
    .db %11110111
    .db %11111011
    .db %11111101
    .db %11111110


; when indexing this with a x coord, divide by 8 before use
x_tiles: .dw $10 * 00 ; 00 -- 07 => tile 0
         .dw $10 * 01 ; 08 -- 15 => tile 1
         .dw $10 * 02 ; 16 -- 23 => tile 2
         .dw $10 * 03
         .dw $10 * 04
         .dw $10 * 05
         .dw $10 * 06
         .dw $10 * 07
         .dw $10 * 08
         .dw $10 * 09
         .dw $10 * 10
         .dw $10 * 11
         .dw $10 * 12
         .dw $10 * 13
         .dw $10 * 14
         .dw $10 * 15
         .dw $10 * 16
         .dw $10 * 17
         .dw $10 * 18
         .dw $10 * 19
         .dw $10 * 20
         .dw $10 * 21
         .dw $10 * 22
         .dw $10 * 23
         .dw $10 * 24
         .dw $10 * 25
         .dw $10 * 26
         .dw $10 * 27
         .dw $10 * 28
         .dw $10 * 29
         .dw $10 * 30
         .dw $10 * 31

; when indexing this with a y coord, divide by 8 before use
y_tiles: .dw 32 * $10 * 00 ; 00 -- 07 => line 0
         .dw 32 * $10 * 01 ; 08 -- 15 => line 1
         .dw 32 * $10 * 02 ; 16 -- 23 => line 2
         .dw 32 * $10 * 03
         .dw 32 * $10 * 04
         .dw 32 * $10 * 05
         .dw 32 * $10 * 06
         .dw 32 * $10 * 07
         .dw 32 * $10 * 08
         .dw 32 * $10 * 09
         .dw 32 * $10 * 10
         .dw 32 * $10 * 11
         .dw 32 * $10 * 12
         .dw 32 * $10 * 13
         .dw 32 * $10 * 14
         .dw 32 * $10 * 15
         .dw 32 * $10 * 16
         .dw 32 * $10 * 17
         .dw 32 * $10 * 18
         .dw 32 * $10 * 19
         .dw 32 * $10 * 20
         .dw 32 * $10 * 21
         .dw 32 * $10 * 22
         .dw 32 * $10 * 23
         .dw 32 * $10 * 24
         .dw 32 * $10 * 25
         .dw 32 * $10 * 26
         .dw 32 * $10 * 27
         .dw 32 * $10 * 28
         .dw 32 * $10 * 29
         .dw 32 * $10 * 30
         .dw 32 * $10 * 31

bgbrownpalette: .defpal $310,$310,$310,$310,$310,$310,$310,$310,$310,$310,$310,$310,$310,$310,$310,$310
titlebluepalette: .defpal $123,$123,$123,$123,$123,$123,$123,$123,$123,$123,$123,$123,$123,$123,$123,$123

whitepalette: .defpal $777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777
blackpalette: .defpal $000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
transparentpalette: .defpal $707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707
transitiontileblack:	.defpal $707,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
transitiontilegreen:	.defpal $707,$021,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000

transitiontilebat: .dw BATVAL(15, TRANSITION_TILE_START)


transitiontile:	.defchr $4000, $0,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111

; empty scanline interrupt handler, it just schedules itself
; for next scanline and goes away
dummy_scanline:
    pha
    phx

    lda #$04    ; mask timer interrupt so we
    sta $1402   ; can work without being... INTerrupted :]
    cli
 
    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f2
    lda <vdc_current_scanline
    cmp #$f2
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

.end:
    plx
    pla

    stz $1402   ; allow timer interrupt

    rti

