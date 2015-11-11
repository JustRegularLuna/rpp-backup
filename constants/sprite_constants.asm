; pokemon's overworld sprites
SPRITE_MON       EQU $0
SPRITE_BALL_M    EQU $1
SPRITE_HELIX     EQU $2
SPRITE_FAIRY     EQU $3
SPRITE_BIRD_M    EQU $4
SPRITE_WATER     EQU $5
SPRITE_BUG       EQU $6
SPRITE_GRASS     EQU $7
SPRITE_SNAKE     EQU $8
SPRITE_QUADRUPED EQU $9

; overworld sprites
const_value = 1
	const SPRITE_RED                       ;EQU $01
	const SPRITE_BLUE                      ;EQU $02
	const SPRITE_OAK                       ;EQU $03
	const SPRITE_BUG_CATCHER               ;EQU $04
	const SPRITE_SLOWBRO                   ;EQU $05
	const SPRITE_LASS                      ;EQU $06
	const SPRITE_BLACK_HAIR_BOY_1          ;EQU $07
	const SPRITE_LITTLE_GIRL               ;EQU $08
	const SPRITE_BIRD                      ;EQU $09
	const SPRITE_FAT_BALD_GUY              ;EQU $0a
	const SPRITE_GAMBLER                   ;EQU $0b
	const SPRITE_BLACK_HAIR_BOY_2          ;EQU $0c
	const SPRITE_GIRL                      ;EQU $0d
	const SPRITE_HIKER                     ;EQU $0e
	const SPRITE_FOULARD_WOMAN             ;EQU $0f
	const SPRITE_GENTLEMAN                 ;EQU $10
	const SPRITE_DAISY                     ;EQU $11
	const SPRITE_BIKER                     ;EQU $12
	const SPRITE_SAILOR                    ;EQU $13
	const SPRITE_COOK                      ;EQU $14
	const SPRITE_BIKE_SHOP_GUY             ;EQU $15
	const SPRITE_MR_FUJI                   ;EQU $16
	const SPRITE_GIOVANNI                  ;EQU $17
	const SPRITE_ROCKET                    ;EQU $18
	const SPRITE_MEDIUM                    ;EQU $19
	const SPRITE_WAITER                    ;EQU $1a
	const SPRITE_ERIKA                     ;EQU $1b
	const SPRITE_MOM_GEISHA                ;EQU $1c
	const SPRITE_BRUNETTE_GIRL             ;EQU $1d
	const SPRITE_LANCE                     ;EQU $1e
	const SPRITE_OAK_SCIENTIST_AIDE        ;EQU $1f
	const SPRITE_OAK_AIDE                  ;EQU $20
	const SPRITE_ROCKER                    ;EQU $21
	const SPRITE_SWIMMER                   ;EQU $22
	const SPRITE_WHITE_PLAYER              ;EQU $23
	const SPRITE_GYM_HELPER                ;EQU $24
	const SPRITE_OLD_PERSON                ;EQU $25
	const SPRITE_MART_GUY                  ;EQU $26
	const SPRITE_FISHER                    ;EQU $27
	const SPRITE_OLD_MEDIUM_WOMAN          ;EQU $28
	const SPRITE_NURSE                     ;EQU $29
	const SPRITE_CABLE_CLUB_WOMAN          ;EQU $2a
	const SPRITE_MR_MASTERBALL             ;EQU $2b
	const SPRITE_LAPRAS_GIVER              ;EQU $2c
	const SPRITE_WARDEN                    ;EQU $2d
	const SPRITE_SS_CAPTAIN                ;EQU $2e
	const SPRITE_FISHER2                   ;EQU $2f
	const SPRITE_BLACKBELT                 ;EQU $30
	const SPRITE_GUARD                     ;EQU $31
	const SPRITE_ROCKET_F                  ;EQU $32
	const SPRITE_MOM                       ;EQU $33
	const SPRITE_BALDING_GUY               ;EQU $34
	const SPRITE_YOUNG_BOY                 ;EQU $35
	const SPRITE_GAMEBOY_KID               ;EQU $36
	const SPRITE_GAMEBOY_KID_COPY          ;EQU $37
	const SPRITE_CLEFAIRY                  ;EQU $38
	const SPRITE_AGATHA                    ;EQU $39
	const SPRITE_BRUNO                     ;EQU $3a
	const SPRITE_LORELEI                   ;EQU $3b
	const SPRITE_SEEL                      ;EQU $3c
; New walking sprites added here
	const SPRITE_BROCK                     ;EQU $4A
	const SPRITE_MISTY                     ;EQU $4B
	const SPRITE_SURGE                     ;EQU $4C
	const SPRITE_SABRINA                   ;EQU $4D
	const SPRITE_KOGA                      ;EQU $4E
	const SPRITE_BLAINE                    ;EQU $4F
	const SPRITE_BRENDAN                   ;EQU $50
	const SPRITE_FLANNERY                  ;EQU $51
	const SPRITE_GREETER
	const SPRITE_LAPRAS
	const SPRITE_SURF_PIKACHU
	const SPRITE_LOOKER
; Sprites after this are only 1 frame
	const SPRITE_BALL                      ;EQU $3d
	const SPRITE_OMANYTE                   ;EQU $3e
	const SPRITE_BOULDER                   ;EQU $3f
	const SPRITE_PAPER_SHEET               ;EQU $40
	const SPRITE_BOOK_MAP_DEX              ;EQU $41
	const SPRITE_CLIPBOARD                 ;EQU $42
	const SPRITE_SNORLAX                   ;EQU $43
	const SPRITE_BAG                       ;EQU $44
	const SPRITE_OLD_AMBER                 ;EQU $45
	const SPRITE_POKEDEX                   ;EQU $46
	const SPRITE_BERRY_TREE                ;EQU $47
	const SPRITE_LYING_OLD_MAN             ;EQU $48
	const SPRITE_SUDOWOODO                 ;EQU $49
	const SPRITE_POKEY
    const SPRITE_DITTO
	
; Variable Sprite IDs Here
VAR_SPRITE_1 EQU $F1
VAR_SPRITE_2 EQU $F2
VAR_SPRITE_3 EQU $F3
VAR_SPRITE_4 EQU $F4
VAR_SPRITE_5 EQU $F5
VAR_SPRITE_6 EQU $F6

; different kinds of people events
ITEM    EQU $80
TRAINER EQU $40

OW_POKEMON EQU $80

BOULDER_MOVEMENT_BYTE_2 EQU $10

; sprite facing directions
SPRITE_FACING_DOWN  EQU $00
SPRITE_FACING_UP    EQU $04
SPRITE_FACING_LEFT  EQU $08
SPRITE_FACING_RIGHT EQU $0C