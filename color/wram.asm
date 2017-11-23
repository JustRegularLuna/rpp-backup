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
W2_ScreenPalettesBuffer        EQU $d500 ; 32x6 bytes (DMA-able), $d500-$d5c0

W2_TownMapLoaded               EQU $d700
W2_TileBasedPalettes           EQU $d701
W2_StaticPaletteMapChanged     EQU $d702 ; Set to a number >=3 if palette map is modified, since the window is drawn in thirds. Only for when TileBasedPalettes == 0.
W2_UseOBP1                     EQU $d703 ; If set, sprite palettes 4-7 use OBP1 instead of OBP0

; These are like W2_BgPaletteData/SprPaletteData, but they account for BGP/OBP0/OBP1.
W2_BgPaletteDataBuffer         EQU $d704
W2_SprPaletteDataBuffer        EQU $d744

W2_BgPaletteDataModified       EQU $d784
W2_SprPaletteDataModified      EQU $d785

; Analagous to StaticPaletteMapChanged, but only used between Pre-vblank and
; actual-vblank routines.
W2_StaticPaletteMapChanged_vbl EQU $d786

; Former value of [H_AUTOBGTRANSFERDEST+1]. Should be $98 or $9c.
W2_LastAutoCopyDest            EQU $d787

W2_ForceBGPUpdate              EQU $d788
W2_ForceOBPUpdate              EQU $d789

; Set to 0 when vblank has updated W2_PreVBlankWindowPortion. Used to make sure that the
; pre-vblank routines are in sync with the vblank routines.
W2_UpdatedWindowPortion        EQU $d78a

; Set if a row or column on the map was drawn during the current vblank.
W2_DrewRowOrColumn             EQU $d78b

; Palette of the current pokemon (remembered here so pokemon have correct palette when
; transformed)
W2_BattleMonPalette            EQU $d78c

; Used by "WindowTransferBgRowsAndColors" function. Analagous to H_VBCOPYBGNUMROWS.
W2_VBCOPYBGNUMROWS             EQU $d78d

; In bank 1, the stack starts at $dfff. So, that's also the stack here when bank 2 is
; loaded. Don't use anything too close to there.
