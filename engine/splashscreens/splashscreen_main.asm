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
	call GoPAL_SET_CF1C
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
	jp GoPAL_SET_CF1C
