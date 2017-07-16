
; Prepare stuff to be done during vblank
; This is called from the lcd interrupt, at line $70
GbcPrepareVBlank:
	ld a,2
	ld [rSVBK],a
	call RefreshWindowPalettesPreVBlank
	call RefreshPalettesPreVBlank
	xor a
	ld [rSVBK],a
	ret

; Refresh palettes based on BGP and OBP registers
; Assumes wram bank 2 is loaded
RefreshPalettesPreVBlank:
	ld a,[W2_ForceBGPUpdate]
	or a
	jr nz,.updatebgp

	ld a,[rBGP]
	ld b,a
	ld a,[W2_LastBGP]
	cp b
	jr z,.checkSprPalettes

.updatebgp:
	ld a,1
	ld [W2_BgPaletteDataModified],a

	ld b,$00
	ld hl, W2_BgPaletteDataBuffer

	ld a,[rBGP]
	and a
	jr nz,.bgpNotWhite
	call SetWhiteColor
	jr .checkSprPalettes
.bgpNotWhite
	cp $ff
	jr nz,.bgpNotBlack
	call SetBlackColor
	jr .checkSprPalettes
.bgpNotBlack

.doNextBgPal:
	ld e,4

	ld a,[rBGP]
	ld d,a

.doNextBgColor:
	ld a,d
	call SetColor
	srl d
	srl d

	dec e
	jr nz,.doNextBgColor
	inc b
	bit 3,b ; b >= 8?
	jr z,.doNextBgPal

.checkSprPalettes
	ld a,[W2_ForceOBPUpdate]
	or a
	jr nz,.updateobjp
	ld a,[rOBP0]
	ld b,a
	ld a,[W2_LastOBP0]
	cp b
	jr nz,.updateobjp
	ld a,[rOBP1]
	ld b,a
	ld a,[W2_LastOBP1]
	cp b
	jr z,.end

.updateobjp
	ld a,1
	ld [W2_SprPaletteDataModified],a

	ld b,$08
	ld hl, W2_SprPaletteDataBuffer

	ld a,[rOBP0]
	and a
	jr nz,.obpNotWhite
	call SetWhiteColor
	jr .end
.obpNotWhite
	cp $ff
	jr nz,.obpNotBlack
	call SetBlackColor
	jr .end
.obpNotBlack

.doNextSprPal
	ld e,4

	ld a,[W2_UseOBP1]
	and a
	jr z,.obp0
	ld a,11
	cp b
	jr nc,.obp0
.obp1
	ld a,[rOBP1]
	ld d,a
	jr .doNextSprColor
.obp0
	ld a,[rOBP0]
	ld d,a

.doNextSprColor
	ld a,d
	call SetColor
	srl d
	srl d
	dec e
	jr nz,.doNextSprColor

	inc b
	bit 4,b ; b >= 16?
	jr z,.doNextSprPal

.end
	ld a,[rBGP]
	ld [W2_LastBGP],a
	ld a,[rOBP0]
	ld [W2_LastOBP0],a
	ld a,[rOBP1]
	ld [W2_LastOBP1],a
	xor a
	ld [W2_ForceBGPUpdate],a
	ld [W2_ForceOBPUpdate],a
	ret


; Draw window palettes; this is done before vblank so it can be efficiently DMA'd.
RefreshWindowPalettesPreVBlank:
	ld a,[H_AUTOBGTRANSFERENABLED]
	and a
	ret z

	ld a,[rSVBK]
	ld b,a
	ld a,$02
	ld [rSVBK],a
	push bc ; Push last wram bank

	; Check that vblank has updated the window from last frame (if not, let it catch up)
	ld hl, W2_UpdatedWindowPortion
	ld a,[hl]
	and a
	jp nz,.palettesDone
	ld [hl],1

	ld a,[H_AUTOBGTRANSFERPORTION]
	and a
	jr z,.firstThird
	dec a
	jr z,.secondThird
.thirdThird
	ld de,wTileMap+6*20*2
	jr .startCopy
.firstThird:
	ld de,wTileMap
	jr .startCopy
.secondThird:
	ld de,wTileMap+6*20

; de now points to map data in wram
.startCopy:

; BEGIN loading palettes

	ld hl, W2_ScreenPalettesBuffer

	ld b,6

	ld a,[W2_TileBasedPalettes]
	and a
	jr nz,.tileBasedPalettes

.staticMapPalettes:	; Palettes are loaded from a 20x18 grid of palettes
	; If the window transfer destination changed, we'll need to rewrite everything
	ld a,[W2_LastAutoCopyDest]
	ld b,a
	ld a,[H_AUTOBGTRANSFERDEST+1]
	cp b
	jr z,.noDestChange
	ld [W2_LastAutoCopyDest],a
	ld a,3
	ld [W2_StaticPaletteMapChanged],a
.noDestChange

	ld a,[W2_StaticPaletteMapChanged]
	and a
	jp z, .palettesDone

	ld [W2_StaticPaletteMapChanged_vbl],a ; Only this will signal vblank to refresh the window palettes

	dec a
	ld [W2_StaticPaletteMapChanged],a

	push hl
	ld h,d
	ld l,e
	ld de,W2_TilesetPaletteMap - wTileMap
	add hl,de
	ld d,h
	ld e,l ; de now points to the appropriate location in the palette grid @ W2_TilesetPaletteMap
	pop hl
	
	ld b,6
.drawRow_Pal
	ld c,20
.palLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec c
	jr nz,.palLoop

	ld a,32-20
	add l
	ld l,a
	jr nc,.noCarry
	inc h
.noCarry
	dec b
	jr nz,.drawRow_Pal

	jr .palettesDone

.tileBasedPalettes:	; Palettes are loaded based on the tile at that location
	push hl
	ld h,d
	ld l,e
	pop de
.drawRow
	push bc
	ld b,W2_TilesetPaletteMap>>8
REPT 20
	ld a,[hli]
	ld c,a
	ld a,[bc]
	ld [de],a
	inc e
ENDR

	ld a,32-20
	add e
	ld e,a
	jr nc,.noCarry2
	inc d
.noCarry2
	pop bc
	dec b
	jr nz,.drawRow

.palettesDone:
	pop af
	ld [rSVBK],a
	ret


; This is the last vblank-timing-sensitive thing that's called
GbcVBlankHook:
	call UpdateMovingBgTiles ; Removed from caller to make space

	; Use the hblank interrupt to get a head-start with vblank stuff
	ld a,[rIE]
	or 2
	ld [rIE],a
	ld a,$6e
	ld [$ff45],a
	ld a,[rSTAT]
	or $40
	ld [rSTAT],a

	ld a,2
	ld [rSVBK],a

	; Don't try to refresh palette if a row or column was drawn this frame.
	; This isn't really necessary, but it prevents a 1-frame artifact that occurs when
	; transitioning between screens, where all sprites are white.
	ld hl,W2_DrewRowOrColumn
	ld a,[hl]
	and a
	jr nz,.end

	call RefreshPalettesVBlank

.end
	xor a
	ld [W2_DrewRowOrColumn],a
	ld [rSVBK],a
	ret

; If necessary, copy palettes which were generated in the pre-vblank routines.
; It takes ~1024 cycles (1.1 scanlines) to write 8 palettes.
; So for each operation, it checks that it's not further than line $97. It'll have lines
; $98 and $00 to work with.
RefreshPalettesVBlank:

.checkBgPalettes
	ld a,[W2_BgPaletteDataModified]
	and a
	jr z, .checkSpritePalettes

	; Check there's enough time in vblank
	call .checkScanline
	jr nc,.end

	ld a,$80
	ld [rBGPI],a
	ld c, rBGPD&$ff
	ld hl, W2_BgPaletteDataBuffer
	call .load8

	xor a
	ld [W2_BgPaletteDataModified],a

.checkSpritePalettes
	ld a,[W2_SprPaletteDataModified]
	and a
	jr z, .end

	; Check there's enough time in vblank
	call .checkScanline
	jr nc,.end

	ld a,$80
	ld [rOBPI],a
	ld c, rOBPD&$ff
	ld hl, W2_SprPaletteDataBuffer
	call .load8

	xor a
	ld [W2_SprPaletteDataModified],a

.end
	ret

; Loads 8 palettes. Parameters:
; c = data register (ie. rBGPD)
; hl = source
.load8:
rept 64
	ld a,[hli]
	ld [$ff00+c],a
endr
	ret

; Sets carry flag if there's enough time to load another 8 palettes
.checkScanline
	ld a,[rLY]
	cp $97
	ret nc
	cp $90
	ccf
	ret

; Sets a palette color from palette #b to the index of last 2 bits of a.
; hl points to a buffer to store the palettes at.
; Used in pre-vblank routines.
SetColor:
	push de
	and 3
	add a
	ld d,a
	ld a,b
	add a
	add a
	add a
	add d
	ld d,W2_BgPaletteData>>8
	ld e,a		; de points to W2_BgPaletteData (or SprPaletteData)

	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	ld [hli],a

	pop de
	ret

SetBlackColor:
	xor a
	ld c,8*8
.loop
	ld [hli],a
	dec c
	jr nz,.loop
	ret

SetWhiteColor:
	ld a,$ff
	ld c,8*8
.loop
	ld [hli],a
	dec c
	jr nz,.loop
	ret
