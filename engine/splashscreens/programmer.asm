ProgrammerComputerScreen::
; wipe the screen and get it ready
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	ld hl, wTileMap
	ld b, $12
	ld c, $12
	call TextBoxBorder
	call DisableLCD
	
; load the graphics for the screen
	ld hl, WindowsGraphics1
    ld de, vChars2
    ld bc, WindowsGraphics1End - WindowsGraphics1
	call CopyData
	
; load the tilemap for the screen
	ld hl, ProgrammerTilemap
	ld de, wTileMap
	ld bc, ProgrammerTilemapEnd - ProgrammerTilemap
	call CopyData
	
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
	call LoadFontTilePatterns
    call ReloadMapData ; added
	call UpdateSprites
	jp GoPAL_SET_CF1C

ProgrammerTilemap:
	INCBIN "gfx/programmer.map"
ProgrammerTilemapEnd:
