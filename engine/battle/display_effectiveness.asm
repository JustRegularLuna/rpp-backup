DisplayEffectiveness:
	ld a, [wDamageMultipliers]
	and a, $7F
	and a
	ret z ; neutral
	cp %00000011
	ret z ; se to one type and nve to the other type
	and %00000001
	ld hl, SuperEffectiveText
	jr z, .done
	ld hl, NotVeryEffectiveText
.done
	jp PrintText

SuperEffectiveText:
	TX_FAR _SuperEffectiveText
	db "@"

NotVeryEffectiveText:
	TX_FAR _NotVeryEffectiveText
	db "@"
