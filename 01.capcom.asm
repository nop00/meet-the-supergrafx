    .include "d01.capcom.code.asm"

capcom:
    jsr capcom_load

    lda #LOW(blackpalette)
    sta <data_ptr
    lda #HIGH(blackpalette)
    sta <data_ptr + 1

    stz <R0
    jsr loadpalette


    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <frame_skip_counter

    ; prepare sound channel #1
    jsr init_channels

;   timer setup
    lda #$00  ;bonk puts d0 oO
    sta $c00
    lda #$01  ;bonk puts 03 oO
    sta $c01

    lda #bank(capcom_jingle)
    sta <music_start_bank
    stz <music_loop
    jsr play_sample

    st0 #$09        ; set the BAT size to 128x32 tiles
    st1 #%00110000
    st2 #$00


    lda #bank(d01.capcom_data00)
    tam #page(d01.capcom_data00)

.wait:
    jsr wait_vsync

    cmpw #90, <frame_counter
    bcs .afterfadein
    cmpw #60, <frame_counter
    bcc .afterfadein
    bne .noresetskipframe
    stz <frame_skip_counter
    copypalette #blackpalette, palette
.noresetskipframe:
    lda <frame_skip_counter
    cmp #4
    bne .afterfadein
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #d01.capcom_palette00
    sta <R1
    lda HIGH_BYTE #d01.capcom_palette00
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    stz <R0
    jsr loadpalette




.afterfadein:

    cmpw #125, <frame_counter
    bcc .level0
    cmpw #165, <frame_counter
    bcs .level0
    cmpw #128, <frame_counter
    bcc .level1
    cmpw #129, <frame_counter
    bcc .level2
    cmpw #132, <frame_counter
    bcc .level3
    cmpw #133, <frame_counter
    bcc .level2
    cmpw #136, <frame_counter
    bcc .level1

.level0:
    stz <R10
    stz <R10 + 1
    bra .setvalue
.level1:
    stz <R10
    lda #1
    sta <R10 + 1
    bra .setvalue
.level2:
    stz <R10
    lda #2
    sta <R10 + 1
    lda #86
    bra .setvalue
.level3:
    stz <R10
    lda #3
    sta <R10 + 1

.setvalue:
    st0 #$07
    lda <R10
    sta $0002
    lda <R10 + 1
    sta $0003



    ; fade to black
    cmpw #330, <frame_counter
    bcs .end
    cmpw #300, <frame_counter
    bcc .end
    bne .noresetskipframe2
    copypalette #d01.capcom_palette00, palette
    stz <frame_skip_counter
.noresetskipframe2:
    lda <frame_skip_counter
    cmp #4
    bne .end
    stz <frame_skip_counter
    ; fade palettes
    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1

    lda LOW_BYTE #blackpalette
    sta <R1
    lda HIGH_BYTE #blackpalette
    sta <R1 + 1

    jsr fadepalette

    lda #LOW(palette)
    sta <data_ptr
    lda #HIGH(palette)
    sta <data_ptr + 1

    stz <R0
    jsr loadpalette



.end:
    inc <frame_skip_counter
    incw <frame_counter

    ; change the value here to control the duration of your effect
    cmpw #(7 * 60), <frame_counter
    lblo .wait

    ; stop timer interrupt
    lda #$00
    sta $c01

    jsr clearbg
    st0 #$09        ; set the BAT size to 32x32 tiles
    st1 #%00000000
    st2 #$00


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

capcom_load:
    jsr d01.capcom_load_VDC1

    ;copypalette #blackpalette, palette

    ;lda #LOW(blackpalette)
    ;sta <data_ptr
    ;lda #HIGH(blackpalette)
    ;sta <data_ptr + 1
    ;stz <R0
    ;jsr loadpalette

    ;copypalette #D01.capcom.data_palette00, palette
    ;copypalette #D01.capcom.data_palette01, palette + PALETTE_SIZE * 1
    ;copypalette #D01.capcom.data_palette02, palette + PALETTE_SIZE * 2
    ;copypalette #D01.capcom.data_palette03, palette + PALETTE_SIZE * 3
    ;copypalette #D01.capcom.data_palette04, palette + PALETTE_SIZE * 4
    ;copypalette #D01.capcom.data_palette05, palette + PALETTE_SIZE * 5
    ;copypalette #D01.capcom.data_palette06, palette + PALETTE_SIZE * 6

    rts



