BorderPalettes:
	INCBIN "gfx/red/sgbborder.map"

	ds $100

	RGB 30,29,29 ; PAL_SGB1
	RGB 25,22,25
	RGB 25,17,21
	RGB 24,14,12

	ds $18

	RGB 30,29,29 ; PAL_SGB2
	RGB 22,31,16
	RGB 27,20,6
	RGB 15,15,15

	ds $18

	RGB 30,29,29 ; PAL_SGB3
	RGB 31,31,17
	RGB 18,21,29
	RGB 15,15,15

	ds $18

SGBBorderGraphics:
	INCBIN "gfx/red/sgbborder.2bpp"
