; Note: after calling this, you may need to set W2_ForceBGPUpdate/ForceOBPUpdate to nonzero.
; d = palette to load (see constants/palette_constants.), e = palette index
LoadSGBPalette:
	ld a,[rSVBK]
	ld b,a
	ld a,2
	ld [rSVBK],a
	push bc

	ld a,e
	ld l,d
	ld h,0
	add hl
	add hl
	add hl
	ld de,SuperPalettes
	add hl,de

	ld de,W2_BgPaletteData
	jr startPaletteTransfer

LoadSGBPalette_Sprite:
	ld a,[rSVBK]
	ld b,a
	ld a,2
	ld [rSVBK],a
	push bc

	ld a,e
	ld l,d
	ld h,0
	add hl
	add hl
	add hl
	ld de,SuperPalettes
	add hl,de

	ld de,W2_BgPaletteData + $40

startPaletteTransfer:
	add a
	add a
	add a
	add e
	ld e,a
	ld b,8
	
.palLoop
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.palLoop

	pop af
	ld [rSVBK],a
	ret

INCLUDE "data/super_palettes.asm"
