; This file only included if GEN_2_GRAPHICS is set

LoadHPBarAndEXPBar:
	ld de,HpBarAndStatusGraphics
	ld hl,vChars2 + $620
	ld bc,(BANK(HpBarAndStatusGraphics) << 8 | $1e)
	call GoodCopyVideoData
	ld de,EXPBarGraphics
	ld hl,vChars1 + $400
	ld bc,(BANK(EXPBarGraphics) << 8 | $9)
GoodCopyVideoData:
	ld a,[rLCDC]
	bit 7,a ; is the LCD enabled?
	jp nz, CopyVideoData ; if LCD is on, transfer during V-blank
	ld a, b
	push hl
	push de
	ld h, 0
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	pop hl
	pop de
	jp FarCopyData2 ; if LCD is off, transfer all at once
