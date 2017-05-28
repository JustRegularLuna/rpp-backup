IncrementDayCareMonExp:
	ld a, [wDayCareInUse]
	bit 0, a ; does Day Care Lady have someone?
	jr z, .dayCareMan
	ld hl, wDayCareMonExp + 2
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ld a, [hl]
	cp $50
	jr c, .dayCareMan
	ld a, $50
	ld [hl], a
.dayCareMan
	ld a, [wDayCareInUse]
	bit 1, a ; does Day Care Man have someone?
	ret z
	ld hl, wDayCareMon2Exp + 2
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ld a, [hl]
	cp $50
	ret c
	ld a, $50
	ld [hl], a
	ret
