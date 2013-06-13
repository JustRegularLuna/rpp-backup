SECTION "bank2D",DATA[$4000],BANK[$2D]

BgPalettes:
	INCBIN "color/bank2d.bin",$0000,$0200

	ORG $2d, $4200
; 8 bytes per map for 8 palettes, which are taken from BgPalettes.
MapPaletteData:
	INCBIN "color/bank2d.bin",$0f00,$00c0

	ORG $2d, $4300
; $60 bytes for each map. Each byte is the palette number for a tile.
; Remaining $a0 tiles aren't part of the tileset and are set to zero.
MapPaletteAssignments:
	INCBIN "color/bank2d.bin",$1000,$0900 ; Map and tile color assignments


InitGbcMode: ; Sets double speed & clears extra memory
	ld a,$01
	; Set double speed mode
	ld [$ff4d],a
	stop

	; Clear memory
	ld d,7
.clearBank
	ld a,d
	ld [rSVBK],a
	xor a
	ld hl, $d000
	ld bc, $1000
	call FillMemory
	dec d
	jr nz,.clearBank

	xor a
	ld [rSVBK],a
	jp LoadBank1


	ORG $2d, $6000
; Load colors for new map and tile placement
LoadTilesetPalette:
	push bc
	push de
	push hl
	ld a,[rSVBK]
	ld d,a
	xor a
	ld [rSVBK],a
	ld a,[W_CURMAPTILESET] ; Located in wram bank 0
	ld b,a
	ld a,$02
	ld [rSVBK],a
	push de ; push previous wram bank

	ld a,1
	ld [W2_TileBasedPalettes],a

	ld a,b ; Get W_CURMAPTILESET
	push af
	sla a
	sla a
	sla a
	ld e,a
	ld d, MapPaletteData>>8	; de points to map palette indices
	ld hl,W2_BgPaletteData ; palette data to be copied to wram at hl
	ld b,$08
.nextPalette
	ld c,$08
	ld a,[de] ; # at de is the palette index for BgPalettes
	inc de
	push de
	sla a
	sla a
	sla a
	ld e,a
	ld d, BgPalettes>>8	; de now points to map's palette data
.nextColor
	ld a,[de]
	inc de
	ld [hli],a
	dec c
	jr nz,.nextColor
	pop de
	dec b
	jr nz,.nextPalette

	; Start copying palette assignments
	pop af	; Retrieve W_CURMAPTILESET
	ld hl,$0000
	cp $00
	jr z,.doneMultiplication
	ld c,a
	ld de,$0060	; Each palette assignment takes $60 bytes
.addLoop
	add hl,de
	dec c
	jr nz,.addLoop
.doneMultiplication:
	ld bc, MapPaletteAssignments
	add hl,bc
	push hl
	pop de ; de points to MapPaletteAssignments
	ld hl, $d200
	ld b,$60
.copyLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec b
	jr nz,.copyLoop

	; Set the remaining values to zero
	ld b,$a0
	xor a
.fillLoop
	ld [hli],a
	dec b
	jr nz,.fillLoop

	pop af
	ld b,a

	xor a
	ld [rSVBK],a
	ld a,[W_CURMAPTILESET]
	ld c,a

	ld a,b
	ld [rSVBK],a ; Restore previous wram bank

	ld a,c
	and a ; Check whether tileset 0 is loaded
	call z, LoadTownPalette

	pop hl
	pop de
	pop bc
	ret

	ORG $2d, $6200
; Towns have different roof colors while using the same tileset
LoadTownPalette:
	ld a,[rSVBK]
	ld b,a
	xor a
	ld [rSVBK],a

	ld a, [W_CURMAP]
	ld c,a

	ld a,$02
	ld [rSVBK],a
	push bc ; push previous wram bank

	push de
	push hl
	ld hl, W2_BgPaletteData + $32
	ld b,$04
	ld d, TownData>>8
	ld a, c
	add a
	add a
	ld e,a
.copyLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec b
	jr nz,.copyLoop
	pop hl
	pop de

	ld a,c
	ld [W2_TownMapLoaded],a

	ld a,1
	ld [W2_LastBGP],a
	ld [W2_LastOBP0],a ; Palettes must be refreshed

	pop af
	ld [rSVBK],a ; Restore wram bank
	ret


	ORG $2d, $7000
TownData:
	INCBIN "color/bank2d.bin",$3000,$00a0 ; Town color assignments
