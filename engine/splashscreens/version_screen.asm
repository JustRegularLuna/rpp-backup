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
	call CleanPikachuScreen
; turn the screen back on
	call EnableLCD
	call Delay3
	call GBPalNormal
; display the version info text
	hlCoord 2, 2
	ld de, VersionScreenText
	call PlaceString
; wait for the player to press A
	call WaitForTextScrollButtonPress
; load the tilemap for the screen again
	call CleanPikachuScreen
; display the second page
	hlCoord 2, 2
	ld de, VersionScreenText2
	call PlaceString
	; wait for the player to press A
	call WaitForTextScrollButtonPress
; load the tilemap for the screen again
	call CleanPikachuScreen
; display the third page
	hlCoord 2, 6
	ld de, VersionScreenText3
	call PlaceString
	; wait for the player to press A
	call WaitForTextScrollButtonPress
; wipe the screen and go back
	call ClearScreen
	ret

CleanPikachuScreen:
	ld hl, VersionScreenTilemap
	ld de, wTileMap
	ld bc, VersionScreenTilemapEnd - VersionScreenTilemap
	jp CopyData

VersionScreenTiles:
	INCBIN "gfx/version_screen_tiles.2bpp"
VersionScreenTilesEnd:

VersionScreenTilemap:
	INCBIN "gfx/tilemaps/blank_text_screen.map"
VersionScreenTilemapEnd:

VersionScreenText:
	db "Welcome to Red++", $4E
	db "You are playing", $4E
IF DEF(_BLUE) ; Hard Rom
	db "The Hard Patch", $4E
ELSE ; Normal Rom
	db "The Normal Patch", $4E
ENDC
	db "Version 2.4 LTS@"

VersionScreenText2:
	db "Readme and FAQ", $4E
	db "are found at:", $4E
	db "www.github.com/", $4E
	db "TheFakeMateo/", $4E
	db "RedPlusPlus@"

VersionScreenText3:
	db "Have fun!", $4E
	db "  - Mateo, 2016@"
