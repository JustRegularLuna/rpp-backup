; Called whenever the link cable appears. Loads PAL_MEWMON on all bg palettes.
Trade_LoadCablePalettes:
	; Load PAL_MEWMON to all background palettes
	ld a,2
	ld [rSVBK],a
	ld d, PAL_MEWMON
	ld e, 0
.loop
	push de
	callab LoadSGBPalette
	pop de
	inc e
	ld a,e
	cp 8
	jr nz,.loop

	ld a,1
	ld [W2_ForceBGPUpdate],a
	xor a
	ld [rSVBK],a
	ret


; Called just before loading the pokemon sprites for moving through the link cable.
; This function sort of "patches" the result of "LoadAnimationTileset", so it should be
; called after any such animations occur.
Trade_InitGameboyTransferGfx_ColorHook:
	call Trade_LoadCablePalettes

	ld a,2
	ld [rSVBK],a

	callab LoadAttackSpritePalettes

	; Set the palettes to use for the pokemon sprites
	ld b,$30
	ld hl, W2_SpritePaletteMap
	ld a, 2 ; ATK_PAL_RED
.loop
	ld [hl],a
	set 6,l
	ld [hli],a
	res 6,l
	dec b
	jr nz,.loop

	; Set the palettes for the "glow" behind the pokemon
	ld hl, W2_SpritePaletteMap+$38
	ld b, 6
	ld a, 2 ; ATK_PAL_RED
.loop2
	ld [hl],a
	set 6,l
	ld [hli],a
	res 6,l
	dec b
	jr nz,.loop2

	xor a
	ld [rSVBK],a

	jp Trade_InitGameboyTransferGfx


; Called at start of trade sequence. This prevents some minor graphical garbage from
; showing up.
LoadTradingGFXAndMonNames_ColorHook:
	call LoadTradingGFXAndMonNames
	call Trade_LoadCablePalettes
	jp DelayFrame
