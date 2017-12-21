ProgrammerComputerScreen::
; wipe the screen
	call SplashScreenSetup	
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
; show the splash screen
	jp MainScreenTurnOn

ProgrammerTilemap:
	INCBIN "gfx/tilemaps/programmer.kmp"
ProgrammerTilemapEnd:
