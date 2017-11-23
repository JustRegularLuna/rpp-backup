SET_PAL_BATTLE_BLACK         EQU $00
SET_PAL_BATTLE               EQU $01
SET_PAL_TOWN_MAP             EQU $02
SET_PAL_STATUS_SCREEN        EQU $03
SET_PAL_POKEDEX              EQU $04
SET_PAL_SLOTS                EQU $05
SET_PAL_TITLE_SCREEN         EQU $06
SET_PAL_NIDORINO_INTRO       EQU $07
SET_PAL_GENERIC              EQU $08
SET_PAL_OVERWORLD            EQU $09
SET_PAL_PARTY_MENU           EQU $0A
SET_PAL_POKEMON_WHOLE_SCREEN EQU $0B
SET_PAL_GAME_FREAK_INTRO     EQU $0C
SET_PAL_TRAINER_CARD         EQU $0D
SET_PAL_OAK_INTRO            EQU $0E
SET_PAL_NAMING_SCREEN        EQU $0F
SET_PAL_BATTLE_AFTER_BLACK   EQU $10
UPDATE_PARTY_MENU_BLK_PACKET EQU $FC

; super game boy palettes
const_value = 0
	const PAL_TOWNMAP2             ; $00
	const PAL_SLOTS5               ; $01
	const PAL_VIRIDIAN             ; $02
	const PAL_PEWTER               ; $03
	const PAL_CERULEAN             ; $04
	const PAL_LAVENDER             ; $05
	const PAL_VERMILION            ; $06
	const PAL_CELADON              ; $07
	const PAL_FUCHSIA              ; $08
	const PAL_CINNABAR             ; $09
	const PAL_INDIGO               ; $0A
	const PAL_SAFFRON              ; $0B
	const PAL_TOWNMAP              ; $0C
	const PAL_LOGO1                ; $0D
	const PAL_LOGO2                ; $0E
	const PAL_EXP                  ; $0F
	const PAL_MEWMON               ; $10
	const PAL_BLUEMON              ; $11
	const PAL_REDMON               ; $12
	const PAL_CYANMON              ; $13
	const PAL_PURPLEMON            ; $14
	const PAL_BROWNMON             ; $15
	const PAL_GREENMON             ; $16
	const PAL_PINKMON              ; $17
	const PAL_YELLOWMON            ; $18
	const PAL_GREYMON              ; $19
	const PAL_SNEASEL              ; $1A
	const PAL_BELLOSSOM            ; $1B
	const PAL_TOGEKISS             ; $1C
	const PAL_BLUE_TRAINER         ; $1D
	const PAL_RED_TRAINER          ; $1E
	const PAL_CYAN_TRAINER         ; $1F
	const PAL_PURPLE_TRAINER       ; $20
	const PAL_BROWN_TRAINER        ; $21
	const PAL_GREEN_TRAINER        ; $22
	const PAL_PINK_TRAINER         ; $23
	const PAL_YELLOW_TRAINER       ; $24
	const PAL_SLOTS1               ; $25
	const PAL_SLOTS2               ; $26
	const PAL_SLOTS3               ; $27
	const PAL_SLOTS4               ; $28
	const PAL_BLACK                ; $29
	const PAL_GREENBAR             ; $2A
	const PAL_YELLOWBAR            ; $2B
	const PAL_REDBAR               ; $2C
	const PAL_BADGE                ; $2D
	const PAL_CAVE                 ; $2E
	const PAL_GAMEFREAK            ; $2F

	const PAL_SHINY_MEWMON         ; $30
	const PAL_SHINY_BLUEMON        ; $31
	const PAL_SHINY_REDMON         ; $32
	const PAL_SHINY_CYANMON        ; $33
	const PAL_SHINY_PURPLEMON      ; $34
	const PAL_SHINY_BROWNMON       ; $35
	const PAL_SHINY_GREENMON       ; $36
	const PAL_SHINY_PINKMON        ; $37
	const PAL_SHINY_YELLOWMON      ; $38
	const PAL_SHINY_GREYMON        ; $39
	const PAL_SHINY_SNEASEL        ; $3A
	const PAL_SHINY_BELLOSSOM      ; $3B
	const PAL_SHINY_TOGEKISS       ; $3C
	; trainer palettes are shared with pokemon...
	const PAL_SHINY_BLUE_TRAINER   ; $3D
	const PAL_SHINY_RED_TRAINER    ; $3E
	const PAL_SHINY_CYAN_TRAINER   ; $3F
	const PAL_SHINY_PURPLE_TRAINER ; $40
	const PAL_SHINY_BROWN_TRAINER  ; $41
	const PAL_SHINY_GREEN_TRAINER  ; $42
	const PAL_SHINY_PINK_TRAINER   ; $43
	const PAL_SHINY_YELLOW_TRAINER ; $44
