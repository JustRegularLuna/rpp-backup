; $60 bytes for each tileset. Each byte is the palette number for a tile.
; Remaining $a0 tiles aren't part of the tileset and are set to 7 (text palette).
; Refer to MapPaletteSets for clarification on specific colors
; Each row of entries corresponds to a row of tiles on the tileset image
MapPaletteAssignments:
INCLUDE "color/tilesets/overworld.asm" ; OVERWORLD
INCLUDE "color/tilesets/reds_house.asm" ; REDS_HOUSE_1
INCLUDE "color/tilesets/mart.asm" ; MART
INCLUDE "color/tilesets/forest.asm" ; FOREST
INCLUDE "color/tilesets/reds_house.asm" ; REDS_HOUSE_2
INCLUDE "color/tilesets/oakts.asm" ; OAK_TS
INCLUDE "color/tilesets/pokecenter.asm" ; POKECENTER
INCLUDE "color/tilesets/gym.asm" ; GYM
INCLUDE "color/tilesets/house.asm" ; HOUSE
INCLUDE "color/tilesets/forest_gate.asm" ; FOREST_GATE
INCLUDE "color/tilesets/museum.asm" ; MUSEUM
INCLUDE "color/tilesets/underground.asm" ; UNDERGROUND
INCLUDE "color/tilesets/gate.asm" ; GATE
INCLUDE "color/tilesets/ship.asm" ; SHIP
INCLUDE "color/tilesets/ship_port.asm" ; SHIP_PORT
INCLUDE "color/tilesets/cemetery.asm" ; CEMETERY
INCLUDE "color/tilesets/interior.asm" ; INTERIOR
INCLUDE "color/tilesets/cavern.asm" ; CAVERN
INCLUDE "color/tilesets/lobby.asm" ; LOBBY
INCLUDE "color/tilesets/mansion.asm" ; MANSION
INCLUDE "color/tilesets/lab.asm" ; LAB
INCLUDE "color/tilesets/club.asm" ; CLUB
INCLUDE "color/tilesets/facility.asm" ; FACILITY
INCLUDE "color/tilesets/plateau.asm" ; PLATEAU
INCLUDE "color/tilesets/safari.asm" ; SAFARI
INCLUDE "color/tilesets/ferry.asm" ; FERRY
INCLUDE "color/tilesets/ice_cavern.asm" ; ICE_CAVERN
INCLUDE "color/tilesets/museum2.asm" ; MUSEUM_2
