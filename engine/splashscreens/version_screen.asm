DisplayHackVersionScreen::
; Displays the welcome screen with difficulty and version number info
; Start by clearing and turning off the screen
	call ClearScreen
	call DisableLCD
; load the graphics for the screen
	ld hl, VersionScreenTiles
	ld de, vChars2
	ld bc, VersionScreenTilesEnd - VersionScreenTiles
	call CopyData	
; load the tilemap for the screen
	ld hl, VersionScreenTilemap
	ld de, wTileMap
	ld bc, VersionScreenTilemapEnd - VersionScreenTilemap
	call CopyData
; turn the screen back on
	call EnableLCD
	call Delay3
	call GBPalNormal
; wait for the player to press A
	call WaitForTextScrollButtonPress
; wipe the screen and go back
	call ClearScreen
	ret

VersionScreenTiles:
	INCBIN "gfx/version_screen_tiles.2bpp"
VersionScreenTilesEnd:

VersionScreenTilemap:
IF DEF(_RED) ; Normal Rom
	INCBIN "gfx/tilemaps/normal_screen.map"
ENDC

IF DEF(_BLUE) ; Hard Rom
	INCBIN "gfx/tilemaps/hard_screen.map"
ENDC

IF DEF(_FOREVER) ; Forever Rom
	INCBIN "gfx/tilemaps/forever_screen.map"
ENDC
VersionScreenTilemapEnd:
