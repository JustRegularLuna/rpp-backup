HiddenItemNear: ; 7481f (1d:481f)
	ld hl, HiddenItemCoords
	ld b, $0
.loop
	ld de, $0003
	ld a, [W_CURMAP]
	call IsInRestOfArray
	ret nc ; return if current map has no hidden items
	push bc
	push hl
	ld hl, wObtainedHiddenItemsFlags
	ld c, b
	ld b, CHECK_FLAG
	predef FlagActionPredef
	ld a, c
	pop hl
	pop bc
	inc b
	and a
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	jr nz, .loop
	ld a, [W_YCOORD]
	call Sub5ClampTo0
	cp d
	jr nc, .loop
	ld a, [W_YCOORD]
	add $4
	cp d
	jr c, .loop
	ld a, [W_XCOORD]
	call Sub5ClampTo0
	cp e
	jr nc, .loop
	ld a, [W_XCOORD]
	add $5
	cp e
	jr c, .loop
	scf
	ret

Sub5ClampTo0: ; 7486b (1d:486b)
; subtract 5 but clamp to 0
	sub $5
	cp $f0
	ret c
	xor a
	ret
