    .macro vramtovram ; param #1 = source address, param #2 = destination address, param #3 = length in words
    ; setup read pointer
    st0 #$01
    lda LOW_BYTE \1
    sta $0002
    lda HIGH_BYTE \1
    sta $0003
    ; setup write pointer
    st0 #$00
    lda LOW_BYTE \2
    sta $0002
    lda HIGH_BYTE \2
    sta $0003

    st0 #$02

    ldx \3
.x\@:
    lda $0002
    sta $0002
    lda $0003
    sta $0003
    dex
    bne .x\@
    .endm


