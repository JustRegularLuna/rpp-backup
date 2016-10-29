DisplayEffectiveness: ; 2fb7b (b:7b7b)
	ld a, [wd05b]
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

SuperEffectiveText: ; 2fb8e (b:7b8e)
	TX_FAR _SuperEffectiveText
	db "@"

NotVeryEffectiveText: ; 2fb93 (b:7b93)
	TX_FAR _NotVeryEffectiveText
	db "@"
