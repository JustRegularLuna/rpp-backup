; returns whether the player is standing on a door tile in carry
IsPlayerStandingOnDoorTile: ; 1a609 (6:6609)
	push de
	ld hl, DoorTileIDPointers
	ld a, [wCurMapTileset]
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
	dbw OVERWORLD,    OverworldDoorTileIDs
	dbw FOREST,       ForestDoorTileIDs
	dbw SAFARI,       ForestDoorTileIDs
	dbw POKECENTER,   PokecenterDoorTileIDs
	dbw HOUSE,        HouseDoorTileIDs
	dbw FOREST_GATE,  TilesetMuseumDoorTileIDs
	dbw MUSEUM,       TilesetMuseumDoorTileIDs
	dbw GATE,         TilesetMuseumDoorTileIDs
	dbw SHIP,         ShipDoorTileIDs
	dbw LOBBY,        LobbyDoorTileIDs
	dbw MANSION,      MansionDoorTileIDs
	dbw LAB,          LabDoorTileIDs
	dbw FACILITY,     FacilityDoorTileIDs
	dbw PLATEAU,      PlateauDoorTileIDs
	dbw REDS_HOUSE_1, RedsHouseDoorTileIDs
	dbw REDS_HOUSE_2, RedsHouseDoorTileIDs
	dbw MART,         MartDoorTileIDs
	dbw FERRY,        FerryDoorTileIDs
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
