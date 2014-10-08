VBlank::

	push af
	push bc
	push de
	push hl

	ld a, [H_LOADEDROMBANK]
	ld [wd122], a

	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a

	ld a, [wd0a0]
	and a
	jr nz, .ok
	ld a, [hWY]
	ld [rWY], a
.ok

	call AutoBgMapTransfer
	call VBlankCopyBgMap
	call RedrawExposedScreenEdge
	call VBlankCopy
	call VBlankCopyDouble
	;call UpdateMovingBgTiles
	rst $10 ; HAX: VBlank hook
	nop
	nop
	call $ff80 ; OAM DMA
	; HAX: don't update sprites here. They're updated elsewhere to prevent wobbliness.
	;ld a, Bank(PrepareOAMData)
	nop
	nop
	;ld [H_LOADEDROMBANK], a
	nop
	nop
	;ld [MBC1RomBank], a
	nop
	nop
	nop
	;call PrepareOAMData ; update OAM buffer with current sprite data
	nop
	nop
	nop

	; VBlank-sensitive operations end.

	call Random

	ld a, [H_VBLANKOCCURRED]
	and a
	jr z, .vblanked
	xor a
	ld [H_VBLANKOCCURRED], a
.vblanked

	ld a, [H_FRAMECOUNTER]
	and a
	jr z, .decced
	dec a
	ld [H_FRAMECOUNTER], a
.decced

	call Func_28cb

	ld a, [wc0ef] ; music ROM bank
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a

	cp BANK(Music2_UpdateMusic)
	jr nz, .notbank2
.bank2
	call Music2_UpdateMusic
	jr .afterMusic
.notbank2
	cp BANK(Music8_UpdateMusic)
	jr nz, .bank1F
.bank8
	call Func_2136e
	call Music8_UpdateMusic
	jr .afterMusic
.bank1F
	call Music1f_UpdateMusic
.afterMusic

	callba TrackPlayTime ; keep track of time played

	ld a, [$fff9]
	and a
	call z, ReadJoypad

	ld a, [wd122]
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a

	pop hl
	pop de
	pop bc
	pop af
	reti


DelayFrame::
; Wait for the next vblank interrupt.
; As a bonus, this saves battery.

NOT_VBLANKED EQU 1

	call DelayFrameHook ; HAX
	nop
	;ld a,1
	;ld [H_VBLANKOCCURRED],a
.halt
	halt
	ld a, [H_VBLANKOCCURRED]
	and a
	jr nz,.halt
	ret
