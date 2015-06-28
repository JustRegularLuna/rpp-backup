MtMoonShopScript:
	jp EnableAutoTextBoxDrawing

MtMoonShopTextPointers:
	dw FossilMartText
	dw MtMoonShopText2
	dw MtMoonShopText3

INCLUDE "data/martInventories/mt_moon_square.asm"

MtMoonShopText2:
	text "This shop sells"
	line "fossils that were"
	cont "found in the cave."
	done
	db "@"

MtMoonShopText3:
	text "A lot of people"
	line "don't know this"
	cont "place is here."
	done
	db "@"

