
EraseSSAnneWithColor::
	; Tilemap
	ld hl, wVermilionDockTileMapBuffer
	ld bc, (5 * BG_MAP_WIDTH) + SCREEN_WIDTH
	ld a, $14 ; water tile
	call FillMemory

	ld hl, vBGMap0 + 10 * BG_MAP_WIDTH
	ld de, wVermilionDockTileMapBuffer
	ld bc, (6 * BG_MAP_WIDTH) / 16
	call CopyVideoData

	; Palette

	ld hl, wVermilionDockTileMapBuffer
	ld bc, (5 * BG_MAP_WIDTH) + SCREEN_WIDTH
	ld a, PAL_BG_WATER
	call FillMemory

	; Note: setting the vram bank to 1 is a bit dangerous, since it'll be left at
	; 1 for most of vblank. In this specific case, it seems to work ok (since vblank
	; doesn't need to do anything else at this point in time).
	ld a,1
	ld [rVBK],a

	ld hl, vBGMap0 + 10 * BG_MAP_WIDTH
	ld de, wVermilionDockTileMapBuffer
	ld bc, (6 * BG_MAP_WIDTH) / 16
	call CopyVideoData

	xor a
	ld [rVBK],a
	ret
