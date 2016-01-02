; returns whether the player is standing on a door tile in carry
IsPlayerStandingOnDoorTile: ; 1a609 (6:6609)
	push de
	ld hl, DoorTileIDPointers ; $662c
	ld a, [W_CURMAPTILESET] ; W_CURMAPTILESET
	ld de, $3
	call IsInArray
	pop de
	jr nc, .notStandingOnDoor
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	aCoord 8, 9 ; a = lower left background tile under player's sprite
	ld b, a
.loop
	ld a, [hli]
	and a
	jr z, .notStandingOnDoor
	cp b
	jr nz, .loop
	scf
	ret
.notStandingOnDoor
	and a
	ret

DoorTileIDPointers: ; 1a62c (6:662c)
	db OVERWORLD
	dw OverworldDoorTileIDs
	db FOREST
	dw ForestDoorTileIDs
	db SAFARI
	dw ForestDoorTileIDs
	db POKECENTER
	dw PokecenterDoorTileIDs
	db HOUSE
	dw HouseDoorTileIDs
	db FOREST_GATE
	dw TilesetMuseumDoorTileIDs
	db MUSEUM
	dw TilesetMuseumDoorTileIDs
	db GATE
	dw TilesetMuseumDoorTileIDs
	db SHIP
	dw ShipDoorTileIDs
	db LOBBY
	dw LobbyDoorTileIDs
	db MANSION
	dw MansionDoorTileIDs
	db LAB
	dw LabDoorTileIDs
	db FACILITY
	dw FacilityDoorTileIDs
	db PLATEAU
	dw PlateauDoorTileIDs
	db REDS_HOUSE_1
	dw RedsHouseDoorTileIDs
	db REDS_HOUSE_2
	dw RedsHouseDoorTileIDs
	db MART
	dw MartDoorTileIDs
	db FERRY
	dw FerryDoorTileIDs
	db $FF
OverworldDoorTileIDs:
	db 27,88,$00
ForestDoorTileIDs:
	db 58,$00
PokecenterDoorTileIDs:
	db 87,94,$00
HouseDoorTileIDs:
	db 62,$00
TilesetMuseumDoorTileIDs:
	db 22,59,$00
ShipDoorTileIDs:
	db 30,$00
LobbyDoorTileIDs:
	db 26,56,$00
MansionDoorTileIDs:
	db 26,28,83,$00
LabDoorTileIDs:
	db 52,$00
FacilityDoorTileIDs:
	db 67,88,27,$00
PlateauDoorTileIDs:
	db 59,27,$00
RedsHouseDoorTileIDs:
	db 26,28,$00
MartDoorTileIDs:
	db 80,82,86,$00
FerryDoorTileIDs:
	db 16,48,$00
