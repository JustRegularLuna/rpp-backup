SECTION "bank2D",DATA[$4000],BANK[$2D]

BgPalettes:
	INCBIN "color/bank2d.bin",$0000,$0200 ; BG palettes
SprPalettes:
	INCBIN "color/bank2d.bin",$0200,$0200 ; SPR palettes

	ORG $2d, $4400

; Load initial colors
InitGbcPalettes:
	ld a,$02
	ld [rSVBK],a
	ld de,W2_BgPaletteData
	ld hl,BgPalettes
	ld b,$08
.bgCopyLoop
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.bgCopyLoop

	call InitSpritePalettes

	ld a,$01
	; Make the game think we're running in SGB Mode.
	ld [$cf1b],a

	ld [rSVBK],a
	ld [$ff4d],a
	stop	; Automatically adds a nop
	jp LoadBank1

InitSpritePalettes:
	ld de,W2_SprPaletteData
	ld hl,SprPalettes
	ld b,$40
.sprCopyLoop
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.sprCopyLoop
	ret

	ORG $2d, $4800

; Refreshes palettes based on BGP and OBP registers
GbcVBlankHook:
	call UpdateMovingBgTiles	; Removed from caller to make space

	ld a,$02
	ld [rSVBK],a
	ld a,[rBGP]
	ld b,a
	ld a,[W2_LastBGP]	; TODO
	cp b
	jr z,.checkSprPalettes
	ld a,$80
	ld b,$00
	ld hl,rBGPI
	ld [hli],a
.doNextBgPal:
	ld c,$00	; C = color, B = palette #
.doNextBgColor:
	ld a,[rBGP]
	push bc
	and a
	jr nz,.bgpNotWhite
	call SetWhiteColor
	jr .skipSetBgColor
.bgpNotWhite
	cp $ff
	jr nz,.bgpNotBlack
	call SetBlackColor
	jr .skipSetBgColor
.bgpNotBlack
	xor a
	cp c
	ld a,[rBGP]
	call GetPaletteNumber
	call SetColor
.skipSetBgColor
	pop bc
	inc c
	ld a,c
	cp $04
	jr nz,.doNextBgColor
	inc b
	bit 3,b ; b >= 8?
	jr z,.doNextBgPal
	ld a,[rBGP]
	ld [W2_LastBGP],a

.checkSprPalettes
	ld a,[rOBP0]
	ld b,a
	ld a,[W2_LastOBP]
	cp b
	jr z,.endPaletteConversion
	ld a,$80
	ld b,$08
	ld hl,rOBPI
	ld [hli],a
.doNextSprPal
	ld c,$00
.doNextSprColor
	ld a,[rOBP0]
	push bc
	and a
	jr nz,.obpNotWhite
	call SetWhiteColor
	jr .skipSetSprColor
.obpNotWhite
	cp $ff
	jr nz,.obpNotBlack
	call SetBlackColor
	jr .skipSetSprColor
.obpNotBlack
	xor a
	cp c
	ld a,[rOBP0]
	call GetPaletteNumber
	call SetColor
.skipSetSprColor
	pop bc
	inc c
	ld a,c
	cp $04
	jr nz,.doNextSprColor
	inc b
	bit 4,b ; b >= 16?
	jr z,.doNextSprPal
	ld a,[rOBP0]
	ld [W2_LastOBP],a

.endPaletteConversion
	xor a
	ld [rSVBK],a
	ret


GetPaletteNumber:
	push af
	ld a,c
	xor 3
	ld c,a
	jr nz,.startLoop
	pop af
	ret
.startLoop
	pop af
.loop
	rlca
	rlca
	dec c
	jr nz,.loop
	ret

; Sets a palette color from palette #b to the index of first 2 bits of a.
; hl points to the data register (BGPD or OBPD)
SetColor:
	and $c0
	swap a
	rra
	rra		; Move top 2 bits to bottom
	;xor $03
	add a
	ld d,a
	ld a,b
	add a
	add a
	add a
	add d
	ld d,$d0
	ld e,a		; de points to W2_BgPaletteData (or SprPaletteData)
	ld a,[de]

	push hl
	ld hl,rSTAT
.statWait
	bit 1,[hl]
	jr nz,.statWait

	pop hl
	ld [hl],a
	inc e
	ld a,[de]

	push hl
	ld hl,rSTAT
.statWait2
	bit 1,[hl]
	jr nz,.statWait2

	pop hl
	ld [hl],a
	ret

SetBlackColor:
	push hl
	ld hl,rSTAT
.statWait
	bit 1,[hl]
	jr nz,.statWait

	xor a
	pop hl
	ld [hl],a
	ld [hl],a
	ret

SetWhiteColor:
	push hl
	ld hl,rSTAT
.statWait:
	bit 1,[hl]
	jr nz,.statWait

	pop hl
	ld a,$ff
	ld [hl],a
	ld a,$7f
	ld [hl],a
	ret


	ORG $2d, $4f00
MapPaletteData:
	INCBIN "color/bank2d.bin",$0f00,$00c0 ; Map palette data indices

	ORG $2d, $5000
MapPaletteArrangements:
	INCBIN "color/bank2d.bin",$1000,$0900 ; Map and tile color assignments

	ORG $2d, $6000
; Load color for new map and tile placement
LoadTilesetPalette:
	push bc
	push de
	push hl
	ld a,[W_CURMAPTILESET]
	ld b,a
	ld a,$02
	ld [rSVBK],a

	ld a,1
	ld [W2_TileBasedPalettes],a

	ld a,b
	push af
	sla a
	sla a
	sla a
	ld e,a
	ld d, MapPaletteData>>8	; de points to map palette assignment
	ld hl,W2_BgPaletteData
	ld b,$08
.nextPalette
	ld c,$08
	ld a,[de]	; # at de is the palette index for BgPalettes
	inc de
	push de
	sla a
	sla a
	sla a
	ld e,a
	ld d, BgPalettes>>8	; de now points to map's palette data
.nextColor
	ld a,[de]
	inc de
	ld [hli],a
	dec c
	jr nz,.nextColor
	pop de
	dec b
	jr nz,.nextPalette

	; Start copying palette assignments
	pop af	; Retrieve W_CURMAPTILESET into A
	ld hl,$0000
	cp $00
	jr z,.doneMultiplication
	ld c,a
	ld de,$0060	; Each palette arrangement takes $60 bytes
.addLoop
	add hl,de
	dec c
	jr nz,.addLoop
.doneMultiplication:
	ld bc, MapPaletteArrangements
	add hl,bc
	push hl
	pop de
	ld hl, $d200
	ld b,$60
.copyLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec b
	jr nz,.copyLoop

	; Set the remaining values to zero
	ld b,$a0
	xor a
.fillLoop
	ld [hli],a
	dec b
	jr nz,.fillLoop

	xor a
	ld [rSVBK],a
	pop hl
	pop de
	pop bc
	ret

	ORG $2d, $6200
; Towns have different roof colors while using the same tileset
LoadTownPalette:
	ld a, [W_CURMAP]
	ld c,a

	ld a,$02
	ld [rSVBK],a

	push de
	push hl
	ld hl, W2_BgPaletteData + $32
	ld b,$04
	ld d, TownData>>8
	ld a, c
	add a
	add a
	ld e,a
.copyLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec b
	jr nz,.copyLoop
	pop hl
	pop de

	xor a
	ld [W2_LastBGP],a
	ld [W2_LastOBP],a
	ld [rSVBK],a
	ret


	ORG $2d, $7000
TownData:
	INCBIN "color/bank2d.bin",$3000,$00a0 ; Town color assignments
