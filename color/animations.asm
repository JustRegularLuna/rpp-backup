; Hooks for engine/battle/animations.asm

_LoadAnimationTilesetPalettes:
	ld b, BANK(LoadAnimationTilesetPalettes)
	ld hl, LoadAnimationTilesetPalettes
	rst $18
	ret

; Actually this doesn't do everything needed to spriteify
; It copies the tiles and the palette of the player pokemon.
SpriteifyPlayerPokemon:
	ld de,vBackPic
	ld hl,vSprites
	ld bc,7*7
	call CopyVideoData

	ld a,2
	ld [rSVBK],a
	ld hl, W2_BgPaletteData
	ld de, W2_SprPaletteData
	ld bc, 8
	call CopyData

	ld a,1
	ld [W2_LastOBP0],a

	xor a
	ld [rSVBK],a
	ret
