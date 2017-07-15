; Called when a map is loaded. Loads tilemap and tile attributes.
LoadMapVramAndColors:
	ld a,$02
	ld [rSVBK],a

	coord hl, 0, 0
	ld de,vBGMap0
	ld b,18
.vramCopyLoop
	ld c,20
.vramCopyInnerLoop
	ld a,$01
	ld [rVBK],a
	ld a,[hl]
	push hl
	ld h,W2_TilesetPaletteMap>>8
	ld l,a
	ld a,[hl]
	ld [de],a
	pop hl
	xor a
	ld [rVBK],a
	ld a,[hli]
	ld [de],a
	inc e

	dec c
	jr nz,.vramCopyInnerLoop
	ld a,32 - 20
	add e
	ld e,a
	jr nc,.noCarry
	inc d
.noCarry
	dec b
	jr nz,.vramCopyLoop

	xor a
	ld [rSVBK],a
	ret



; Refresh 1/3 of the window each frame
RefreshWindow:
	ld a,[H_AUTOBGTRANSFERENABLED]
	and a
	ret z

	ld hl,[sp + 0]
	ld a,h
	ld [H_SPTEMP],a
	ld a,l
	ld [H_SPTEMP+1],a	; Store stack pointer
	ld a,[H_AUTOBGTRANSFERPORTION]
	and a
	jr z,.transferTopThird
	dec a
	jr z,.transferMiddleThird
.transferBottomThird
	coord hl, 0, 12
	ld sp,hl
	ld a,[H_AUTOBGTRANSFERDEST+1]
	ld h,a
	ld a,[H_AUTOBGTRANSFERDEST]
	ld l,a
	ld de,(12 * 32)
	add hl,de
	xor a ; TRANSFERTOP
	jr .doTransfer
.transferTopThird
	coord hl, 0, 0
	ld sp,hl
	ld a,[H_AUTOBGTRANSFERDEST+1]
	ld h,a
	ld a,[H_AUTOBGTRANSFERDEST]
	ld l,a
	ld a,TRANSFERMIDDLE
	jr .doTransfer
.transferMiddleThird
	coord hl, 0, 6
	ld sp,hl
	ld a,[H_AUTOBGTRANSFERDEST+1]
	ld h,a
	ld a,[H_AUTOBGTRANSFERDEST]
	ld l,a
	ld de,(6 * 32)
	add hl,de
	ld a,TRANSFERBOTTOM

; sp now points to map data in wram, hl points to vram destination.
.doTransfer
	ld [H_AUTOBGTRANSFERPORTION],a
	ld b,6

.drawRow:
REPT 9
	pop de
	ld [hl],e
	inc l
	ld [hl],d
	inc l
ENDR
	pop de
	ld [hl],e
	inc l
	ld [hl],d
	; Don't inc l this time.
	; Careful here, because credits break due to carry if you inc l and add a
	; with 12 instead of 13.

	ld a,13
	add l
	ld l,a
	jr nc,.noCarry
	inc h
.noCarry
	dec b
	jr nz,.drawRow

	; Restore sp and set hl to point to destination again
	ld b,h
	ld c,l

	ld a,[H_SPTEMP]
	ld h,a
	ld a,[H_SPTEMP+1]
	ld l,a
	ld sp,hl

	ld h,b
	ld l,c
	ld bc, -$c0
	add hl,bc

; BEGIN loading palettes

	ld a,1
	ld [rVBK],a
	inc a
	ld [rSVBK],a

	ld a,[W2_TileBasedPalettes]
	and a
	jr nz,.continue

	ld a,[W2_StaticPaletteMapChanged_vbl]
	and a
	jr z, .palettesDone
	xor a
	ld [W2_StaticPaletteMapChanged_vbl],a

.continue

	; DMA from W2_ScreenPalettesBuffer to hl (window attribute map)
	ld c,$51
	ld a, W2_ScreenPalettesBuffer>>8
	ld [$ff00+c],a
	inc c
	ld a, W2_ScreenPalettesBuffer&$ff
	ld [$ff00+c],a
	inc c
	ld a, h
	ld [$ff00+c],a
	inc c
	ld a, l
	ld [$ff00+c],a
	inc c

	ld a, 6*32/$10-1
	ld [$ff00+c],a ; Start DMA transfer

.palettesDone
	xor a
	ld [rVBK],a
	ld [rSVBK],a
	ret


; Not sure why this is needed
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
	ld [$ff4f],a
	ld c,$0a
label_015:
	pop de
	ld d,$d2
label_016:
	ld a,[$ff41]
	bit 1,a
	jr nz,label_016
	ld a,[de]
	ldi [hl],a
	add sp,-$02
	pop de
	ld e,d
	ld d,$d2
label_017:
	ld a,[$ff41]
	bit 1,a
	jr nz,label_017
	ld a,[de]
	ldi [hl],a
	dec c
	jr nz,label_015
	xor a
	ld [$ff4f],a
	ld [$ff70],a
	ld a,$0c
	add l
	ld l,a
	jr nc,label_018
	inc h
label_018:
	dec b
	jr nz,label_011
	ld a,[H_SPTEMP]
	ld h,a
	ld a,[H_SPTEMP+1]
	ld l,a
	ld sp,hl
	ret


DrawMapRow:
	ld hl,wRedrawRowOrColumnSrcTiles
	ld a,[hRedrawRowOrColumnDest]
	ld e,a
	ld a,[hRedrawRowOrColumnDest + 1]
	ld d,a
	push de
	call .drawHalf ; draw upper half
	pop de
	ld a,32 ; width of VRAM background map
	add e
	ld e,a
	call .drawHalf ; draw lower half

	; Start drawing palettes
	ld a,2
	ld [rSVBK],a
	ld a,1
	ld [rVBK],a
	ld hl,wRedrawRowOrColumnSrcTiles
	ld a,[hRedrawRowOrColumnDest]
	ld e,a
	ld a,[hRedrawRowOrColumnDest + 1]
	ld d,a

	push de
	call .drawHalfPalette ; draw upper half
	pop de
	ld a,32 ; width of VRAM background map
	add e
	ld e,a
	call .drawHalfPalette ; draw lower half

	xor a
	ld [rSVBK],a
	ld [rVBK],a
	ret

.drawHalf
	ld c,10
.loop2
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,e
	inc a
; the following 6 lines wrap us from the right edge to the left edge if necessary
	and a,$1f
	ld b,a
	ld a,e
	and a,$e0
	or b
	ld e,a
	dec c
	jr nz,.loop2
	ret

.drawHalfPalette
	ld b, $d2
REPT 10
	ld a,[hli]
	ld c,a
	ld a,[bc]
	ld [de],a
	inc de
	ld a,[hli]
	ld c,a
	ld a,[bc]
	ld [de],a
	ld a,e
	inc a
; the following 6 lines wrap us from the right edge to the left edge if necessary
	and a,$1f
	ld c,a
	ld a,e
	and a,$e0
	or c
	ld e,a
ENDR
	ret


DrawMapColumn:
	; Draw tiles
	ld hl,wRedrawRowOrColumnSrcTiles
	ld a,[hRedrawRowOrColumnDest]
	ld e,a
	ld a,[hRedrawRowOrColumnDest + 1]
	ld d,a
	ld c,SCREEN_HEIGHT
.loop1
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,31
	add e
	ld e,a
jr nc,.noCarry
	inc d
.noCarry
; the following 4 lines wrap us from bottom to top if necessary
	ld a,d
	and a,$03
	or a,$98
	ld d,a
	dec c
	jr nz,.loop1

; =======================
	; Draw palettes
	ld a,2
	ld [rSVBK],a
	ld a,1
	ld [rVBK],a

	ld hl,wRedrawRowOrColumnSrcTiles
	ld a,[hRedrawRowOrColumnDest]
	ld e,a
	ld a,[hRedrawRowOrColumnDest + 1]
	ld d,a
	ld b,$d2
REPT 18
	ld a,[hli]
	ld c,a
	ld a,[bc]
	ld [de],a
	inc de
	ld a,[hli]
	ld c,a
	ld a,[bc]
	ld [de],a
	ld a,31
	add e
	ld e,a
	jr nc,.noCarry\@
	inc d
.noCarry\@
; the following 4 lines wrap us from bottom to top if necessary
	ld a,d
	and a,$03
	or a,$98
	ld d,a
ENDR

	xor a
	ld [hRedrawRowOrColumnMode],a
	ld [rVBK],a
	ld [rSVBK],a
	ret
