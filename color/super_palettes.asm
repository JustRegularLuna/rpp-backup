; Note: after calling this, you may need to set W2_ForceBGPUpdate/ForceOBPUpdate to nonzero.
; d = palette to load (see constants/palette_constants.), e = palette index
LoadSGBPalette:
	ld hl, SuperPalettes
	jr LoadPalette

LoadPokemonPalette:
	ld hl, PokemonPaletteTable
	jr LoadPalette

LoadShinyPokemonPalette:
	ld hl, ShinyPokemonPaletteTable
	jr LoadPalette

LoadTrainerPalette:
	ld hl, TrainerPaletteTable
	jr LoadPalette

LoadPalette:
	ld a,[rSVBK]
	ld b,a
	ld a,2
	ld [rSVBK],a
	push bc

	push hl
	ld a,e
	ld l,d
	ld h,0
	add hl
	add hl
	add hl
	pop de
	add hl,de

	ld de,W2_BgPaletteData
	jp startPaletteTransfer

LoadSGBPalette_Sprite:
	ld hl, SuperPalettes
	jr LoadPalette_Sprite

LoadPokemonPalette_Sprite:
	ld hl, PokemonPaletteTable
	jr LoadPalette_Sprite

LoadShinyPokemonPalette_Sprite:
	ld hl, ShinyPokemonPaletteTable
	jr LoadPalette_Sprite

LoadTrainerPalette_Sprite:
	ld hl, TrainerPaletteTable
	jr LoadPalette_Sprite

LoadPalette_Sprite:
	ld a,[rSVBK]
	ld b,a
	ld a,2
	ld [rSVBK],a
	push bc

	push hl
	ld a,e
	ld l,d
	ld h,0
	add hl
	add hl
	add hl
	pop de
	add hl,de

	ld de,W2_BgPaletteData + $40
	jr startPaletteTransfer

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
