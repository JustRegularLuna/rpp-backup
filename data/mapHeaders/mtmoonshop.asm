MtMoonShop_h:
	db HOUSE ; tileset
	db MT_MOON_SHOP_HEIGHT, MT_MOON_SHOP_WIDTH ; dimensions (y, x)
	dw MtMoonShopBlocks, MtMoonShopTextPointers, MtMoonShopScript ; blocks, texts, scripts
	db $00 ; connections
	dw MtMoonShopObject ; objects
