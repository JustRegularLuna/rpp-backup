LoadMateoPresentsScreen::
	xor a
	ld [hWY], a
	call ClearScreen
	call DisableLCD

; HAX: Add a warning screen about VBA issues
	call LoadFontTilePatterns
; turn the screen back on
	call EnableLCD
	call Delay3
	call GBPalNormal
; display the warning text
	coord hl, 1, 1
	ld de, VBAWarningText
	call PlaceString
; wait for the player to press A
	call WaitForTextScrollButtonPress
; clear screen again, and load the original Mateo Presents screen
	call ClearScreen
	call DisableLCD
	
; load the graphics for the screen
	ld hl, MateoPresentsGraphics1
	ld de, vChars2
	ld bc, MateoPresentsGraphics1End - MateoPresentsGraphics1
	call CopyData
	
	ld hl, MateoPresentsGraphics2
	ld de, vFont
	ld bc, MateoPresentsGraphics2End - MateoPresentsGraphics2
	call CopyData
	
; load the tilemap for the screen
	ld hl, MateoPresentsTilemap
	ld de, wTileMap
	ld bc, MateoPresentsTilemapEnd - MateoPresentsTilemap
	call CopyData
	
	call EnableLCD
	call Delay3
	call GBPalNormal
	ret
	
MateoPresentsGraphics1:
	INCBIN "gfx/mateo_presents.2bpp"
MateoPresentsGraphics1End:

MateoPresentsGraphics2:
	INCBIN "gfx/mateo_presents2.t4.2bpp"
MateoPresentsGraphics2End:

MateoPresentsTilemap:
	DB $00,$00,$00,$01,$02,$03,$04,$05,$06,$02,$03,$04,$05,$07,$08,$09
	DB $0A,$00,$00,$00,$00,$0B,$0C,$0D,$0E,$0E,$0E,$0E,$0F,$0E,$0E,$0E
	DB $0E,$0E,$10,$0E,$11,$12,$13,$00,$14,$15,$0E,$0E,$0E,$0E,$0E,$0E
	DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$16,$17,$18,$19,$1A,$1B,$1C
	DB $1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C
	DB $2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C
	DB $3D,$3E,$0E,$3F,$40,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$41,$42,$43,$44,$0E,$0E,$0E,$0E,$0E
	DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$45,$46,$00,$00,$00,$47,$48
	DB $49,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$4A,$0E,$4B,$4C,$4D,$00
	DB $00,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$53,$54,$55,$58,$59
	DB $5A,$00,$00,$00,$00,$5B,$0E,$5C,$5D,$00,$5E,$00,$00,$00,$5F,$60
	DB $61,$00,$00,$00,$00,$00,$00,$00,$00,$62,$63,$64,$65,$66,$00,$67
	DB $68,$69,$6A,$6B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DB $6C,$6D,$6E,$6F,$70,$71,$72,$73,$74,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$75,$76,$77,$78,$79,$7A,$7B,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$7C,$7D,$7E,$7F,$80,$81
	DB $82,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$83,$84,$85
	DB $86,$87,$88,$89,$8A,$8B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DB $8C,$8D,$8E,$8F,$90,$91,$92,$93,$94,$95,$96,$00,$97,$00,$00,$00
	DB $00,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6
	DB $A7,$A8,$A9,$00,$AA,$AB,$AC,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$B4,$B5
	DB $B6,$B7,$AA,$B8,$00,$B9,$BA,$BB
MateoPresentsTilemapEnd:

VBAWarningText:
	db   "     WARNING!"
	next "This hack has"
	next "known issues with"
	next "VBA. Please use"
	next "Gambatte, BGB, etc"
	next "Playing on a 3DS or"
	next "Mobile should work"
	next "too. Just not VBA."
	next "PRESS A TO CONTINUE@"
