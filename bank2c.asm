; Bank 2c is being used for something at the beginning of the bank. The rest is free.

	ORG $2c, $6000

RefreshMapColors:
	ld a,$02
	ld [rSVBK],a
	ld a,$01
	ld [rVBK],a
	ld a,[hl]
	push hl
	ld h,$d2
	ld l,a
	ld a,[hl]
	ld [de],a
	pop hl
	xor a
	ld [rVBK],a
	ld [rSVBK],a
	ld a,[hli]
	add sp,$04
	push af
	add sp,-$02
	ld [de],a
	inc e
	ret

; Refresh moving tiles
	ORG $2c, $7000
label_2c_l000:
	push hl
	ld hl,rSTAT
label_2c_l001:
	bit 1,[hl]
	jr nz,label_2c_l001
	pop hl
	ld a,[hl]
	rlca
	ld [hli],a
	dec c
	jr nz,label_2c_l000
	jp $1ee9

	ORG $2c, $7080
label_2c_l002:
	push hl
	ld hl,rSTAT
label_2c_l003:
	bit 1,[hl]
	jr nz,label_2c_l003
	pop hl
	ld a,[hl]
	rrca
	ld [hli],a
	dec c
	jr nz,label_2c_l002
	jp $1ee9
