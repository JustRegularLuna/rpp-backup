; Trade animation colorization is extremely basic. Aside from the pokemon being shown,
; everything's just one palette.

; This is the first function call in the trade-animation-sequence. Initialize palettes.
LoadTradingGFXAndMonNames_ColorHook
	ld b, SET_PAL_POKEMON_WHOLE_SCREEN
	ld c, 2
	call RunPaletteCommand

	jp LoadTradingGFXAndMonNames

; Replaces function calls to "Trade_AnimLeftToRight" in engine/trade.asm.
; This is needed due to the pokemon's palette overwriting palette 0.
Trade_AnimLeftToRight_ColorHook:
	ld b, SET_PAL_POKEMON_WHOLE_SCREEN
	ld c, 2
	call RunPaletteCommand

	jp Trade_AnimLeftToRight
