SlidingTilePuzzle::
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call ClearSprites
	call ClearScreen
	call LoadFontTilePatterns
	ld a, 2
	ld [wWhichSlidingPuzzle], a
	call LoadSlidingTilePuzzle
	call DrawSlidingTilePuzzle
	ld d, 0
	ld e, 0
	call DrawSlidingTilePuzzleCursor
	; fall through
SlidingTilePuzzleMain:
	call IsSlidingPuzzleSolved
	jp c, SlidingPuzzleSolved
	call DelayFrame
	call JoypadLowSensitivity
	ld a, [wSlidingTilePuzzleX]
	ld b, a
	ld a, [wSlidingTilePuzzleY]
	ld c, a
	; bc = cursor coords
	ld a,[hJoy5]
	ld d, a
	and D_UP
	jr z, .checkRight
	dec c
	ld d, D_UP
	jr .moveCursor
.checkRight
	ld a, d
	and D_RIGHT
	jr z, .checkDown
	inc b
	ld d, D_RIGHT
	jr .moveCursor
.checkDown
	ld a, d
	and D_DOWN
	jr z, .checkLeft
	inc c
	ld d, D_DOWN
	jr .moveCursor
.checkLeft
	ld a, d
	and D_LEFT
	jr z, .noCursorMovement
	ld d, D_LEFT
	dec b
.moveCursor
	; bc = new cursor coords
	; Check if the new coords are valid.
	ld hl, wSlidingTilePuzzleWidth
	ld a, b
	cp $ff
	jr z, .noCursorMovement
	cp [hl]
	jr nc, .noCursorMovement
	ld [wBuffer], a
	ld hl, wSlidingTilePuzzleHeight
	ld a, c
	cp $ff
	jr z, .noCursorMovement
	cp [hl]
	jr nc, .noCursorMovement
	ld [wBuffer + 1], a
	call MoveSlidingTilePuzzleCursor
	ld a, [wBuffer]
	ld [wSlidingTilePuzzleX], a
	ld a, [wBuffer + 1]
	ld [wSlidingTilePuzzleY], a
	ld de, 0
	call DrawSlidingTilePuzzleCursor
	call DelayFrame
	jr SlidingTilePuzzleMain
.noCursorMovement
	; Check for A press
	ld a, d
	and A_BUTTON
	jr nz, .APressed
	ld a, d
	and B_BUTTON
	jr z, .noButtonPress
	; Exit the puzzle
	and a
	ret
.APressed
	; Check if the selected tile is slide-able.
	ld a, [wSlidingTilePuzzleX]
	ld b, a
	ld a, [wSlidingTilePuzzleY]
	ld c, a
	; bc = cursor coords
	push bc
	; Check if tile above is empty.
	dec c
	ld a, c
	cp $ff
	jr z, .checkRightCell
	call IsCellEmpty
	jr c, .slideTile
.checkRightCell
	pop bc
	push bc
	inc b
	ld a, b
	ld hl, wSlidingTilePuzzleWidth
	cp [hl]
	jr nc, .checkDownCell
	call IsCellEmpty
	jr c, .slideTile
.checkDownCell
	pop bc
	push bc
	inc c
	ld a, c
	ld hl, wSlidingTilePuzzleHeight
	cp [hl]
	jr nc, .checkLeftCell
	call IsCellEmpty
	jr c, .slideTile
.checkLeftCell
	pop bc
	push bc
	dec b
	ld a, b
	cp $ff
	jr z, .noOpenCells
	call IsCellEmpty
	jr nc, .noOpenCells
.slideTile
	pop de
	; de = original coords
	; bc = desintation coords
	call GetCellAddress
	ld b, d
	ld c, e
	ld d, h
	ld e, l
	call GetCellAddress
	; de = address of destination cell
	; hl = address of original cell
	; Swap the two values.
	ld a, [hl]
	push hl
	ld b, a
	ld h, d
	ld l, e
	ld a, [hl]
	pop hl
	ld [hl], a
	ld h, d
	ld l, e
	ld a, b
	ld [hl], a
	call DrawSlidingTilePuzzle
	jp SlidingTilePuzzleMain
.noOpenCells
	pop bc
.noButtonPress
	jp SlidingTilePuzzleMain

SlidingPuzzleSolved:
	scf
	ret

IsCellEmpty:
	; Checks if the puzzle cell at the given coordinates is empty.
	; bc = x-y coordinates
	; Sets carry flag if it's empty.
	call GetCellAddress
	ld a, [hl]
	and a
	ret nz  ; carry flag is reset by "and a"
	; empty cell
	scf
	ret

GetCellAddress:
	; Gets the memory address of the given puzzle cell.
	; bc = x-y coords
	push de
	push bc
	ld hl, wSlidingTilePuzzleCells
	ld d, 0
	ld a, [wSlidingTilePuzzleWidth]
	ld e, a
	ld a, c
.addWidthLoop
	and a
	jr z, .doneAddWidthLoop
	add hl, de
	dec a
	jr .addWidthLoop
.doneAddWidthLoop
	ld d, 0
	ld e, b
	add hl, de
	pop bc
	pop de
	ret

DrawSlidingTilePuzzle:
	ld hl, wTileMap
	call GetTilePuzzleLeftColumn
	ld b, 0
	ld c, a
	add hl, bc
	call GetTilePuzzleTopRow
	ld b, a
	sla a
	sla a
	sla a
	add b
	add b
	sla a  ; multiplied a by 20
	ld b, 0
	ld c, a
	add hl, bc  ; hl = hlcoord puzzle_width, puzzle_height
	ld d, h
	ld e, l
	ld hl, wSlidingTilePuzzleCells
	ld a, [wSlidingTilePuzzleHeight]
	inc a
	ld b, a  ; b = puzzle height + 1
.outerLoop
	dec b
	ret z
	ld a, [wSlidingTilePuzzleWidth]
	inc a
	ld c, a  ; c = puzzle width + 1
.innerLoop
	dec c
	jr z, .innerLoopDone
	push bc
	ld a, [hli] ; tile index
	push hl
	ld c, a  ; c = tile index
	ld hl, wSlidingTilePuzzleTileMapPointer
	ld a, [hli]
	push af
	ld a, [hl]
	ld h, a
	pop af
	ld l, a  ; hl = pointer to tile map
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr nz, .notSize1
	; 1x1-sized tiles
	ld b, 0
	add hl, bc
	ld a, [hli] ; a = true tile id
	ld [de], a
	inc de
	jr .continue
.notSize1
	; puzzle is 2x2- or 3x3-sized tiles
	push de
	; de points to screen position
	; hl points to tilemap
	; c = tile index
	ld b, c
	sla c
	sla c
	ld a, [wSlidingTilePuzzleTileSize]
	cp 2
	jr z, .gotOffset
	sla c
	ld a, c
	add b
	ld c, a
.gotOffset
	ld b, 0
	add hl, bc  ; hl points to tilemap entry for current puzzle tile index
	push hl
	push de
	pop hl
	pop de  ; hl = screen position, de = tilemap entry
	ld a, [wSlidingTilePuzzleTileSize]
	cp 3
	jr z, .size3
	ld bc, 18  ; width of screen - 2
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	add hl, bc
	ld a, [de]	
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	pop de
	inc de
	inc de
	jr .continue
.size3
	ld bc, 17  ; width of screen - 3
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	add hl, bc
	ld a, [de]	
	ld [hli], a
	inc de
	ld a, [de]	
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	add hl, bc
	ld a, [de]	
	ld [hli], a
	inc de
	ld a, [de]	
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	pop de
	inc de
	inc de
	inc de
.continue
	pop hl
	pop bc
	jr .innerLoop
.innerLoopDone
	push hl
	call .advanceRowOffset
	add hl, de
	ld d, h
	ld e, l
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr z, .continueToOuterLoop
	; 2x2- or 3x3-sized puzzle tiles
	call .advanceRowOffset
	add hl, de
	ld d, h
	ld e, l
	ld a, [wSlidingTilePuzzleTileSize]
	cp 2
	jr z, .continueToOuterLoop
	call .advanceRowOffset
	add hl, de
	ld d, h
	ld e, l
.continueToOuterLoop
	pop hl
	jp .outerLoop
.advanceRowOffset
	ld a, [wSlidingTilePuzzleWidth]
	ld l, a
	ld a, 20
	sub l
	ld l, a
	ld h, 0  ; hl = (20 - puzzle width)
	ret

MoveSlidingTilePuzzleCursor:
	; Animates the cursor moving to a new tile
	; Input: d = button direction
	ld e, 4 + 1
.loop
	dec e
	jr z, .done
	ld a, d
	cp D_UP
	jr nz, .checkRight
	push de
	ld d, 0
	ld a, -8
	add e
	ld e, a
	jr .continue
.checkRight
	cp D_RIGHT
	jr nz, .checkDown
	push de
	ld a, 8
	sub e
	ld d, a
	ld e, 0
	jr .continue
.checkDown
	cp D_DOWN
	jr nz, .left
	push de
	ld d, 0
	ld a, 8
	sub e
	ld e, a
	jr .continue
.left
	push de
	ld a, -8
	add e
	ld d, a
	ld e, 0
.continue
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr z, .draw
	ld h, d
	ld l, e
	sla d
	sla e
	cp 2
	jr z, .draw
	add hl, de
	ld d, h
	ld e, l
.draw
	call DrawSlidingTilePuzzleCursor
	call DelayFrame
	pop de
	jr .loop
.done
	ret

DrawSlidingTilePuzzleCursor:
	ld a, [wSlidingTilePuzzleTileSize]
	cp 2
	jp z, DrawSlidingTilePuzzleCursorSize2
	cp 3
	jp z, DrawSlidingTilePuzzleCursorSize3
DrawSlidingTilePuzzleCursorSize1:
	; d = x-offset
	; e = y-offset
	ld hl, wOAMBuffer
	call GetCursorYCoordinate
	add e
	ld [hli], a
	call GetCursorXCoordinate
	add d
	ld [hli], a
	ld a, $f3
	ld [hli], a
	ret

DrawSlidingTilePuzzleCursorSize2:
	; d = x-offset
	; e = y-offset
	ld hl, wOAMBuffer
	call GetCursorYCoordinate
	add e
	ld b, a ; b = y coordinate
	call GetCursorXCoordinate
	add d
	ld c, a ; c = x coordinate
	; Top-Left tile of 2x2 cursor
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $f6
	ld [hli], a
	xor a
	ld [hli], a
	; Top-Right tile of 2x2 cursor
	ld a, b
	ld [hli], a
	ld a, c
	add 8
	ld [hli], a
	ld a, $f7
	ld [hli], a
	xor a
	ld [hli], a
	; Bottom-Left tile of 2x2 cursor
	ld a, b
	add 8
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $f8
	ld [hli], a
	xor a
	ld [hli], a
	; Bottom-Right tile of 2x2 cursor
	ld a, b
	add 8
	ld [hli], a
	ld a, c
	add 8
	ld [hli], a
	ld a, $f9
	ld [hli], a
	xor a
	ld [hli], a
	ret

DrawSlidingTilePuzzleCursorSize3:
	; d = x-offset
	; e = y-offset
	ld hl, wOAMBuffer
	call GetCursorYCoordinate
	add e
	ld b, a ; b = y coordinate
	call GetCursorXCoordinate
	add d
	ld c, a ; c = x coordinate
	; Top-Left tile of 3x3 cursor
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $f6
	ld [hli], a
	xor a
	ld [hli], a
	; Top-Right tile of 3x3 cursor
	ld a, b
	ld [hli], a
	ld a, c
	add 16
	ld [hli], a
	ld a, $f7
	ld [hli], a
	xor a
	ld [hli], a
	; Bottom-Left tile of 3x3 cursor
	ld a, b
	add 16
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $f8
	ld [hli], a
	xor a
	ld [hli], a
	; Bottom-Right tile of 3x3 cursor
	ld a, b
	add 16
	ld [hli], a
	ld a, c
	add 16
	ld [hli], a
	ld a, $f9
	ld [hli], a
	xor a
	ld [hli], a
	ret

GetCursorYCoordinate:
	push bc
	ld a, [wSlidingTilePuzzleY]
	sla a
	sla a
	sla a ; multiply by 8 pixels
	ld b, a
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr z, .continue
	ld a, b
	sla a
	ld b, a
	ld a, [wSlidingTilePuzzleTileSize]
	cp 2
	jr z, .continue
	ld a, b
	srl b
	add b
	ld b, a
.continue
	call GetTilePuzzleTopRow
	sla a
	sla a
	sla a  ; multiply a by 8 pixels
	add 16
	add a, b
	pop bc
	ret

GetCursorXCoordinate:
	push bc
	ld a, [wSlidingTilePuzzleX]
	sla a
	sla a
	sla a ; multiply by 8 pixels
	ld b, a
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr z, .continue
	ld a, b
	sla a
	ld b, a
	ld a, [wSlidingTilePuzzleTileSize]
	cp 2
	jp z, .continue
	ld a, b
	srl b
	add b
	ld b, a
.continue
	call GetTilePuzzleLeftColumn
	sla a
	sla a
	sla a ; mulitply a by 8 pixels
	add 8
	add a, b
	pop bc
	ret

GetTilePuzzleTopRow:
	; Gets the tile row index for the puzzle's top row, based on the puzzle's height.
	; It tries to center the puzzle on the screen.
	; Returns:  a = row index
	push bc
	ld a, [wSlidingTilePuzzleHeight]
	ld b, a
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr z, .next
	sla b
	cp 2
	jr z, .next
	ld a, b
	srl b
	add b
	ld b, a
.next
	; b = puzzle's height in 8x8-pixel tiles
	ld a, 18
	sub b
	srl a
	pop bc
	ret

GetTilePuzzleLeftColumn:
	; Gets the tile column index for the puzzle's left column, based on the puzzle's width.
	; It tries to center the puzzle on the screen.
	; Returns:  a = column index
	push bc
	ld a, [wSlidingTilePuzzleWidth]
	ld b, a
	ld a, [wSlidingTilePuzzleTileSize]
	cp 1
	jr z, .next
	sla b
	cp 2
	jr z, .next
	ld a, b
	srl b
	add b
	ld b, a
.next
	; b = puzzle's width in 8x8-pixel tiles
	ld a, 20
	sub b
	srl a
	pop bc
	ret

IsSlidingPuzzleSolved:
	; Checks if the current puzzle configuration is the solution.
	; Sets carry flag if puzzle is solved.
	ld hl, wSlidingTilePuzzleCells
	ld a, [wSlidingTilePuzzleHeight]
	ld c, a
	ld a, [wSlidingTilePuzzleWidth]
	ld b, a
.sizeLoop
	dec c
	jr z, .gotSize
	add b
	jr .sizeLoop
.gotSize
	dec a
	ld b, a
	ld a, [hli]
	cp 1
	jr nz, .notSolved
	ld c, 2
.loop
	dec b
	jr z, .solved
	ld a, [hli]
	cp c
	jr nz, .notSolved
	inc c
	jr .loop
.solved
	scf
	ret
.notSolved
	and a  ; reset carry flag
	ret

LoadSlidingTilePuzzle:
	; Loads the puzzle indicated by [wWhichSlidingPuzzle]
	ld a, [wWhichSlidingPuzzle]
	add a
	ld b, 0
	ld c, a
	ld hl, SlidingTilePuzzles
	add hl, bc ; hl points to puzzle header pointer
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld h, a
	ld l, e  ; hl point to puzzle header
	ld de, wSlidingTilePuzzleHeader
	ld bc, (wSlidingTilePuzzleHeaderEnd - wSlidingTilePuzzleHeader)
	call CopyData
	; Initialize the puzzle tiles' positions
	ld de, wSlidingTilePuzzleInitialPositions
	ld a, [de]
	inc de
	ld l, a
	ld a, [de]
	ld h, a
	ld de, wSlidingTilePuzzleCells
	ld bc, (wSlidingTilePuzzleCellsEnd - wSlidingTilePuzzleCells)
	call CopyData
	; Randomly set initial cursor coordinates
	ld a, [wSlidingTilePuzzleWidth]
	ld b, a
.randomLoopWidth
	call Random
	and $1f
	cp b
	jr nc, .randomLoopWidth
	ld [wSlidingTilePuzzleX], a
	ld a, [wSlidingTilePuzzleHeight]
	ld b, a
.randomLoopHeight
	call Random
	and $1f
	cp b
	jr nc, .randomLoopHeight
	ld [wSlidingTilePuzzleY], a
	ret

SlidingTilePuzzles:
	dw SlidingTilePuzzle1
	dw SlidingTilePuzzle2
	dw SlidingTilePuzzle3

SlidingTilePuzzle1:
	db 2  ; 2x2-sized tiles
	db $3, $4 ; 3x4 puzzle
	dw SlidingTilePuzzle1TileMap
	dw SlidingTilePuzzle1InitialPositions

SlidingTilePuzzle1TileMap:
	db $c0, $c0, $c0, $c0
	db $80, $80, $80, $80
	db $81, $81, $81, $81
	db $82, $82, $82, $82
	db $83, $83, $83, $83
	db $84, $84, $84, $84
	db $85, $85, $85, $85
	db $86, $86, $86, $86
	db $87, $87, $87, $87
	db $88, $88, $88, $88
	db $89, $89, $89, $89
	db $8a, $8a, $8a, $8a

SlidingTilePuzzle1InitialPositions:
	db $01, $02, $03
	db $04, $08, $05
	db $0a, $00, $06
	db $0b, $07, $09

SlidingTilePuzzle2:
	db 1  ; 1x1-sized tiles
	db $4, $4
	dw SlidingTilePuzzle2TileMap
	dw SlidingTilePuzzle2InitialPositions

SlidingTilePuzzle2TileMap:
	db $c0
	db $80
	db $81
	db $82
	db $83
	db $84
	db $85
	db $86
	db $87
	db $88
	db $89
	db $8a
	db $8b
	db $8c
	db $8d
	db $8e

SlidingTilePuzzle2InitialPositions:
	db $05, $01, $02, $03
	db $00, $0a, $06, $04
	db $09, $07, $0c, $08
	db $0d, $0e, $0b, $0f

SlidingTilePuzzle3:
	db 3  ; 3x3-sized tiles
	db $3, $4 ; 3x4 puzzle
	dw SlidingTilePuzzle3TileMap
	dw SlidingTilePuzzle3InitialPositions

SlidingTilePuzzle3TileMap:
	db $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0
	db $80, $80, $80, $80, $80, $80, $80, $80, $80
	db $81, $81, $81, $81, $81, $81, $81, $81, $81
	db $82, $82, $82, $82, $82, $82, $82, $82, $82
	db $83, $83, $83, $83, $83, $83, $83, $83, $83
	db $84, $84, $84, $84, $84, $84, $84, $84, $84
	db $85, $85, $85, $85, $85, $85, $85, $85, $85
	db $86, $86, $86, $86, $86, $86, $86, $86, $86
	db $87, $87, $87, $87, $87, $87, $87, $87, $87
	db $88, $88, $88, $88, $88, $88, $88, $88, $88
	db $89, $89, $89, $89, $89, $89, $89, $89, $89
	db $8a, $8a, $8a, $8a, $8a, $8a, $8a, $8a, $8a

SlidingTilePuzzle3InitialPositions:
	db $01, $02, $03
	db $04, $08, $05
	db $0a, $00, $06
	db $0b, $07, $09
