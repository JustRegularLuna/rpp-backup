INCLUDE "color/data/map_palettes.asm"
INCLUDE "color/data/map_palette_sets.asm"
INCLUDE "color/data/map_palette_assignments.asm"
INCLUDE "color/data/roofpalettes.asm"

; Load colors for new map and tile placement
LoadTilesetPalette:
	push bc
	push de
	push hl
	ld a,[rSVBK]
	ld d,a
	xor a
	ld [rSVBK],a
	ld a,[wCurMapTileset] ; Located in wram bank 1
	ld b,a
	ld a,$02
	ld [rSVBK],a
	push de ; push previous wram bank

	ld a,1
	ld [W2_TileBasedPalettes],a

	ld a,b ; Get wCurMapTileset
	push af
	ld d,0
	ld e,a
	sla e
	sla e
	sla e
	ld hl, MapPaletteSets
	add hl,de
	ld d,h
	ld e,l
	ld hl,W2_BgPaletteData ; palette data to be copied to wram at hl
	ld b,$08
.nextPalette
	ld c,$08
	ld a,[de] ; # at de is the palette index for MapPalettes
	inc de
	push de
	ld d,0
	ld e,a
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	push hl
	ld hl, MapPalettes
	add hl,de
	ld d,h
	ld e,l ; de now points to map's palette data
	pop hl
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
	pop af	; Retrieve wCurMapTileset
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
	ld hl, W2_TilesetPaletteMap
	ld b,$60
.copyLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec b
	jr nz,.copyLoop

	; Set the remaining values to 7 for text
	ld b,$a0
	ld a,7
.fillLoop
	ld [hli],a
	dec b
	jr nz,.fillLoop

	; There used to be special-case code for tile $78 here (pokeball in pc), but now
	; it uses palette 7 as well. Those areas still need to load the variant of the
	; textbox palette (PC_POKEBALL_PAL).

	; Switch to wram bank 1 just to read wCurMap
	xor a
	ld [rSVBK],a
	ld a,[wCurMap]
	ld b,a
	ld a,2
	ld [rSVBK],a

	; Check for celadon mart roof (make the "outside" blue)
	ld a,b
	cp CELADON_MART_ROOF
	jr nz,.notCeladonRoof
	ld a,BLUE
	ld hl,W2_TilesetPaletteMap + $4b
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
.notCeladonRoof
	; Check for celadon 3rd floor (fix miscoloration on counter)
	ld a,b
	cp CELADON_MART_3
	jr nz,.notCeladon3rd
	ld hl,W2_TilesetPaletteMap + $37
	ld [hl],BROWN
.notCeladon3rd
	; Check for celadon 1st floor (change bench color from blue to yellow)
	ld a,b
	cp CELADON_MART_1
	jr nz,.notCeladon1st
	ld hl,W2_TilesetPaletteMap + $07
	ld a,YELLOW
	ld [hli],a
	ld [hli],a
	ld l,$17
	ld [hli],a
	ld [hli],a
.notCeladon1st

	; Retrieve former wram bank
	pop af
	ld b,a

	xor a
	ld [rSVBK],a
	ld a,[wCurMapTileset]
	ld c,a

	ld a,b
	ld [rSVBK],a ; Restore previous wram bank

	ld a,c
	and a ; Check whether tileset 0 is loaded
	call z, LoadTownPalette
	cp PLATEAU ; tileset 0 isn't the only outside tileset
	call z, LoadTownPalette

	pop hl
	pop de
	pop bc
	ret

; Towns have different roof colors while using the same tileset
LoadTownPalette:
	ld a,[rSVBK]
	ld b,a
	xor a
	ld [rSVBK],a

	; Get the current map.
	ld a,[wCurMap]
	ld c,a
	cp ROUTE_6 ; Route 6 has 2 rows in saffron city; check if player is there or not.
	jr nz, .notRoute6
	ld a,[wYCoord]
	cp 2
	jr nc, .notRoute6
	ld c,SAFFRON_CITY
.notRoute6
	ld a,c
	add a
	ld c,a

	ld a,$02
	ld [rSVBK],a
	push bc ; push previous wram bank

	push de
	push hl
	ld hl, RoofPalettes
	ld b, 0
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, W2_BgPaletteData + $32
	ld b,$04
.copyLoop
	ld a,[de]
	inc de
	ld [hli],a
	dec b
	jr nz,.copyLoop
	pop hl
	pop de

	ld a, [wCurMap]
	ld [W2_TownMapLoaded],a

	pop af
	ld [rSVBK],a ; Restore wram bank
	ret
