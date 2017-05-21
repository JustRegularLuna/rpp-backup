; pokemon's overworld sprites
const_value = 0

	const SPRITE_MON       ; $0
	const SPRITE_BALL_M    ; $1
	const SPRITE_HELIX     ; $2
	const SPRITE_FAIRY     ; $3
	const SPRITE_BIRD_M    ; $4
	const SPRITE_WATER     ; $5
	const SPRITE_BUG       ; $6
	const SPRITE_GRASS     ; $7
	const SPRITE_SNAKE     ; $8
	const SPRITE_QUADRUPED ; $9

; overworld sprites
const_value = 1
	const SPRITE_RED                       ; $01
	const SPRITE_BLUE                      ; $02
	const SPRITE_OAK                       ; $03
	const SPRITE_BUG_CATCHER               ; $04
	const SPRITE_SLOWBRO                   ; $05
	const SPRITE_LASS                      ; $06
	const SPRITE_BLACK_HAIR_BOY_1          ; $07
	const SPRITE_LITTLE_GIRL               ; $08
	const SPRITE_BIRD                      ; $09
	const SPRITE_FAT_BALD_GUY              ; $0a
	const SPRITE_GAMBLER                   ; $0b
	const SPRITE_BLACK_HAIR_BOY_2          ; $0c
	const SPRITE_GIRL                      ; $0d
	const SPRITE_HIKER                     ; $0e
	const SPRITE_FOULARD_WOMAN             ; $0f
	const SPRITE_GENTLEMAN                 ; $10
	const SPRITE_DAISY                     ; $11
	const SPRITE_BIKER                     ; $12
	const SPRITE_SAILOR                    ; $13
	const SPRITE_COOK                      ; $14
	const SPRITE_BIKE_SHOP_GUY             ; $15
	const SPRITE_MR_FUJI                   ; $16
	const SPRITE_GIOVANNI                  ; $17
	const SPRITE_ROCKET                    ; $18
	const SPRITE_MEDIUM                    ; $19
	const SPRITE_WAITER                    ; $1a
	const SPRITE_ERIKA                     ; $1b
	const SPRITE_MOM_GEISHA                ; $1c
	const SPRITE_BRUNETTE_GIRL             ; $1d
	const SPRITE_LANCE                     ; $1e
	const SPRITE_OAK_SCIENTIST_AIDE        ; $1f
	const SPRITE_OAK_AIDE                  ; $20
	const SPRITE_ROCKER                    ; $21
	const SPRITE_SWIMMER                   ; $22
	const SPRITE_WHITE_PLAYER              ; $23
	const SPRITE_GYM_HELPER                ; $24
	const SPRITE_OLD_PERSON                ; $25
	const SPRITE_MART_GUY                  ; $26
	const SPRITE_FISHER                    ; $27
	const SPRITE_OLD_MEDIUM_WOMAN          ; $28
	const SPRITE_NURSE                     ; $29
	const SPRITE_CABLE_CLUB_WOMAN          ; $2a
	const SPRITE_MR_MASTERBALL             ; $2b
	const SPRITE_LAPRAS_GIVER              ; $2c
	const SPRITE_WARDEN                    ; $2d
	const SPRITE_SS_CAPTAIN                ; $2e
	const SPRITE_FISHER2                   ; $2f
	const SPRITE_BLACKBELT                 ; $30
	const SPRITE_GUARD                     ; $31
	const SPRITE_ROCKET_F                  ; $32
	const SPRITE_MOM                       ; $33
	const SPRITE_BALDING_GUY               ; $34
	const SPRITE_YOUNG_BOY                 ; $35
	const SPRITE_GAMEBOY_KID               ; $36
	const SPRITE_GAMEBOY_KID_COPY          ; $37
	const SPRITE_CLEFAIRY                  ; $38
	const SPRITE_AGATHA                    ; $39
	const SPRITE_BRUNO                     ; $3a
	const SPRITE_LORELEI                   ; $3b
	const SPRITE_SEEL                      ; $3c
; New walking sprites added here
	const SPRITE_BROCK                     ; $3d
	const SPRITE_MISTY                     ; $3e
	const SPRITE_SURGE                     ; $3f
	const SPRITE_SABRINA                   ; $40
	const SPRITE_KOGA                      ; $41
	const SPRITE_BLAINE                    ; $42
	const SPRITE_BRENDAN                   ; $43
	const SPRITE_FLANNERY                  ; $44
	const SPRITE_GREETER                   ; $45
	const SPRITE_LAPRAS                    ; $46
	const SPRITE_SURF_PIKACHU              ; $47
	const SPRITE_LOOKER                    ; $48
	const SPRITE_SWIMMER_F                 ; $49
	const SPRITE_OFFICER_JENNY             ; $4a
	const SPRITE_JESSIE                    ; $4b
	const SPRITE_JAMES                     ; $4c
	const SPRITE_HIRO                      ; $4d
	const SPRITE_KRIS                      ; $4e
	const SPRITE_SILVER                    ; $4f
; Sprites after this are only 1 frame
	const SPRITE_BALL                      ; $50
	const SPRITE_OMANYTE                   ; $51
	const SPRITE_BOULDER                   ; $52
	const SPRITE_PAPER_SHEET               ; $53
	const SPRITE_BOOK                      ; $54
	const SPRITE_CLIPBOARD                 ; $55
	const SPRITE_SNORLAX                   ; $56
	const SPRITE_BAG                       ; $57
	const SPRITE_OLD_AMBER                 ; $58
	const SPRITE_POKEDEX                   ; $59
	const SPRITE_BERRY_TREE                ; $5a
	const SPRITE_LYING_OLD_MAN             ; $5b
	const SPRITE_SUDOWOODO                 ; $5c
	const SPRITE_POKEY                     ; $5d
	const SPRITE_DITTO                     ; $5e
	const SPRITE_CELEBI                    ; $5f
	const SPRITE_FOSSIL                    ; $60
	const SPRITE_TOWN_MAP                  ; $61
	
	
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
