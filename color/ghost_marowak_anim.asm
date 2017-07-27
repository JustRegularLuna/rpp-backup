; Hook for engine/battle/ghost_marowak_anim.asm

CopyMonPicFromBGToSpriteVRAM:
	; Copy enemy palette to sprite palette 4
	ld a,2
	ld [rSVBK],a
	ld hl,W2_BgPaletteData + 1*8 ; bg palette 1 (enemy)
	ld de,W2_SprPaletteData+ 4*8 ; spr palette 4
	ld bc,8
	call CopyData

	; Ghost/marowak palette fade effect uses OBP1
	ld a,1
	ld [W2_UseOBP1],a
	ld [W2_ForceOBPUpdate],a

	xor a
	ld [rSVBK],a

	jp CopyMonPicFromBGToSpriteVRAM_orig
