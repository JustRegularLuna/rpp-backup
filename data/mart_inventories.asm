; mart inventories are below
; they are texts
; first byte MART_LIST ($FE), next byte # of items, last byte $FF

; Viridian
ViridianMartText6:: ; 2442 (0:2442)
	db MART_LIST
	db 4
	db POKE_BALL
	db ANTIDOTE
	db PARLYZ_HEAL
	db BURN_HEAL
	db $FF

; Pewter
PewterMartText1:: ; 2449 (0:2449)
	db MART_LIST
	db 7
	db POKE_BALL
	db POTION
	db ESCAPE_ROPE
	db ANTIDOTE
	db BURN_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db $FF

; Cerulean
CeruleanMartText1:: ; 2453 (0:2453)
	db MART_LIST
	db 7
	db POKE_BALL
	db POTION
	db REPEL
	db ANTIDOTE
	db BURN_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db $FF

; Bike shop
	db MART_LIST
	db 1
	db BICYCLE
	db $FF

; Vermilion
VermilionMartText1:: ; 2461 (0:2461)
	db MART_LIST
	db 6
	db POKE_BALL
	db SUPER_POTION
	db ICE_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db REPEL
	db $FF

; Lavender
LavenderMartText1:: ; 246a (0:246a)
	db MART_LIST
	db 9
	db GREAT_BALL
	db SUPER_POTION
	db REVIVE
	db ESCAPE_ROPE
	db SUPER_REPEL
	db ANTIDOTE
	db BURN_HEAL
	db ICE_HEAL
	db PARLYZ_HEAL
	db $FF

; Celadon Dept. Store 2F (1)
CeladonMart2Text1:: ; 2476 (0:2476)
	db MART_LIST
	db 9
	db GREAT_BALL
	db SUPER_POTION
	db REVIVE
	db SUPER_REPEL
	db ANTIDOTE
	db BURN_HEAL
	db ICE_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db $FF

; Celadon Dept. Store 2F (2)
CeladonMart2Text2:: ; 2482 (0:2482)
	db MART_LIST
	db 9
	db TM_32
	db TM_33
	db TM_02
	db TM_07
	db TM_37
	db TM_01
	db TM_05
	db TM_09
	db TM_17
	db $FF

; Celadon Dept. Store 4F
CeladonMart4Text1:: ; 248e (0:248e)
	db MART_LIST
	db 7
	db POKE_DOLL
	db FIRE_STONE
	db THUNDER_STONE
	db WATER_STONE
	db LEAF_STONE
	db MOON_STONE
	db SUN_STONE
	db $FF

; Celadon Dept. Store 5F (1)
CeladonMart5Text3:: ; 2496 (0:2496)
	db MART_LIST
	db 7
	db X_ACCURACY
	db GUARD_SPEC_
	db DIRE_HIT
	db X_ATTACK
	db X_DEFEND
	db X_SPEED
	db X_SPECIAL
	db $FF

; Celadon Dept. Store 5F (2)
CeladonMart5Text4:: ; 24a0 (0:24a0)
	db MART_LIST
	db 5
	db HP_UP
	db PROTEIN
	db IRON
	db CARBOS
	db CALCIUM
	db $FF

; Fuchsia
FuchsiaMartText1:: ; 24a8 (0:24a8)
	db MART_LIST
	db 6
	db ULTRA_BALL
	db GREAT_BALL
	db SUPER_POTION
	db REVIVE
	db FULL_HEAL
	db SUPER_REPEL
	db $FF

; unused? 24b1
FossilMartText::
	db MART_LIST
	db 3
	db OLD_AMBER
	db DOME_FOSSIL
	db HELIX_FOSSIL
	db $FF

; Cinnabar
CinnabarMartText1:: ; 24b9 (0:24b9)
	db MART_LIST
	db 7
	db ULTRA_BALL
	db GREAT_BALL
	db HYPER_POTION
	db MAX_REPEL
	db ESCAPE_ROPE
	db FULL_HEAL
	db REVIVE
	db $FF

; Saffron
SaffronMartText1:: ; 24c3 (0:24c3)
	db MART_LIST
	db 6
	db GREAT_BALL
	db HYPER_POTION
	db MAX_REPEL
	db ESCAPE_ROPE
	db FULL_HEAL
	db REVIVE
	db $FF

; Indigo
IndigoPlateauLobbyText4:: ; 24cc (0:24cc)
	db MART_LIST
	db 7
	db ULTRA_BALL
	db GREAT_BALL
	db FULL_RESTORE
	db MAX_POTION
	db FULL_HEAL
	db REVIVE
	db MAX_REPEL
	db $FF
