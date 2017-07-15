W2_BgPaletteData  EQU $d000
W2_SprPaletteData EQU $d040

W2_LastBGP  EQU $d080
W2_LastOBP0 EQU $d081
W2_LastOBP1 EQU $d082

; If W2_TileBasedPalettes is set, each number corresponds to a tile. (takes $180 bytes)
; Otherwise this is a 20x18 map of palettes. (takes $168 bytes)
W2_TilesetPaletteMap	EQU $d200

; Each number here corresponds to a tile, but this isn't used for
; overworld sprites. I've got a better system for that.
W2_SpritePaletteMap		EQU $d400

; Palette calculations for wTileMap are stored here before vblank.
W2_ScreenPalettesBuffer	EQU $d500 ; 32x6 bytes (DMA-able), $d500-$d5c0

W2_TownMapLoaded               EQU $d700
W2_TileBasedPalettes           EQU $d701
W2_StaticPaletteChanged        EQU $d702 ; Set to a number >=3 if palette map is modified, since the window is drawn in thirds. Only for when TileBasedPalettes == 0.
W2_UseOBP1                     EQU $d703 ; If set, sprite palettes 4-7 use OBP1 instead of OBP0
W2_BgPaletteDataBuffer         EQU $d704
W2_SprPaletteDataBuffer        EQU $d744

W2_BgPaletteDataModified       EQU $d784
W2_SprPaletteDataModified      EQU $d785

; Analagous to StaticPaletteChanged, but only used between Pre-vblank and
; actual-vblank routines.
W2_StaticPaletteModified       EQU $d786

W2_LastAutoCopyDest            EQU $d787

; In bank 1, the stack starts at $dfff. So, that's also the stack here when bank 2 is
; loaded. Don't use anything too close to there.
