; Helper functions for oak intro

GetNidorinoPalID:
	call ClearScreen
	ld a, PAL_MEWMON ; PAL_PURPLEMON ; PAL_NIDORINO
	jr GotPalID

GetRedPalID:
	call ClearScreen
	ld a, PAL_MEWMON ; PAL_HERO
	jr GotPalID

GetRivalPalID:
	call ClearScreen
	ld a, PAL_MEWMON ; PAL_GARY1
	jr GotPalID

GotPalID:
	ld e,0
	ld d,a

	ld a,2
	ld [rSVBK],a
	CALL_INDIRECT LoadSGBPalette
	xor a
	ld [rSVBK],a
	ret

