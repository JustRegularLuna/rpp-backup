SECTION "bank2F",DATA,BANK[$2F]

RefreshWindow:
	ld a,[H_AUTOBGTRANSFERENABLED]
	and a
	ret z

	ld hl,[sp+$00]
	ld a,h
	ld [$ff00+$bf],a
	ld a,l
	ld [$ff00+$c0],a	; Store stack pointer
	ld a,[$ff00+$bb]
	and a
	jr z,.firstThird
	dec a
	jr z,.secondThird
.thirdThird
	ld hl,W_SCREENTILESBUFFER+6*20*2
	ld sp,hl
	ld a,[$ff00+$bd]
	ld h,a
	ld a,[$ff00+$bc]
	ld l,a
	ld de,$0180
	add hl,de
	xor a
	jr .startCopy
.firstThird:
	ld hl,W_SCREENTILESBUFFER
	ld sp,hl
	ld a,[$ff00+$bd]
	ld h,a
	ld a,[$ff00+$bc]
	ld l,a
	ld a,$01
	jr .startCopy
.secondThird:
	ld hl,W_SCREENTILESBUFFER+6*20
	ld sp,hl
	ld a,[$ff00+$bd]
	ld h,a
	ld a,[$ff00+$bc]
	ld l,a
	ld de,$00c0
	add hl,de
	ld a,$02

; sp now points to map data in wram, hl points to vram destination.
.startCopy:
	ld [$ff00+$bb],a
	ld b,$06

.drawRow:
REPT 10
	pop de
	ld [hl],e
	inc l
	ld [hl],d
	inc l
ENDR

	ld a,$0c
	add l
	ld l,a
	adc h
	sub l
	ld h,a
	dec b
	jp nz,.drawRow


; BEGIN loading palettes

	ld a,$02
	ld [rSVBK],a	; Wram bank 2
	ld a,$01
	ld [rVBK],a

	; This craziness restores sp, and restores de and hl to src and dest maps again.
	ld b,h
	ld c,l
	ld hl,[sp+$00]
	ld de, -20*6
	add hl,de
	ld d,h
	ld e,l

	ld a,[$ff00+$bf]
	ld h,a
	ld a,[$ff00+$c0]
	ld l,a
	ld sp,hl

	ld h,b
	ld l,c
	ld bc, -$c0
	add hl,bc

	ld b,6

	ld a,[W2_TileBasedPalettes]
	and a
	jr nz,tileBasedPalettes

staticMapPalettes:	; Palettes are loaded from a 20x18 grid of palettes
	push hl
	ld h,d
	ld l,e
	ld de,$d200 - W_SCREENTILESBUFFER
	add hl,de
	ld d,h
	ld e,l	; de now points to the appropriate location in the palette grid @ $d200
	pop hl
	
	ld b,6
.drawRow_Pal
	ld c,20
.palLoop
	ld a,[rSTAT]
	and 2
	jr nz,.palLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec c
	jr nz,.palLoop

	ld a,32-20
	add l
	ld l,a
	adc h
	sub l
	ld h,a
	dec b
	jr nz,.drawRow_Pal

	jr palettesDone

tileBasedPalettes:	; Palettes are loaded based on the tile at that location
.drawRow_Pal
	ld c,20
.palLoop
	ld a,[de]
	inc de
	push de
	ld e,a
	ld d,$d2

.waitLoop
	ld a,[rSTAT]
	and $02
	jr nz,.waitLoop

	ld a,[de]
	ld [hli],a
	pop de
	dec c
	jr nz,.palLoop

	ld a,32-20
	add l
	ld l,a
	adc h
	sub l
	ld h,a
	dec b
	jr nz,.drawRow_Pal

palettesDone:

	xor a
	ld [rVBK],a
	ld [rSVBK],a
	ret


RefreshWindowInitial:
label_011:
	ld a,$02
	ld [rSVBK],a
	ld c,$0a
label_012:
	pop de
label_013:
	ld a,[rSTAT]
	bit 1,a
	jr nz,label_013
	ld [hl],e
	inc l
	ld [hl],d
	inc l
	dec c
	jr nz,label_012
	ld c,$14
label_014:
	dec l
	dec c
	jr nz,label_014
	add sp,-$14
	ld a,$01
	ld [$ff00+$4f],a
	ld c,$0a
label_015:
	pop de
	ld d,$d2
label_016:
	ld a,[$ff00+$41]
	bit 1,a
	jr nz,label_016
	ld a,[de]
	ldi [hl],a
	add sp,-$02
	pop de
	ld e,d
	ld d,$d2
label_017:
	ld a,[$ff00+$41]
	bit 1,a
	jr nz,label_017
	ld a,[de]
	ldi [hl],a
	dec c
	jr nz,label_015
	xor a
	ld [$ff00+$4f],a
	ld [$ff00+$70],a
	ld a,$0c
	add l
	ld l,a
	jr nc,label_018
	inc h
label_018:
	dec b
	jr nz,label_011
	ld a,[$ff00+$bf]
	ld h,a
	ld a,[$ff00+$c0]
	ld l,a
	ld sp,hl
	ret

; Refresh map colors, scrolling
	ORG $2f, $6000

	ld a,$02
	ld [rSVBK],a
	ld a,$01
	ld [rVBK],a
	ld a,[hl]
	push hl
	ld h,$d2
	ld l,a
	ld a,[hl]
	ld hl,$ff41
label_019:
	bit 1,[hl]
	jr nz,label_019
	ld [de],a
	pop hl
	xor a
	ld [$ff00+$4f],a
	ld a,[hli]
	push hl
	ld hl,$ff41
label_020:
	bit 1,[hl]
	jr nz,label_020
	ld [de],a
	inc de
	pop hl
	ld a,$01
	ld [$ff00+$4f],a
	ld a,[hl]
	push hl
	ld h,$d2
	ld l,a
	ld a,[hl]
	ld hl,$ff41
label_021:
	bit 1,[hl]
	jr nz,label_021
	ld [de],a
	pop hl
	xor a
	ld [$ff00+$4f],a
	ld [$ff00+$70],a
	ld a,[hli]
	add sp,$04
	push af
	add sp,-$02
	push hl
	ld hl,$ff41
label_022:
	bit 1,[hl]
	jr nz,label_022
	pop hl
	ret

