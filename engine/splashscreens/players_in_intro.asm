ShowPlayerLargePics::
; Start by clearing and turning off the screen
	call ClearScreen
	call DisableLCD
; load the graphics for the screen
	ld hl, LargePlayerPics
	ld de, vChars2
	ld bc, LargePlayerPicsEnd - LargePlayerPics
	call CopyData	
; load the tilemap for the screen
	ld hl, LargePlayerPicsTilemap
	ld de, wTileMap
	ld bc, LargePlayerPicsTilemapEnd - LargePlayerPicsTilemap
	call CopyData
; turn the screen back on
	call EnableLCD
	call Delay3
	call GBPalNormal
	ret

LargePlayerPics:
	INCBIN "gfx/large_players.norepeat.2bpp"
LargePlayerPicsEnd:

LargePlayerPicsTilemap:
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$00,$00,$00
	DB $04,$05,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$08
	DB $09,$00,$00,$0A,$0B,$0C,$0D,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$0E,$0F,$10,$00,$00,$00,$11,$12,$13,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$14,$15,$16,$17,$00,$00,$18,$19,$1A,$1B,$1C
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$1D,$1E,$1F,$20,$21,$00,$22
	DB $23,$24,$25,$26,$00,$00,$00,$00,$00,$00,$00,$00,$00,$27,$28,$29
	DB $2A,$2B,$00,$2C,$2D,$2E,$2F,$30,$00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$31,$32,$33,$34,$35,$00,$36,$37,$38,$39,$3A,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$3B,$3C,$3D,$3E,$00,$00,$3F,$40,$41,$42,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$43,$44,$45,$46,$00,$00,$47
	DB $48,$49,$4A,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4B,$4C,$4D
	DB $4E,$00,$00,$4F,$50,$00,$51,$00,$00,$00,$00,$00,$00,$00,$00,$00
LargePlayerPicsTilemapEnd:
