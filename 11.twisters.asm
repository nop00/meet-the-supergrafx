    .include "d11.twister1.code.asm"
    .include "d11.font.code.asm"
    .include "d11.bender.code.asm"

twisters:
    jsr twisters_load

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; setup a scanline handler
    lda LOW_BYTE #twisters_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #twisters_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00


    stz <R0
    stz <R0 + 1
    stz <R11
    stz <R13
    stz <R14

.wait:

    lda #$ff
    sta <R0
    stz <R1
    clx
.countactiveslices:
    inx
    lda textslicesstate, x
    bne .nextactiveslice
    lda textslices, x
    clc
    adc <R1
    sta <R1
    ; for first unfinished slice, read the offset
    lda <R0
    lda <R0
    cmp #$ff
    beq .readoffset
.nextactiveslice:
    inx
    cpx #(d11.NB_LINES_VDC1 * 2)
    bne .countactiveslices

    lda <R0
    lda <R1
    jsr copysatbslice

    bra .brah

.readoffset:
    dex
    lda textslices, x
    sta <R0
    inx
    bra .nextactiveslice

.brah:

    jsr wait_vsync

    cmpw #(240 + 30), <frame_counter
    beq .line01
    cmpw #(240 + 120), <frame_counter
    beq .line02
    cmpw #(240 + 200), <frame_counter
    beq .line03
    cmpw #(240 + 280), <frame_counter
    beq .line04
    cmpw #(240 + 430), <frame_counter
    beq .line05
    bra .dostuff

.line01:
    stz textslicesstate + 1
    bra .dostuff
.line02:
    stz textslicesstate + 3
    bra .dostuff
.line03:
    stz textslicesstate + 5
    bra .dostuff
.line04:
    stz textslicesstate + 7
    bra .dostuff
.line05:
    stz textslicesstate + 9
    bra .dostuff



.dostuff:   ; :)
 
    stz <R14
    inc <R11

    lda <R11
    cmp #255
    lbne .moveletters
    lda <R13
    not
    sta <R13

.moveletters:
    clx
.moveslice:
    inx
    lda textslicesstate, x
    lbne .nextslice

    ; position satb pointer on correct char
    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1

    dex
    ldy textslices, x
.advancesatb:
    beq .afteradvancesatb
    addw #8, <satb_ptr
    dey
    bra .advancesatb
.afteradvancesatb:

    lda textslicesstate, x
    sta <R0 ; <-- movement offset
    lda textslices, x
    sta <R1 ; <-- offset
    inx
    lda textslices, x
    sta <R2 ; <-- letter count

    phx

    ; move chars
    dec <R1 ; because <R1 + <R2 goes one slot too far, and <R1 is used as the exit condition
    lda <R1
    clc
    adc <R2
    tay
.movelettersloop:
    ; pour y, ajouter d11.textcoords[R11 << 1] a la finalcoord
    tya
    asl a
    tax
    ; read final y
    lda finaltextcoords, x
    sta <R3
    stz <R3 + 1

    ; read current displacement
    ldx <R0
    lda d11.textcoords, x
    sta <R4
    stz <R4 + 1

    ; apply displacement
    addw <R3, <R4
 
    ; write to satb
    lda <R4
    sta [satb_ptr]
    incw <satb_ptr
    lda <R4 + 1
    sta [satb_ptr]

    ; move to next satb item
    addw #7, <satb_ptr

    dey
    cpy <R1
    bne .movelettersloop

    plx
 
    ; increment movement offset and update "done" flag if needed
    lda <R0
    inc a
    dex
    sta textslicesstate, x
    inx
    cmp #56 ;64
    bne .nextslice
    lda #1
    sta textslicesstate, x

.nextslice:
    inx
    cpx #(d11.NB_LINES_VDC1 * 2)
    lbne .moveslice




.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(20 * 60), <frame_counter
    lblo .wait

    jsr wait_vsync
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


twisters_scanline:
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


    lda #LOW(megasinusite + 256 + 128)
    sta <R14
    lda #HIGH(megasinusite + 256 + 128)
    sta <R14 + 1

    addw <vdc_current_scanline, <R14

    lda <R11
    lsr a
    tay

    lda [R14]
    lsr a
    lsr a
    sta <R0

    lda addcount, y
    beq .goscanline
    cmp #1
    bne .mult
    lda <R0
    sta <R10
    bra .goscanline
.mult:
    asl a
    tax
    lda multablesptr, x
    sta <R14
    inx
    lda multablesptr, x
    sta <R14 + 1

    ldy <R0
    lda [R14], y
    sta <R10


.goscanline:    
    lda <R13
    beq .setscroll
    lda <R10
    neg
    sta <R10
.setscroll:
    lda <R10
    st0 #$08
    sta $0002
    st2 #$00

    ;inc $000e
    ;st0 #$08
    ;sta $0012
    ;st2 #$00
    ;stz $000e



.end:
    plx
    pla
    rti



twisters_load:
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00

    st0 #$07
    st1 #$00
    st2 #$00

    inc $000e
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00

    st0 #$07
    st1 #$00
    st2 #$00
    stz $000e


    jsr d11.twister1_load_VDC1
    jsr d11.bender_load_VDC2

    jsr d11.font_load_VDC1


    ; map twister coords bank
    lda #bank(d11.additional)
    tam #page(d11.additional)

    ; prepare satb for texts
    ; maketextsatb
    ; <data_ptr : text
    ; <satb_ptr : satb
    ; <R0 : letter spacing
    ; <R1 : x coordinate start position
    ; <R2 ; y coordinate start position
    lda #LOW(d11.text01)
    sta <data_ptr
    lda #HIGH(d11.text01)
    sta <data_ptr + 1

    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1

    lda #64
    sta <R1
    stz <R1 + 1

    lda #90
    sta <R2
    stz <R2 + 1

    jsr maketextsatb

    stz textslices
    lda #11 ; length without spaces
    sta textslices + 1
    stz textslicesstate
    lda #1
    sta textslicesstate + 1


    lda #LOW(d11.text02)
    sta <data_ptr
    lda #HIGH(d11.text02)
    sta <data_ptr + 1
    lda #72
    sta <R1
    lda #144
    sta <R2
    jsr maketextsatb

    lda #11
    sta textslices + 2
    lda #9 ; length without spaces
    sta textslices + 3
    stz textslicesstate + 2
    lda #1
    sta textslicesstate + 3


    lda #LOW(d11.text03)
    sta <data_ptr
    lda #HIGH(d11.text03)
    sta <data_ptr + 1
    lda #64
    sta <R1
    lda #162
    sta <R2
    jsr maketextsatb

    lda #20
    sta textslices + 4
    lda #11 ; length without spaces
    sta textslices + 5
    stz textslicesstate + 4
    lda #1
    sta textslicesstate + 5


    lda #LOW(d11.text04)
    sta <data_ptr
    lda #HIGH(d11.text04)
    sta <data_ptr + 1
    lda #80
    sta <R1
    lda #180
    sta <R2
    jsr maketextsatb

    lda #31
    sta textslices + 6
    lda #10 ; length without spaces
    sta textslices + 7
    stz textslicesstate + 6
    lda #1
    sta textslicesstate + 7

    lda #LOW(d11.text05)
    sta <data_ptr
    lda #HIGH(d11.text05)
    sta <data_ptr + 1
    lda #40
    sta <R1
    lda #228
    sta <R2
    jsr maketextsatb

    lda #41
    sta textslices + 8
    lda #14 ; length without spaces
    sta textslices + 9
    stz textslicesstate + 8
    lda #1
    sta textslicesstate + 9


    ; prepare text final coordinates (copy them from satb, actually,
    ; because they were computed by maketextsatb)
    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1

    clx
    ldy #64
.prepfinaltextcoords:
    ; read y
    lda [satb_ptr]
    sta finaltextcoords, x
    inx
    incw <satb_ptr
    incw <satb_ptr
    ; read x
    lda [satb_ptr]
    sta finaltextcoords, x
    inx
    addw #6, <satb_ptr
    dey
    bne .prepfinaltextcoords


    ; set current text coords
    lda #LOW(satb)
    sta <satb_ptr
    lda #HIGH(satb)
    sta <satb_ptr + 1

;    cly
    ;ldx #64
;.setcurrenttextcoords:
    ;; copy y
    ;lda d11.textcoords, y
    ;sta <R0
    ;stz <R0 + 1
    ;addw #64, <R0
    ;lda <R0
    ;sta [satb_ptr]
    ;iny
    ;incw <satb_ptr
    ;lda <R0 + 1
    ;sta [satb_ptr]
    ;incw <satb_ptr
    ;; copy x
    ;lda d11.textcoords, y
    ;sta <R0
    ;stz <R0 + 1
    ;addw #32, <R0
    ;lda <R0
    ;sta [satb_ptr]
    ;iny
    ;incw <satb_ptr
    ;lda <R0 + 1
    ;sta [satb_ptr]

    ;addw #5, <satb_ptr

    ;dex
    ;bne .setcurrenttextcoords
       


    ; prepare precalc mutliplication tables pointers
    lda #bank(multables)
    tam #page(multables)

    ldx #4 ; skip the two first entries
    lda #LOW(multables2)
    sta multablesptr, x
    inx
    lda #HIGH(multables2)
    sta multablesptr, x
    inx

    lda #LOW(multables3)
    sta multablesptr, x
    inx
    lda #HIGH(multables3)
    sta multablesptr, x
    inx

    lda #LOW(multables4)
    sta multablesptr, x
    inx
    lda #HIGH(multables4)
    sta multablesptr, x
    inx

    lda #LOW(multables5)
    sta multablesptr, x
    inx
    lda #HIGH(multables5)
    sta multablesptr, x
    inx

    lda #LOW(multables6)
    sta multablesptr, x
    inx
    lda #HIGH(multables6)
    sta multablesptr, x
    inx

    lda #LOW(multables7)
    sta multablesptr, x
    inx
    lda #HIGH(multables7)
    sta multablesptr, x
    inx

    lda #LOW(multables8)
    sta multablesptr, x
    inx
    lda #HIGH(multables8)
    sta multablesptr, x
    inx

    lda #LOW(multables9)
    sta multablesptr, x
    inx
    lda #HIGH(multables9)
    sta multablesptr, x
    inx

    lda #LOW(multables10)
    sta multablesptr, x
    inx
    lda #HIGH(multables10)
    sta multablesptr, x
    inx

    lda #LOW(multables11)
    sta multablesptr, x
    inx
    lda #HIGH(multables11)
    sta multablesptr, x
    inx

    lda #LOW(multables12)
    sta multablesptr, x
    inx
    lda #HIGH(multables12)
    sta multablesptr, x
    inx

    lda #LOW(multables13)
    sta multablesptr, x
    inx
    lda #HIGH(multables13)
    sta multablesptr, x
    inx

    lda #LOW(multables14)
    sta multablesptr, x
    inx
    lda #HIGH(multables14)
    sta multablesptr, x
    inx

    lda #LOW(multables15)
    sta multablesptr, x
    inx
    lda #HIGH(multables15)
    sta multablesptr, x
    inx

    lda #LOW(multables16)
    sta multablesptr, x
    inx
    lda #HIGH(multables16)
    sta multablesptr, x
    inx

    lda #LOW(multables17)
    sta multablesptr, x
    inx
    lda #HIGH(multables17)
    sta multablesptr, x
    inx

    lda #LOW(multables18)
    sta multablesptr, x
    inx
    lda #HIGH(multables18)
    sta multablesptr, x
    inx

    lda #LOW(multables19)
    sta multablesptr, x
    inx
    lda #HIGH(multables19)
    sta multablesptr, x
    inx

    lda #LOW(multables20)
    sta multablesptr, x
    inx
    lda #HIGH(multables20)
    sta multablesptr, x
    inx

    lda #LOW(multables21)
    sta multablesptr, x
    inx
    lda #HIGH(multables21)
    sta multablesptr, x
    inx

    lda #LOW(multables22)
    sta multablesptr, x
    inx
    lda #HIGH(multables22)
    sta multablesptr, x
    inx

    lda #LOW(multables23)
    sta multablesptr, x
    inx
    lda #HIGH(multables23)
    sta multablesptr, x
    inx

    lda #LOW(multables24)
    sta multablesptr, x
    inx
    lda #HIGH(multables24)
    sta multablesptr, x
    inx

    lda #LOW(multables25)
    sta multablesptr, x
    inx
    lda #HIGH(multables25)
    sta multablesptr, x
    inx

    lda #LOW(multables26)
    sta multablesptr, x
    inx
    lda #HIGH(multables26)
    sta multablesptr, x
    inx

    lda #LOW(multables27)
    sta multablesptr, x
    inx
    lda #HIGH(multables27)
    sta multablesptr, x
    inx

    lda #LOW(multables28)
    sta multablesptr, x
    inx
    lda #HIGH(multables28)
    sta multablesptr, x
    inx

    lda #LOW(multables29)
    sta multablesptr, x
    inx
    lda #HIGH(multables29)
    sta multablesptr, x
    inx

    lda #LOW(multables30)
    sta multablesptr, x
    inx
    lda #HIGH(multables30)
    sta multablesptr, x
    inx

    lda #LOW(multables31)
    sta multablesptr, x
    inx
    lda #HIGH(multables31)
    sta multablesptr, x
    inx

    lda #LOW(multables32)
    sta multablesptr, x
    inx
    lda #HIGH(multables32)
    sta multablesptr, x
    inx


    rts


