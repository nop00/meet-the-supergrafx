; init channel #1 and #2 for 10bit DDA
init_channels:
      lda #$ff  ; global balance set equally for left and right
      sta $801

      cla
      sta $800  ; init channel #1

      stz $802
      stz $803

      lda #%11001011 ; channel on, dda on, chan volume to $0B (we'll play the lower half here)
      sta $804

      lda #$ff  ; channel balance set equally for left and right
      sta $805


      lda #$01
      sta $800  ; init channel #2

      stz $802
      stz $803

      lda #%11011111 ; channel on, dda on, chan volume to $1F (we'll play the upper half here)
      sta $804

      lda #$ff  ; channel balance set equally for left and right
      sta $805


      lda #$02  ; mute channels #3 to #6
      sta $800
      stz $804

      inc a
      sta $800
      stz $804

      inc a
      sta $800
      stz $804

      inc a
      sta $800
      stz $804

    rts

; sample call
; lda #bank(typewriter)
; sta <music_bank_start
; stz <music_loop
; jsr play_sample
play_sample:    ; sample bank in <music_start_bank
                ; <music_loop can be set to 1 or 0
    stz <music_ptr                                      ; 5
    lda #$40                                            ; 2
    sta <music_ptr + 1                                  ; 4
    stz <music_counter                                  ; 5
    stz <music_counter + 1                              ; 5
    stz <music_bank                                     

    lda #1
    sta <music_play

    rts

setmusicbank .macro
    incw <music_offset
    ;cmpw #$8000, <music_offset
    lda <music_offset + 1
    cmp #$80
    bne .end\@
    inc <music_bank

    lda #LOW(music)
    sta <music_offset
    lda #HIGH(music)
    sta <music_offset + 1

    lda <music_bank
    tam #page(music)
.end\@:
    .endm

readvgm:
    pha
    ;tma #page(effect_data)
    ;pha

    lda <vgm_play
    lbeq .end

    lda <music_bank
    tam #page(music)

    ; read $6000 + music_offset (in fact music_offset starts at $6000)
.readloop:
    lda [music_offset]

    cmp #$b9
    bne .test62

    ; base register = $0800
    stz <music_register
    lda #$08
    sta <music_register + 1

    ; read next byte, which is the register to write to
    setmusicbank

    lda [music_offset]
    sta <music_register
    ; read next byte, which is the value to write
    setmusicbank
    lda [music_offset]
    sta [music_register]

    setmusicbank

    bra .readloop

.test62: ; 62 => we're done for this frame
    cmp #$62
    beq .exitreadloop

    ; not b9 or 62 ? then it must be 66 => stop the music
.handle66:
    stz <vgm_play

; uncomment this if you want to loop the music instead
;    lda #LOW(music)
    ;sta <music_offset
    ;lda #HIGH(music)
    ;sta <music_offset + 1

    ;decw <music_offset ; because setmusicbank will incw it

    ;lda #bank(music)
    ;sta <music_bank
    ;tam #page(music)

.exitreadloop:
    setmusicbank

    ;pla
    ;tam #page(effect_data)

.end:
    pla
    rts


