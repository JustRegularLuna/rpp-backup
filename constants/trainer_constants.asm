trainer_const: MACRO
\1     EQU const_value
OPP_\1 EQU const_value + 200
const_value = const_value + 1
ENDM

const_value = 1

	trainer_const YOUNGSTER     ; $01
	trainer_const BUG_CATCHER   ; $02
	trainer_const LASS          ; $03
	trainer_const SAILOR        ; $04
	trainer_const JR_TRAINER_M  ; $05
	trainer_const JR_TRAINER_F  ; $06
	trainer_const POKEMANIAC    ; $07
	trainer_const SUPER_NERD    ; $08
	trainer_const HIKER         ; $09
	trainer_const BIKER         ; $0A
	trainer_const BURGLAR       ; $0B
	trainer_const ENGINEER      ; $0C
	trainer_const COUPLE        ; $0D
	trainer_const FISHER        ; $0E
	trainer_const SWIMMER       ; $0F
	trainer_const CUE_BALL      ; $10
	trainer_const GAMBLER       ; $11
	trainer_const BEAUTY        ; $12
	trainer_const PSYCHIC_TR    ; $13
	trainer_const ROCKER        ; $14
	trainer_const JUGGLER       ; $15
	trainer_const TAMER         ; $16
	trainer_const BIRD_KEEPER   ; $17
	trainer_const BLACKBELT     ; $18
	trainer_const SONY1         ; $19
	trainer_const SWIMMER_F     ; $1A
	trainer_const ROCKET_F      ; $1B
	trainer_const SCIENTIST     ; $1C
	trainer_const GIOVANNI      ; $1D
	trainer_const ROCKET        ; $1E
	trainer_const COOLTRAINER_M ; $1F
	trainer_const COOLTRAINER_F ; $20
	trainer_const BRUNO         ; $21
	trainer_const BROCK         ; $22
	trainer_const MISTY         ; $23
	trainer_const LT_SURGE      ; $24
	trainer_const ERIKA         ; $25
	trainer_const KOGA          ; $26
	trainer_const BLAINE        ; $27
	trainer_const SABRINA       ; $28
	trainer_const GENTLEMAN     ; $29
	trainer_const SONY2         ; $2A
	trainer_const SONY3         ; $2B
	trainer_const LORELEI       ; $2C
	trainer_const CHANNELER     ; $2D
	trainer_const AGATHA        ; $2E
	trainer_const LANCE         ; $2F
	trainer_const HEX_MANIAC    ; $30
	trainer_const PKMN_TRAINER  ; $31

; Entries below this are only sprites, not actual classes
	trainer_const TRACEY        ; $32
	trainer_const EXECUTIVE_F   ; $33
	trainer_const EXECUTIVE_M   ; $34
	trainer_const ROCKER_F      ; $35
	trainer_const JESSIE_JAMES  ; $36
	trainer_const COSPLAY_GIRL  ; $37
	trainer_const JANINE        ; $38
	trainer_const PLAYER_M      ; $39
	trainer_const PLAYER_F      ; $3A
	trainer_const PROF_OAK      ; $3B
	trainer_const PI_TRAINER    ; $3C
	trainer_const FLANNERY      ; $3D
	trainer_const JESSIE        ; $3E
	trainer_const JAMES         ; $3F
	trainer_const GIOVANNI_2    ; $40
