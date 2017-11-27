SpritePalettes: ; Taken from pokemon GSC.
; Palette 4 is used for flashing pokeballs in the pokecenter.
; Palette 5 is used for exclamation mark bubbles.
; Palettes 6-7 aren't used, I don't know what they were used for in GSC? Trees maybe?

; 0
	RGB 27,31,27
	RGB 31,19,10
	RGB 31,7,1
	RGB 0,0,0

; 1
	RGB 27,31,27
	RGB 31,19,10
	RGB 10,9,31
	RGB 0,0,0

; 2
	RGB 27,31,27
	RGB 31,19,10
	RGB 7,23,3
	RGB 0,0,0

; 3
	RGB 27,31,27
	RGB 31,19,10
	RGB 15,10,3
	RGB 0,0,0

; 4
	RGB 27,31,27
	RGB 31,19,10
	RGB 30,10,6
	RGB 0,0,0

; 5
	RGB 31,31,31
	RGB 31,31,31
	RGB 13,13,13
	RGB 0,0,0

; 6
	RGB 22,31,10
	RGB 12,25,1
	RGB 5,14,0
	RGB 7,7,7

; 7
	RGB 27,31,27
	RGB 24,18,7
	RGB 20,15,3
	RGB 7,7,7


AttackSpritePalettes:
	; GREY
	RGB 31,31,31
	RGB 25,25,25
	RGB 13,13,13
	RGB 0,0,0
	; BLUE
	RGB 31,31,31
	RGB 8,12,31
	RGB 1,4,31
	RGB 0,0,0
	; RED
	RGB 31,31,31
	RGB 31,19,10
	RGB 31,7,1
	RGB 0,0,0
	; BROWN
	RGB 31,31,31
	RGB 20,14,0
	RGB 10,6,0
	RGB 0,0,0
	; YELLOW (4)
	RGB 31,31,31
	RGB 29,29,5
	RGB 19,19,0
	RGB 0,0,0
	; GREEN
	RGB 31,31,31
	RGB 13,31,7
	RGB 2,24,2
	RGB 0,0,0
	; ICE
	RGB 31,31,31
	RGB 0,20,26
	RGB 9,22,30
	RGB 0,0,0
	; PURPLE
	RGB 31,31,31
	RGB 16,0,20
	RGB 12,0,13
	RGB 0,0,0

; Not related to sprites, move this somewhere else?
SlotPaletteMap:
;IF DEF(_RED)
	INCBIN "color/data/slotpalettemap_red.bin"
;ELSE
;	INCBIN "color/data/slotpalettemap_blue.bin"
;ENDC

SlotSpritePaletteMap:
	; Seven
	db ATK_PAL_RED,ATK_PAL_RED,ATK_PAL_RED,ATK_PAL_RED

	; Bar
	db ATK_PAL_BLUE,ATK_PAL_BLUE,ATK_PAL_BLUE,ATK_PAL_BLUE

	; Cherry
	db ATK_PAL_RED,ATK_PAL_RED,ATK_PAL_RED,ATK_PAL_RED

	; Fish (red), Jigglypuff (blue)
	db ATK_PAL_RED,ATK_PAL_RED,ATK_PAL_RED,ATK_PAL_RED

	; Penguin/Bird/Something (red), Dugtrio (blue)
;	IF DEF(_RED)
;	db ATK_PAL_BLUE,ATK_PAL_BLUE,ATK_PAL_BLUE,ATK_PAL_BLUE
;	ELSE ; _BLUE
	db ATK_PAL_BROWN,ATK_PAL_BROWN,ATK_PAL_BROWN,ATK_PAL_BROWN
;	ENDC

	; Rat
	db ATK_PAL_BROWN,ATK_PAL_BROWN,ATK_PAL_BROWN,ATK_PAL_BROWN
