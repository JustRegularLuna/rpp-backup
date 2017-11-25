SplashScreenSetup:
; wipe the screen and get it ready
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	ld hl, wTileMap
	ld b, $12
	ld c, $12
	call TextBoxBorder
	call DisableLCD
	ret

MainScreenTurnOn:	
; turn the screen back on
	call EnableLCD
	ld b, SET_PAL_WINDOWS_SCREEN
	call RunPaletteCommand
	call Delay3
	call GBPalNormal
	
; wait for the player to press A
	call WaitForTextScrollButtonPress
	
; clear the image, reload the map	
	call GBPalWhiteOut
	call ClearScreen
	call ClearSprites
	call LoadPlayerSpriteGraphics
	call ReloadMapData
	call UpdateSprites
	jp RunDefaultPaletteCommand
