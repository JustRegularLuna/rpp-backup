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
SET_PAL_WHOLE_SCREEN         EQU $11
SET_PAL_TRAINER_WHOLE_SCREEN EQU $12
SET_PAL_VERSION_SCREEN       EQU $13
SET_PAL_GENDER_SELECT        EQU $14
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
	const PAL_SNEASEL_OLD          ; $1A
	const PAL_BELLOSSOM_OLD        ; $1B
	const PAL_TOGEKISS_OLD         ; $1C
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


const_value = 0
	const PAL_BULBASAUR
	const PAL_IVYSAUR
	const PAL_VENUSAUR
	const PAL_CHARMANDER
	const PAL_CHARMELEON
	const PAL_CHARIZARD
	const PAL_SQUIRTLE
	const PAL_WARTORTLE
	const PAL_BLASTOISE
	const PAL_CATERPIE
	const PAL_METAPOD
	const PAL_BUTTERFREE
	const PAL_WEEDLE
	const PAL_KAKUNA
	const PAL_BEEDRILL
	const PAL_PIDGEY
	const PAL_PIDGEOTTO
	const PAL_PIDGEOT
	const PAL_RATTATA
	const PAL_RATICATE
	const PAL_SPEAROW
	const PAL_FEAROW
	const PAL_EKANS
	const PAL_ARBOK
	const PAL_PIKACHU
	const PAL_RAICHU
	const PAL_SANDSHREW
	const PAL_SANDSLASH
	const PAL_NIDORAN_F
	const PAL_NIDORINA
	const PAL_NIDOQUEEN
	const PAL_NIDORAN_M
	const PAL_NIDORINO
	const PAL_NIDOKING
	const PAL_CLEFAIRY
	const PAL_CLEFABLE
	const PAL_VULPIX
	const PAL_NINETALES
	const PAL_JIGGLYPUFF
	const PAL_WIGGLYTUFF
	const PAL_ZUBAT
	const PAL_GOLBAT
	const PAL_ODDISH
	const PAL_GLOOM
	const PAL_VILEPLUME
	const PAL_PARAS
	const PAL_PARASECT
	const PAL_VENONAT
	const PAL_VENOMOTH
	const PAL_DIGLETT
	const PAL_DUGTRIO
	const PAL_MEOWTH
	const PAL_PERSIAN
	const PAL_PSYDUCK
	const PAL_GOLDUCK
	const PAL_MANKEY
	const PAL_PRIMEAPE
	const PAL_GROWLITHE
	const PAL_ARCANINE
	const PAL_POLIWAG
	const PAL_POLIWHIRL
	const PAL_POLIWRATH
	const PAL_ABRA
	const PAL_KADABRA
	const PAL_ALAKAZAM
	const PAL_MACHOP
	const PAL_MACHOKE
	const PAL_MACHAMP
	const PAL_BELLSPROUT
	const PAL_WEEPINBELL
	const PAL_VICTREEBEL
	const PAL_TENTACOOL
	const PAL_TENTACRUEL
	const PAL_GEODUDE
	const PAL_GRAVELER
	const PAL_GOLEM
	const PAL_PONYTA
	const PAL_RAPIDASH
	const PAL_SLOWPOKE
	const PAL_SLOWBRO
	const PAL_MAGNEMITE
	const PAL_MAGNETON
	const PAL_FARFETCH_D
	const PAL_DODUO
	const PAL_DODRIO
	const PAL_SEEL
	const PAL_DEWGONG
	const PAL_GRIMER
	const PAL_MUK
	const PAL_SHELLDER
	const PAL_CLOYSTER
	const PAL_GASTLY
	const PAL_HAUNTER
	const PAL_GENGAR
	const PAL_ONIX
	const PAL_DROWZEE
	const PAL_HYPNO
	const PAL_KRABBY
	const PAL_KINGLER
	const PAL_VOLTORB
	const PAL_ELECTRODE
	const PAL_EXEGGCUTE
	const PAL_EXEGGUTOR
	const PAL_CUBONE
	const PAL_MAROWAK
	const PAL_HITMONLEE
	const PAL_HITMONCHAN
	const PAL_LICKITUNG
	const PAL_KOFFING
	const PAL_WEEZING
	const PAL_RHYHORN
	const PAL_RHYDON
	const PAL_CHANSEY
	const PAL_TANGELA
	const PAL_KANGASKHAN
	const PAL_HORSEA
	const PAL_SEADRA
	const PAL_GOLDEEN
	const PAL_SEAKING
	const PAL_STARYU
	const PAL_STARMIE
	const PAL_MR_MIME
	const PAL_SCYTHER
	const PAL_JYNX
	const PAL_ELECTABUZZ
	const PAL_MAGMAR
	const PAL_PINSIR
	const PAL_TAUROS
	const PAL_MAGIKARP
	const PAL_GYARADOS
	const PAL_LAPRAS
	const PAL_DITTO
	const PAL_EEVEE
	const PAL_VAPOREON
	const PAL_JOLTEON
	const PAL_FLAREON
	const PAL_PORYGON
	const PAL_OMANYTE
	const PAL_OMASTAR
	const PAL_KABUTO
	const PAL_KABUTOPS
	const PAL_AERODACTYL
	const PAL_SNORLAX
	const PAL_ARTICUNO
	const PAL_ZAPDOS
	const PAL_MOLTRES
	const PAL_DRATINI
	const PAL_DRAGONAIR
	const PAL_DRAGONITE
	const PAL_MEWTWO
	const PAL_MEW
	const PAL_LUGIA
	const PAL_HOUNDOUR
	const PAL_HOUNDOOM
	const PAL_MURKROW
	const PAL_HONCHKROW
	const PAL_HERACROSS
	const PAL_ESPEON
	const PAL_UMBREON
	const PAL_GLACEON
	const PAL_LEAFEON
	const PAL_SYLVEON
	const PAL_SCIZOR
	const PAL_STEELIX
	const PAL_CROBAT
	const PAL_POLITOED
	const PAL_SLOWKING
	const PAL_BELLOSSOM
	const PAL_KINGDRA
	const PAL_BLISSEY
	const PAL_PORYGON2
	const PAL_PORYGONZ
	const PAL_MAGMORTAR
	const PAL_ELECTIVIRE
	const PAL_MAGNEZONE
	const PAL_RHYPERIOR
	const PAL_TANGROWTH
	const PAL_LICKILICKY
	const PAL_TOGEPI
	const PAL_TOGETIC
	const PAL_TOGEKISS
	const PAL_SNEASEL
	const PAL_WEAVILE
	const PAL_SKARMORY
	const PAL_MISDREAVUS
	const PAL_MISMAGIUS
	const PAL_MILTANK
	const PAL_CHINCHOU
	const PAL_LANTURN
	const PAL_SLUGMA
	const PAL_MAGCARGO
	const PAL_TORKOAL
	const PAL_LATIAS
	const PAL_LATIOS
	const PAL_HITMONTOP
	const PAL_TYROGUE
	const PAL_PICHU
	const PAL_CLEFFA
	const PAL_IGGLYBUFF
	const PAL_SMOOCHUM
	const PAL_ELEKID
	const PAL_MAGBY
	const PAL_MIME_JR
	const PAL_HAPPINY
	const PAL_MUNCHLAX


const_value = 0
	const PAL_YOUNGSTER
	const PAL_BUGCATCHER
	const PAL_LASS
	const PAL_SAILOR
	const PAL_JR_TRAINER_M
	const PAL_JR_TRAINER_F
	const PAL_POKEMANIAC
	const PAL_SUPERNERD
	const PAL_HIKER
	const PAL_BIKER
	const PAL_BURGLAR
	const PAL_ENGINEER
	const PAL_COUPLE
	const PAL_FISHERMAN
	const PAL_SWIMMER
	const PAL_CUEBALL
	const PAL_GAMBLER
	const PAL_BEAUTY
	const PAL_PSYCHIC
	const PAL_ROCKER
	const PAL_JUGGLER
	const PAL_TAMER
	const PAL_BIRDKEEPER
	const PAL_BLACKBELT
	const PAL_GARY1
	const PAL_SWIMMER_F
	const PAL_ROCKET_F
	const PAL_SCIENTIST
	const PAL_GIOVANNI
	const PAL_ROCKET
	const PAL_COOLTRAINER_M
	const PAL_COOLTRAINER_F
	const PAL_BRUNO
	const PAL_BROCK
	const PAL_MISTY
	const PAL_LT_SURGE
	const PAL_ERIKA
	const PAL_KOGA
	const PAL_BLAINE
	const PAL_SABRINA
	const PAL_GENTLEMAN
	const PAL_GARY2
	const PAL_GARY3
	const PAL_LORELEI
	const PAL_CHANNELER
	const PAL_AGATHA
	const PAL_LANCE
	const PAL_HEX_MANIAC
	const PAL_PKMN_TRAINER
	
	const PAL_TRACEY
	const PAL_EXECUTIVE_F
	const PAL_EXECUTIVE_M
	const PAL_ROCKER_F
	const PAL_JESSIE_JAMES
	const PAL_COSPLAY_GIRL
	const PAL_JANINE
	const PAL_PLAYER_M
	const PAL_PLAYER_F
	const PAL_PROF_OAK
	const PAL_PI_TRAINER
	const PAL_FLANNERY
	const PAL_JESSIE
	const PAL_JAMES
	const PAL_GIOVANNI_2
	
	const PAL_HERO
