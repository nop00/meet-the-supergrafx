wait_vsync:
    bbr5 <vdc_status_register, wait_vsync
    stz <vdc_status_register
    rts

; pompé de Magic Kit
;
; Long branch MACROs
;

lbne	.macro
	 beq	.x_\@
	 jmp	\1
.x_\@
	.endm

lbeq	.macro
	 bne	.x_\@
	 jmp	\1
.x_\@
	.endm

lbmi	.macro
	 bpl	.x_\@
	 jmp	\1
.x_\@
	.endm

lbpl	.macro
	 bmi	.x_\@
	 jmp	\1
.x_\@
	.endm

lbcc	.macro
	 bcs	.x_\@
	 jmp	\1
.x_\@
	.endm

lbcs	.macro
	 bcc	.x_\@
	 jmp	\1
.x_\@
	.endm

lblo	.macro
	 bcs	.x_\@
	 jmp	\1
.x_\@
	.endm

lbhs	.macro
	 bcc	.x_\@
	 jmp	\1
.x_\@
	.endm



incw	.macro			; increment a word-sized
	 inc	\1		; value at stated memory
	 bne	.x_\@		; location
	 inc	\1+1
.x_\@:
	.endm

decw	.macro			; decrement a word-sized
	 sec			; value at stated memory
	 lda	\1		; location
	 sbc	#1
	 sta	\1
	 lda	\1+1
	 sbc	#0
	 sta	\1+1
	.endm

cmpw	.macro
	 lda	HIGH_BYTE \2
	 cmp	HIGH_BYTE \1
	 bne	.x_\@
	 lda	LOW_BYTE \2
	 cmp	LOW_BYTE \1
.x_\@:
	.endm

;
; ADDW - add word-sized value to value at stated memory location,
;        storing result back into stated memory location (or into
;        another destination memory location - third arg)
;
addw	.macro
	.if	(\# = 3)
	 ; 3-arg mode
	 ;
	 clc
	 lda	LOW_BYTE \2
	 adc	LOW_BYTE \1
	 sta	LOW_BYTE \3
	 lda	HIGH_BYTE \2
	 adc	HIGH_BYTE \1
	 sta	HIGH_BYTE \3
	.else
	 ; 2-arg mode
	 ;
	 clc
	 lda	LOW_BYTE \2
	 adc	LOW_BYTE \1
	 sta	LOW_BYTE \2
	 lda	HIGH_BYTE \2
	 adc	HIGH_BYTE \1
	 sta	HIGH_BYTE \2
	.endif
	.endm

;
; SUBW - substract word-sized value from value at stated memory location,
;        storing result back into stated memory location
;
subw	.macro
	 sec
	 lda	LOW_BYTE \2
	 sbc	LOW_BYTE \1
	 sta	LOW_BYTE \2
	 lda	HIGH_BYTE \2
	 sbc	HIGH_BYTE \1
	 sta	HIGH_BYTE \2
	.endm


aslw	.macro			; arithmetic shift-left
	 asl	\1		; word-sized value (at stated
	 rol	\1+1		; memory location)
	.endm

lsrw	.macro			; logical shift-right word-sized
	 lsr	\1+1		; value (at stated memory
	 ror	\1		; location)
	.endm

neg	.macro			; negate byte-sized value
	 eor	#$FF		; in register A
	 inc	A		; 2's complement
	.endm

not	.macro			; invert byte-sized value
	 eor	#$FF		; in register A
	.endm



