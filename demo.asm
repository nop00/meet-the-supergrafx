DEBUG .equ 0
SGX .equ 1
TILE_START .equ $1000   ; 4800 words for tiles = 1152 tiles max
TILE_SIZE .equ $10      ; in words
SPRITE_START .equ $5800 ; $2e00 words for sprites = 152 sprites max
SPRITE_SIZE .equ $40    ; in words
SATB_START .equ $7e00   ; the SATB is located at the end of the vram
SATB_ITEM_SIZE .equ $08 ; in bytes
PALETTE_SIZE .equ $20   ; in bytes
TRANSITION_TILE_START .equ $34e0
GFX_START_BANK .equ $40
FONT_START .equ $6f00   ; reserve 60 sprites at end of memory for a font


    .zp
vdc_status_register: .ds 1
vdc2_status_register: .ds 1
vdc_current_scanline:.ds 2
frame_counter:.ds 2
frame_skip_counter:.ds 1
scanline_handler:   .ds 2

in_timer_int:   .ds 1
timer_counter:  .ds 2
MR0: .ds 2 ; comme R0, mais réservé à l'usage des macros
MR1: .ds 2 ; comme R1, mais réservé à l'usage des macros
MR2: .ds 2 ; comme R2, mais réservé à l'usage des macros
MR3: .ds 2 ; comme R3, mais réservé à l'usage des macros
r: .ds 1
g: .ds 1
b: .ds 1
R0: .ds 2
R1: .ds 2
R2: .ds 2
R3: .ds 2
R4: .ds 2

R10: .ds 2
R11: .ds 2
R12: .ds 2
R13: .ds 2
R14: .ds 2

data_ptr:   .ds 2
vram_ptr:   .ds 2
satb_ptr:   .ds 2
music_play: .ds 1
music_ptr:  .ds 2
music_counter:  .ds 2
music_bank: .ds 1
music_start_bank: .ds 1
music_loop: .ds 1

sound_level:.ds 1

music_offset:  .ds 2
music_register: .ds 2

vgm_play: .ds 1


        .bss
satb:          .ds 512
satb2:          .ds 512
palette:       .ds PALETTE_SIZE * 7
; for 20.greetings
offsets        .ds 16
; for 07.sprites
poulpe_palettes:    .ds 51 * 2
; for 04.preamble
STAR_COUNT .equ 128
starslast:       .ds 256 ; last x, y for 128 stars
; for 11.twisters
multablesptr:       .ds 2 * 33
finaltextcoords:    .ds 2 * 64
textslices:         .ds 2 * 10 ; <offset>, <letter count>, <offset>, <letter count>, etc
textslicesstate:    .ds 2 * 10 ; <movement offset>, <done>, <movement offset>, <done>, etc


    .code
    .bank $00
    .org $e000
    .include "_macrosbase.asm"
    .include "_font.asm"
    .include "_funcs.asm"
    .include "_palette.asm"
    .include "_satb.asm"
    .include "_sprites.asm"
    .include "_tiles.asm"
    .include "_sound.asm"
    .include "_vram.asm"
    .include "_pixels.asm"

    ; your effects go here
    .include "01.capcom.asm"
    .include "02.presents.asm"
    .include "03.title.asm"
    .include "04.preamble.asm"

startup:
    sei             ; disable interrupts
    csh             ; set cpu to 7.16Mhz ultra turbo mode :)
	cld 			; clear the decimal flag 
    ldx #$ff
    txs             ; initialise the stack
    lda #$ff
    tam #$00        ; map hardware bank ($ff) to MPR0
    lda #$f8
    tam #$01        ; map ram bank ($f8) to MPR1

    stz $2000       ; set first byte of ram to 0
    tii $2000, $2001, $1fff ; copy this byte in the whole ram (i.e zero out the ram)

    st0 #$05        ; activate bg and sprite planes, and vertical and horizontal blanking
    lda #%11001100
    sta $0002
    st2 #$00

    st0 #$09        ; set the BAT size to 32x32 (tiles, not pixels :) )
    st1 #$00
    st2 #$00

    ; setup 256x242 display mode (values are shamelessly ripped from Bonk's Revenge)
    st0 #$0A
    st1 #$02
    st2 #$02

    st0 #$0B
    .if (DEBUG)
    st1 #$1e ; 1f
    st2 #$01 ; 04
    .else
    st1 #$1f
    st2 #$04
    .endif

    st0 #$0C
    st1 #$02
    st2 #$0F

    st0 #$0D
    st1 #$ef
    st2 #$00

    st0 #$0E
    st1 #$04
    st2 #$00

    st0 #$0f
    st1 #$00
    st2 #$00


    .if (SGX)
    ; --same shit but for vdc #2
    lda #$01
    sta $000E

    st0 #$05        ; activate bg and sprite planes, and vertical and horizontal blanking
    lda #%11001100
    sta $0012
    st2 #$00

    st0 #$09        ; set the BAT size to 32x32 (tiles, not pixels :) )
    st1 #$00
    st2 #$00

    ; setup 256x242 display mode (values are shamelessly ripped from Bonk's Revenge)
    st0 #$0A
    st1 #$02
    st2 #$02

    st0 #$0B
    .if (DEBUG)
    st1 #$1e ; 1f
    st2 #$01 ; 04
    .else
    st1 #$1f
    st2 #$04
    .endif

    st0 #$0C
    st1 #$02
    st2 #$0F

    st0 #$0D
    st1 #$ef
    st2 #$00

    st0 #$0E
    st1 #$04
    st2 #$00

    st0 #$0f
    st1 #$00
    st2 #$00

    stz $000E


    lda #$04
    sta $400

    lda #%01110111
    sta $0008
    sta $0009

    stz $000A
    stz $000B
    stz $000C
    stz $000D
    .endif

    ; map the memory location of our data
    lda #bank(commondata)
    tam #page(commondata)

    ; map the memory location of our additional code
    lda #bank(additionalcode)
    tam #page(additionalcode)

    ; we don't use irq2 int so we mask it
    lda #$00000001
    sta $1402

    cli
main:
    jsr clearbg
    jsr clearsatb
    jsr copysatb
    .if (SGX)
    jsr clearbg2
    jsr clearsatb2
    jsr copysatb2
    .endif
 
; uncomment for a one second blank at the beginning of the demo
    ldx #60
.wait01:
    jsr wait_vsync
    dex
    bne .wait01

    ; run your effects here
    jsr capcom
    jsr presents
    jsr title
    jsr preamble
    jsr cpu
    jsr background
    jsr sprites
    jsr parsley
    jsr greets
    jsr twisters
    jsr credits
    jsr goodbye


    ;jmp startup


_timer:
    pha
    phx
    phy
    stz $1403 ; during a timer interrupt, we HAVE to write to this register to acknowledge the interrupt

    lda <music_play
    beq ._endtimer

; play that funky music, white boy
    stz $800                                            ; 5
    lda <music_start_bank                               ; 2
    clc                                                 ; 2
    adc <music_bank                                     ; 4
    tax

    tma #page(capcom_jingle)                          ; 4
    pha                                                 ; 3
    txa
    tam #page(capcom_jingle)                          ; 5
      
    lda [music_ptr]                                     ; 7
    tax

    pla                                                 ; 4
    tam #page(capcom_jingle)                          ; 5

    cpx #$00
    bne .outputsound
.loopsample:
    lda <music_loop
    beq ._stop_music_play
    stz <music_ptr                                      ; 5
    lda #$40                                            ; 2
    sta <music_ptr + 1                                  ; 4
    stz <music_counter                                  ; 5
    stz <music_counter + 1                              ; 5
    stz <music_bank                                     


.outputsound:
    txa
    lsr a
    lsr a
    lsr a
    ldy #$01
    sty $800
    sta $806                                            ; 5

    txa
    asl a
    asl a
    stz $800
    sta $806



    incw <music_ptr                                     ; 10-14
    incw <music_counter                                 ; 10-14
    cmpw <music_counter, #$2000                         ; 12-18
    bne ._endtimer                                      ; 2-4

    stz <music_ptr                                      ; 5
    lda #$40                                            ; 2
    sta <music_ptr + 1                                  ; 4
    stz <music_counter                                  ; 5
    stz <music_counter + 1                              ; 5
    inc <music_bank                                     ; 6


._endtimer:
    ply
    plx
    pla
    rti

._stop_music_play:
    stz <music_play
    bra ._endtimer


_irq2:
    rti

_vdc:
    pha
    .if (SGX)
    lda $0010
    ;sta <vdc2_status_register
    .endif

    lda $0000 ; during a VDC interrupt, we HAVE to read this register (the VDC status register) to acknowledge the interrupt, else we'll be stuck here forever
    sta <vdc_status_register
    pla
    bbr5 <vdc_status_register, .scanline_test
    jsr readvgm
.scanline_test:
    bbs2 <vdc_status_register, _vdc_scanline

    rti

_vdc_scanline:
    pha
    lda LOW_BYTE <scanline_handler
    bne .goscanline
    lda HIGH_BYTE <scanline_handler
    beq ._default_scanline
.goscanline:
    pla
    ; !!! rti has to be done in [scanline_handler] !!!
    jmp [scanline_handler]
._default_scanline
    pla
    rti

_nmi:
    rti

    .data

    ; set interrupt handlers
    .org $fff6
    .dw _irq2
    .dw _vdc
    .dw _timer
    .dw _nmi
    .dw startup     ; RESET, which is called when the console boots, so this must map to our startup code

    .code

    .bank $01
    .org $c000
commondata:
    .include "common.asm"
    .include "05.cpu.asm"
    .include "06.background.asm"
    .include "07.sprites.asm"
    .include "09.parsley.asm"

    .bank $02
    .org $a000
additionalcode:
    .include "11.twisters.asm"
    .include "20.greets.asm"
    .include "20b.credits.asm"
    .include "21.goodbye.asm"

    .bank $04
    .org $4000
d04.stars.path1:
    .include "d04.stars.path1.asm"

    .bank $05
    .org $4000
d04.stars.path2:
    .include "d04.stars.path2.asm"

    .bank $06
    .org $4000
d04.stars.path3:
    .include "d04.stars.path3.asm"

    .bank $07
    .org $4000
d04.stars.path4:
    .include "d04.stars.path4.asm"

    .bank $08
    .org $4000
d04.stars.path5:
    .include "d04.stars.path5.asm"

    .bank $09
    .org $4000
d04.stars.path6:
    .include "d04.stars.path6.asm"

    .bank $10
    .org $4000
d20b.additional:
    .include "d20b.additional.asm"

    .bank $11
    .org $4000
multables:
    .include "d11.multables.asm"

    .bank $12
    .org $4000
d07.additional:
    .include "d07.additional.asm"

    .bank $13
    .org $8000
d11.additional:
    .include "d11.additional.asm"


    .bank $15
    .org $6000
music:
    .incbin "MeetTheSuperGrafx.vgm"


    .bank $30
    .org $4000
capcom_jingle:
    .incbin "d01.capcom.raw"

    .include "demo.data.banks.asm"

