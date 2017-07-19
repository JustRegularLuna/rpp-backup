; Hooks for drawing exp bars in status_screen.asm

StatusScreenHook:
	; b = SET_PAL_STATUS_SCREEN
	call RunPaletteCommand
IF GEN_2_GRAPHICS
	coord de, 18, 5
	ld a, [wLoadedMonLevel]
	ld [wBattleMonLevel], a
	push af
	callba PrintEXPBar
	pop af
	ld [wLoadedMonLevel], a
ENDC
	ret

; Only called when GEN_2_GRAPHICS is set
StatusScreen2Hook:
	coord hl, 19, 1
	lb bc, 6, 10
	jp DrawLineBox ; Draws the box around name, HP and status
