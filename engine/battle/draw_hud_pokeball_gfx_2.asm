PlayerHUDHAX:
	ld hl, PlayerHUDTileMap
	jp PlayerHUDUpdateDone
	
PlayerHUDTileMap:
	db $73, $75, $6F

EnemyHUDHAX:
	ld [hl], $72
	ld a, [W_ISINBATTLE]
	dec a
	jr  nz, .notWildBattle
	push hl
	ld a, [wEnemyMon]
	ld [wd11e], a
	callab IndexToPokedex
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, $2
	ld hl, wPokedexOwned
	predef FlagActionPredef
	ld a, c
	and a
	jr z, .notOwned
	coord hl, 1, 1
	ld [hl], $E9
.notOwned
	pop hl
.notWildBattle
	ld de, $0001
	jp EnemyHUDUpdateDone
