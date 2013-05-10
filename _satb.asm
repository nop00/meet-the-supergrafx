; clearsatb
clearsatb:
    stz satb       ; set first byte of satb to 0
    tii satb, satb + 1, 511 ; copy this byte in the whole satb (i.e zero out the satb)

    rts


; clearsatb2
clearsatb2:
    stz satb2       ; set first byte of satb to 0
    tii satb2, satb2 + 1, 511 ; copy this byte in the whole satb (i.e zero out the satb)

    rts


; copysatb
copysatb:
    st0 #$00
    st1 #LOW(SATB_START)
    st2 #HIGH(SATB_START)
    st0 #$02

    lda #LOW(satb)
    sta <data_ptr
    lda #HIGH(satb)
    sta <data_ptr + 1

    ldx #255
.copysatb:
    lda [data_ptr]
    sta $0002
    incw <data_ptr
    lda [data_ptr]
    sta $0003
    incw <data_ptr

    dex
    bne .copysatb

    ; copy last word
    lda [data_ptr]
    sta $0002
    incw <data_ptr
    lda [data_ptr]
    sta $0003
 
    ;tia satb, $0002, 512

    st0 #$13
    lda #LOW(SATB_START)
    sta $0002
    lda #HIGH(SATB_START)
    sta $0003

    rts


; copysatb2
copysatb2:

    inc $000E

    st0 #$00
    st1 #LOW(SATB_START)
    st2 #HIGH(SATB_START)
    st0 #$02

    lda #LOW(satb2)
    sta <data_ptr
    lda #HIGH(satb2)
    sta <data_ptr + 1

    ldx #255
.copysatb2:
    lda [data_ptr]
    sta $0012
    incw <data_ptr
    lda [data_ptr]
    sta $0013
    incw <data_ptr

    dex
    bne .copysatb2

    ; copy last word
    lda [data_ptr]
    sta $0012
    incw <data_ptr
    lda [data_ptr]
    sta $0013
 
    ;tia satb2, $0012, 512

    st0 #$13
    lda #LOW(SATB_START)
    sta $0012
    lda #HIGH(SATB_START)
    sta $0013

    stz $000E

    rts


; copysatbslice
; <R0 : offset (in items)
; <R1 : length (in items)
copysatbslice:
    lda <R1
    lbeq .end

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    lda LOW_BYTE #SATB_START
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #SATB_START
    sta HIGH_BYTE <data_ptr


    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    addw #(SATB_ITEM_SIZE / 2), <data_ptr
    dex
    jmp .shift

.aftershift:

    st0 #$00
    lda <data_ptr
    sta $0002
    lda <data_ptr + 1
    sta $0003
    st0 #$02

    ldx <R1
.copy:
    lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr
    lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr
     lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr
    lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr

    dex
    bne .copy
     
    st0 #$13
    lda #LOW(SATB_START)
    sta $0002
    lda #HIGH(SATB_START)
    sta $0003

.end:
    rts

; copysatb2slice
; <R0 : offset (in items)
; <R1 : length (in items)
copysatb2slice:
    inc $000e
    lda <R1
    lbeq .end

    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    lda LOW_BYTE #SATB_START
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #SATB_START
    sta HIGH_BYTE <data_ptr


    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    addw #(SATB_ITEM_SIZE / 2), <data_ptr
    dex
    jmp .shift

.aftershift:

    st0 #$00
    lda <data_ptr
    sta $0012
    lda <data_ptr + 1
    sta $0013
    st0 #$02

    ldx <R1
.copy:
    lda [satb_ptr]
    sta $0012
    incw <satb_ptr
    lda [satb_ptr]
    sta $0013
    incw <satb_ptr
    lda [satb_ptr]
    sta $0012
    incw <satb_ptr
    lda [satb_ptr]
    sta $0013
    incw <satb_ptr
     lda [satb_ptr]
    sta $0012
    incw <satb_ptr
    lda [satb_ptr]
    sta $0013
    incw <satb_ptr
    lda [satb_ptr]
    sta $0012
    incw <satb_ptr
    lda [satb_ptr]
    sta $0013
    incw <satb_ptr

    dex
    bne .copy
     
    st0 #$13
    lda #LOW(SATB_START)
    sta $0012
    lda #HIGH(SATB_START)
    sta $0013

.end:
    stz $000e
    rts


; copytosatb
; <data_ptr : address of the data to copy
; <R0 : offset in satb (in items)
; <R1 : item count 
copytosatb:
    pha
    phx
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:

    ldx <R1
.copy:
    ; y
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; x
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; pointer
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; attributes
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    dex
    lbne .copy

    plx
    pla
    rts

    rts


; copytosatb2
; <data_ptr : address of the data to copy
; <R0 : offset in satb (in items)
; <R1 : item count 
copytosatb2:
    pha
    phx
    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:

    ldx <R1
.copy:
    ; y
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; x
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; pointer
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; attributes
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    dex
    lbne .copy

    plx
    pla
    rts

    rts


; getsatbx
; <satb_ptr : address of the item from which to read
; outputs in <R0
getsatbx:
    incw <satb_ptr
    incw <satb_ptr
    lda [satb_ptr]
    sta LOW_BYTE <R0
    incw <satb_ptr
    lda [satb_ptr]
    sta HIGH_BYTE <R0

    rts


; setsatbpalette
; <R0 : item number
; <R1 : palette number to set
setsatbpalette:
    phx
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift
.aftershift:

    ; advance 3 words
    addw #6, <satb_ptr

    lda [satb_ptr]
    and #%11110000
    ora <R1
    sta [satb_ptr]

    plx
    rts


; setsatbbg
; <R0 : item number
; <R1 : 1 = foreground, 0 = background
setsatbbg:
    phx
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    lda <R1
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    sta <R1

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift
.aftershift:

    ; advance 3 words
    addw #6, <satb_ptr

    lda [satb_ptr]
    and #%01111111
    ora <R1
    sta [satb_ptr]

    plx
    rts


; defragmentsatb
; <satb_ptr : address of satb
; <R0 : offset of the item to begin the copy with (in items) (will copy from there to the end of the satb)
; <R1 : offset of the item to which we copy (in items)
defragmentsatb:
    phx
    lda LOW_BYTE <satb_ptr
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <satb_ptr
    sta HIGH_BYTE <data_ptr


    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <data_ptr
    dex
    bra .shift
.aftershift:

    ; copy from <data_ptr to 512 in <satb_ptr
    ; copy length = 512 - offset + count * item_size
    addw <R1, <R0
 
    stz <R4
    stz <R4 + 1

    ldx <R0
.add:
    beq .afteradd
    addw #SATB_ITEM_SIZE, <R4
    dex
    bra .add
.afteradd:

    lda #LOW(512)
    sta LOW_BYTE <R3
    lda #HIGH(512)
    sta HIGH_BYTE <R3

    subw <R4, <R3

    ; <R3 = byte count to copy
.copy:
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr

    decw <R3
    cmpw #0, <R3
    bne .copy

    plx
    rts


; writesatbitem
; <satb_ptr : where to write
; <R0 : x coordinate
; <R1 : y coordinate
; <vram_ptr ; address of the pixels in VRAM
writesatbitem:
    ; y position
    lda LOW_BYTE <R1
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <R1
    sta [satb_ptr]
    incw <satb_ptr

    ; x position
    lda LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr

    ; sprite address in VRAM
    lda LOW_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr

    ; sprite attributes
    lda #%10000000
    sta [satb_ptr]
    incw <satb_ptr
    cla
    sta [satb_ptr]
    incw <satb_ptr

    rts


; satbshiftx
; <R0 : amount to add or subtract to the x coordinate
; <R1 : 1 = increment, 0 = decrement
; <R2 : number of satb items to shift
; <R3 : offset of the items to begin with (in items)
satbshiftx:
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:


    incw <satb_ptr ; advance the pointer to the x coordinate slot
    incw <satb_ptr ; advance the pointer to the x coordinate slot

    ldx <R2
.loop:
    lda <R1
    beq .decrement
.increment:
    clc
    lda [satb_ptr]
    adc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    adc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    bra .end
.decrement:
    sec
    lda [satb_ptr]
    sbc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    sbc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
 

.end:
    addw #6, <satb_ptr

    dex
    bne .loop

    plx
    pla
    rts


; satb2shiftx
; <R0 : amount to add or subtract to the x coordinate
; <R1 : 1 = increment, 0 = decrement
; <R2 : number of satb items to shift
; <R3 : offset of the items to begin with (in items)
satb2shiftx:
    pha
    phx

    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:


    incw <satb_ptr ; advance the pointer to the x coordinate slot
    incw <satb_ptr ; advance the pointer to the x coordinate slot

    ldx <R2
.loop:
    lda <R1
    beq .decrement
.increment:
    clc
    lda [satb_ptr]
    adc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    adc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    bra .end
.decrement:
    sec
    lda [satb_ptr]
    sbc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    sbc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
 

.end:
    addw #6, <satb_ptr

    dex
    bne .loop

    plx
    pla
    rts


; setsatby
; <R0 : y coordinate value
; <R3 : item number to write to
setsatby:
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    plx
    pla
    rts


; setsatbx
; <R0 : y coordinate value
; <R3 : item number to write to
setsatbx:
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    incw <satb_ptr
    incw <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    plx
    pla
    rts

; setsatb2y
; <R0 : y coordinate value
; <R3 : item number to write to
setsatb2y:
    pha
    phx

    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    plx
    pla
    rts


; setsatb2x
; <R0 : y coordinate value
; <R3 : item number to write to
setsatb2x:
    pha
    phx

    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    incw <satb_ptr
    incw <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    plx
    pla
    rts

; setsatbcoords
; <R0 : x coordinate value
; <R1 : y coordinate value
;; <R2 : attributes
; <data_ptr : pointer to the SATB item to write to
; advances <data_ptr to the next SATB item
setsatbcoords:
    pha

    ; write y
    lda <R1
    sta [satb_ptr]
    incw <satb_ptr
    lda <R1 + 1
    sta [satb_ptr]
    incw <satb_ptr

    ; write x
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    addw #5, <satb_ptr

;    ; write attributes
    ;lda <R2
    ;sta [satb_ptr]
    ;incw <satb_ptr
    ;lda <R2 + 1
    ;sta [satb_ptr]
    ;incw <satb_ptr

    pla
    rts


;
; satbshifty
; <R0 : amount to add or subtract to the x coordinate
; <R1 : 1 = increment, 0 = decrement
; <R2 : number of satb items to shift
; <R3 : offset of the items to begin with (in items)
satbshifty:
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:


    ldx <R2
.loop:
    lda <R1
    beq .decrement
.increment:
    clc
    lda [satb_ptr]
    adc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    adc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    bra .end
.decrement:
    sec
    lda [satb_ptr]
    sbc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    sbc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
 

.end:
    addw #6, <satb_ptr

    dex
    bne .loop

    plx
    pla
    rts


; satb2shifty
; <R0 : amount to add or subtract to the x coordinate
; <R1 : 1 = increment, 0 = decrement
; <R2 : number of satb items to shift
; <R3 : offset of the items to begin with (in items)
satb2shifty:
    pha
    phx

    lda LOW_BYTE #satb2
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb2
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:


    ldx <R2
.loop:
    lda <R1
    beq .decrement
.increment:
    clc
    lda [satb_ptr]
    adc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    adc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    bra .end
.decrement:
    sec
    lda [satb_ptr]
    sbc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    sbc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
 

.end:
    addw #6, <satb_ptr

    dex
    bne .loop

    plx
    pla
    rts


