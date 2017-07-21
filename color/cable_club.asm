
; Hook for "TradeCenter_DrawPartyLists" in engine/cable_club.asm.
; For some reason it doesn't have its own "palette command" that it calls, so this is the
; equivalent of that.
TradeCenter_DrawPartyLists_ColorHook:
	call LoadCableClubTextPaletteAndMap

	; Opcode removed for hook
	coord hl,0,0
	ret


; Called when the "PLEASE WAIT" text shows up on starting a trade or battle.
CableClub_DoBattleOrTrade_ColorHook:
	call LoadCableClubTextPaletteAndMap
	call LoadLinkBattlePokeballColors

	; Opcode removed for hook
	coord hl, 4, 10
	ret

LoadCableClubTextPaletteAndMap:
	ld a,2
	ld [rSVBK],a

	call LoadCableClubTextPalette

	; Set everything to use palette 7
	ld a,TEXT ; palette 7
	ld hl,W2_TilesetPaletteMap
	ld bc,$100
	call FillMemory

	ld a,1
	ld [W2_TileBasedPalettes],a
	ld a,3
	ld [W2_StaticPaletteMapChanged],a

	xor a
	ld [rSVBK],a
	ret

LoadCableClubTextPalette:
	; Load red or blue color in all palettes (only palette 7 is important, but loading
	; all palettes prevents minor artifacts)
IF DEF(_RED)
	ld d, PAL_REDMON
ENDC
IF DEF(_BLUE)
	ld d, PAL_BLUEMON
ENDC
	ld e,0
.loop:
	push de
	callba LoadSGBPalette
	pop de
	inc e
	ld a,e
	cp 8
	jr nz,.loop

	ld a,1
	ld [W2_ForceBGPUpdate],a
	ret


; Called after a link battle, loads palettes for the pokeballs.
EndOfBattle_ColorHook:
	call LoadLinkBattlePokeballColors

	; Opcode removed for hook
	jpab DisplayLinkBattleVersusTextBox


; Called whenever the "Waiting..." text appears
PrintWaitingText:
	; If in-battle, we don't want to ruin the palettes
	ld a,[wIsInBattle]
	or a
	jr nz,.end
	call LoadCableClubTextPaletteAndMap
.end
	jpab PrintWaitingText_orig


; Called by above functions, loads colors for pokeballs at battle start and end.
LoadLinkBattlePokeballColors:
	ld a,2
	ld [rSVBK],a

	; Set the palette the pokeball sprite uses
	ld hl,W2_SpritePaletteMap+$31
	xor a ; SPR_PAL_ORANGE
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a

	; Load the overworld sprite palettes for pokeball coloring
	callab LoadOverworldSpritePalettes

	xor a
	ld [rSVBK],a
	ret
