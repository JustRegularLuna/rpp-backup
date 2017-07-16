; Copies a lot of code from engine/cut.asm.
; Had to separate them because they used to use the same oam data, but they need different
; palettes.

WriteBoulderDustAnimationOAMBlock:
	call GetBoulderDustAnimationOffsets
	ld a, $9
	ld de, BoulderDustAnimationTilesAndAttributes
	jp WriteOAMBlock

BoulderDustAnimationTilesAndAttributes:
	db $FC,$17,$FD,$17
	db $FE,$17,$FF,$17 ; Uses palette 7 (brown)

GetBoulderDustAnimationOffsets:
	ld hl, wSpriteStateData1 + 4
	ld a, [hli] ; player's sprite screen Y position
	ld b, a
	inc hl
	ld a, [hli] ; player's sprite screen X position
	ld c, a ; bc holds ypos/xpos of player's sprite
	inc hl
	inc hl
	ld a, [hl] ; a holds direction of player (00: down, 04: up, 08: left, 0C: right)
	srl a
	ld e, a
	ld d, $0 ; de holds direction (00: down, 02: up, 04: left, 06: right)
	ld hl, BoulderDustAnimationOffsets
.next
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, b
	add d
	ld b, a
	ld a, c
	add e
	ld c, a
	ret

BoulderDustAnimationOffsets:
; Each pair represents the x and y pixels offsets from the player of where the cut tree animation should be drawn
; These offsets represent 2 blocks away from the player
	db  8,  52 ; player is facing down
	db  8, -12 ; player is facing up
	db -24, 20 ; player is facing left
	db 40,  20 ; player is facing right
