GetTrainerName_:
	ld hl, wLinkEnemyTrainerName
	ld a, [wLinkState]
	and a
	jr nz, .rival
	ld a, [wTrainerClass]
	ld [wd0b5], a
	ld a, TRAINER_NAME
	ld [wNameListType], a
	ld a, BANK(TrainerNames)
	ld [wPredefBank], a
	call GetName
	ld hl, wcd6d
.rival
	ld de, wTrainerName
	ld bc, $d
	jp CopyData
