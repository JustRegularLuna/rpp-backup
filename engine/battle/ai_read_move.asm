_ReadMove:: ; moved into same bank as actual move data
	ld a, e
	ld hl,Moves
	ld bc,6
	call AddNTimes
	ld de,wEnemyMoveNum
	call CopyData
	ret
