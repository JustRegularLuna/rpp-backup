InitPlayerData:
InitPlayerData2:
; Start by generating the player ID
	call Random
	ld a, [hRandomSub]
	ld [wPlayerID], a

	call Random
	ld a, [hRandomAdd]
	ld [wPlayerID + 1], a

; Not sure what this is for?
	ld a, $ff
	ld [wUnusedD71B], a

; Initialize the party, bag, PC, etc.
	ld hl, wPartyCount
	call InitializeEmptyList
	ld hl, wNumInBox
	call InitializeEmptyList
	ld hl, wNumBagItems
	call InitializeEmptyList
	ld hl, wNumBoxItems
	call InitializeEmptyList

START_MONEY EQU $3000
	ld hl, wPlayerMoney + 1
	ld a, START_MONEY / $100
	ld [hld], a
	xor a
	ld [hli], a
	inc hl
	ld [hl], a

	ld [wMonDataLocation], a

; Obtained badges
	ld hl, wObtainedKantoBadges
	ld [hli], a
	; wObtainedJohtoBadges
	ld [hl], a

; Initialize player coins
	ld hl, wPlayerCoins
	ld [hli], a
	ld [hl], a

; Initialize Berry Tree flags and step counter
	ld hl, wBerryTreeFlags
	; assumption: only 2 bytes used for flags
	ld [hli], a
	ld [hli], a
	; assumption: step counter immediately follows berry tree flags
	ld [hli], a
	ld [hl], a

; Initialize the variable sprites
	ld hl, VarSpriteTable
	ld de, wVarSprites
	ld bc, VarSpriteTableEnd - VarSpriteTable
	call CopyData

; Initialize map script numbers
	xor a
	ld hl, wGameProgressFlags
	ld bc, wGameProgressFlagsEnd - wGameProgressFlags
	call FillMemory ; clear all game progress flags

	jp InitializeMissableObjectsFlags
	
INCLUDE "data/default_var_sprites.asm"

InitializeEmptyList:
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret
