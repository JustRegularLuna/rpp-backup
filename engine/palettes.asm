; HAX: This is the super gameboy palette command handler.
; I hijaxed a jump table so I can reimplement all SGB colorization functions.
; Value of b is the "command". Jumps to function "PalCmd_XX" where X is the command.
Func_71ddf: ; 71ddf (1c:5ddf)
	call GetPredefRegisters
	ld a, b
	cp $ff
	jr nz, .asm_71dea
	ld a, [wcf1c]
.asm_71dea
	cp $fc
	jp z, Func_71fc2
	ld l, a
	ld h, $0
	add hl, hl
	ld de, PointerTable_71f73
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	;ld de, SetPalettesAndMaps ; $6156

	ld de,PalCmdRet
	push de

	;di
 	jp [hl]

PalCmdRet:
	;ei
	ret


; HAX: Custom functions squeezed in here
; Before, PalCmd functions were here

WaitForVBlank:
	ld a,[rSTAT]
	and a,3
	dec a
	jr nz,WaitForVBlank
 	ret

; Palette commands are moved to the end of the bank
PointerTable_71f73: ; 71f73 (1c:5f73)
	dw SendPalPacket_Black
	dw BuildBattlePalPacket
	dw SendPalPacket_TownMap
	dw BuildStatusScreenPalPacket
	dw SendPalPacket_Pokedex
	dw SendPalPacket_Slots
	dw SendPalPacket_Titlescreen
	dw SendPalPacket_NidorinoIntro
	dw SendPalPacket_Generic
	dw BuildOverworldPalPacket
	dw SendPalPacket_PartyMenu
	dw SendPokemonPalette_WholeScreen
	dw SendPalPacket_GameFreakIntro
	dw BuildTrainerCardPalPacket
	; Past here are codes which didn't previously exist.
	dw PalCmd_0e	; Set prof oak's color
	dw PalCmd_0f	; Name entry (partially replaces 08)

; HAXed to give trainers palettes independantly
DeterminePaletteID: ; 71f97 (1c:5f97)
	bit 3, a                 ; bit 3 of battle status 3, set if current Pokemon is transformed
	ld a, PAL_GREYMON        ; if yes, use Ditto's palette
	ret nz
	ld a, [hl]
DeterminePaletteIDOutOfBattle: ; 71f9d (1c:5f9d) - DeterminePaletteID without status check
	ld [wd11e], a
	and a

	push bc
	predef IndexToPokedex ; turn Pokemon ID number into Pokedex number
	pop bc

	ld a, [wd11e]
	ld hl, MonsterPalettes
	and a

IF GEN_2_GRAPHICS ; Trainers are given individualized palettes
	jr nz,.getPaletteID ; Check if trainer?
	ld a,[W_TRAINERCLASS] ; Get trainer ID
	ld hl, TrainerPalettes
ELSE ; Trainers are given a single palette (PAL_MEWMON)
	REPT 8
	nop
	ENDR
ENDC

.getPaletteID
	ld e, a
	ld d, $00
	add hl, de
	ld a, [hl]
	ret
	

DetermineBackSpritePaletteID: ; DeterminePaletteID with a special check for the player sprite
	bit 3, a                 ; bit 3 of battle status 3 (unused?)
	ld a, PAL_GREYMON
	ret nz
	ld a, [hl]
DetermineBackSpritePaletteID_NoStatusCheck:
	ld [wd11e], a
	and a

	push bc
	predef IndexToPokedex ; turn Pokemon ID number into Pokedex number
	pop bc

	ld a, [wd11e]
	ld hl, MonsterPalettes
	and a
	jr nz,.getPaletteID ; Check if trainer?

IF GEN_2_GRAPHICS
	ld a, PAL_HERO
ELSE
	ld a, PAL_REDMON
ENDC
	ret
.getPaletteID
	ld e, a
	ld d, $00
	add hl, de
	ld a, [hl]
	ret


	ORG $1c, $5f8f
; each byte is the number of loops to make in .asm_71f5b for each badge
LoopCounts_71f8f: ; 71f8f (1c:5f8f)
	db $06,$06,$06,$12,$06,$06,$06,$06

	ORG $1c, $5fb6

SendBlkPacket_PartyMenu: ; 71fb6 (1c:5fb6)
	ld hl, BlkPacket_PartyMenu
	ld de, wcf2e
	ld bc, $30
	jp CopyData

Func_71fc2: ; 71fc2 (1c:5fc2)
	ld hl, wcf1f
	ld a, [wcf2d]
	ld e, a
	ld d, $0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, $5
	jr z, .asm_71fdb
	dec a
	ld e, $a
	jr z, .asm_71fdb
	ld e, $f
.asm_71fdb
	push de
	ld hl, wcf37
	ld bc, $6
	ld a, [wcf2d]
	call AddNTimes
	pop de
	ld [hl], e
	ret

SendSGBPacket: ; 71feb (1c:5feb)
;check number of packets
	ld a,[hl]
	and a,$07
	ret z
; store number of packets in B
	ld b,a
.loop2
; save B for later use
	push bc
; load a non-zero value in $fff9 to disable the routine that checks actual
; joypad input (said routine, located at $15f, does nothing if $fff9 is not
; zero)
	ld a,$01
	ld [$fff9],a
; send RESET signal (P14=LOW, P15=LOW)
	xor a
	ld [rJOYP],a
; set P14=HIGH, P15=HIGH
	ld a,$30
	ld [rJOYP],a
;load length of packets (16 bytes)
	ld b,$10
.nextByte
;set bit counter (8 bits per byte)
	ld e,$08
; get next byte in the packet
	ld a,[hli]
	ld d,a
.nextBit0
	bit 0,d
; if 0th bit is not zero set P14=HIGH,P15=LOW (send bit 1)
	ld a,$10
	jr nz,.next0
; else (if 0th bit is zero) set P14=LOW,P15=HIGH (send bit 0)
	ld a,$20
.next0
	ld [rJOYP],a
; must set P14=HIGH,P15=HIGH between each "pulse"
	ld a,$30
	ld [rJOYP],a
; rotation will put next bit in 0th position (so  we can always use command
; "bit 0,d" to fetch the bit that has to be sent)
	rr d
; decrease bit counter so we know when we have sent all 8 bits of current byte
	dec e
	jr nz,.nextBit0
	dec b
	jr nz,.nextByte
; send bit 1 as a "stop bit" (end of parameter data)
	ld a,$20
	ld [rJOYP],a
; set P14=HIGH,P15=HIGH
	ld a,$30
	ld [rJOYP],a
	xor a
	ld [$fff9],a
; wait for about 70000 cycles
	call Wait7000
; restore (previously pushed) number of packets
	pop bc
	dec b
; return if there are no more packets
	ret z
; else send 16 more bytes
	jr .loop2

; This function is HAXed to always set the SGB Flag.
; This helps with palette flashing effects in battle.
; It also lets me hijack GoPAL_SET.
LoadSGB: ; 7202b (1c:602b)
	xor a
	ld [wOnSGB], a
	call CheckSGB
	;ret nc
	nop
	ld a, $1
	ld [wOnSGB], a
	ld a, [wGBC]
	and a
	;jr z, .asm_7203f
	nop
	nop
	ret
	; Deleted the end of this function which loads the SGB border and stuff

	ORG $1c, $6075

Func_72075: ; 72075 (1c:6075)
	ld hl, PointerTable_72089
	ld c, $9
.asm_7207a
	push bc
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call SendSGBPacket
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .asm_7207a
	ret

PointerTable_72089: ; 72089 (1c:6089)
	dw MaskEnFreezePacket
	dw DataSnd_72548
	dw DataSnd_72558
	dw DataSnd_72568
	dw DataSnd_72578
	dw DataSnd_72588
	dw DataSnd_72598
	dw DataSnd_725a8
	dw DataSnd_725b8

CheckSGB: ; 7209b (1c:609b)
	ld hl, MltReq2Packet
	di
	call SendSGBPacket
	ld a, $1
	ld [$fff9], a
	ei
	call Wait7000
	ld a, [rJOYP]
	and $3
	cp $3
	jr nz, .asm_720fd
	ld a, $20
	ld [rJOYP], a
	ld a, [rJOYP]
	ld a, [rJOYP]
	call Wait7000
	call Wait7000
	ld a, $30
	ld [rJOYP], a
	call Wait7000
	call Wait7000
	ld a, $10
	ld [rJOYP], a
	ld a, [rJOYP]
	ld a, [rJOYP]
	ld a, [rJOYP]
	ld a, [rJOYP]
	ld a, [rJOYP]
	ld a, [rJOYP]
	call Wait7000
	call Wait7000
	ld a, $30
	ld [rJOYP], a
	ld a, [rJOYP]
	ld a, [rJOYP]
	ld a, [rJOYP]
	call Wait7000
	call Wait7000
	ld a, [rJOYP]
	and $3
	cp $3
	jr nz, .asm_720fd
	call Func_72102
	and a
	ret
.asm_720fd
	call Func_72102
	scf
	ret

Func_72102: ; 72102 (1c:6102)
	ld hl, MltReq1Packet
	call SendSGBPacket
	jp Wait7000

Func_7210b: ; 7210b (1c:610b)
	di
	push de
	call DisableLCD
	ld a, $e4
	ld [rBGP], a
	ld de, vChars1
	ld a, [wcf2d]
	and a
	jr z, .asm_72122
	call Func_72188
	jr .asm_72128
.asm_72122
	ld bc, $1000
	call CopyData
.asm_72128
	ld hl, vBGMap0
	ld de, $c
	ld a, $80
	ld c, $d
.asm_72132
	ld b, $14
.asm_72134
	ld [hli], a
	inc a
	dec b
	jr nz, .asm_72134
	add hl, de
	dec c
	jr nz, .asm_72132
	ld a, $e3
	ld [rLCDC], a
	pop hl
	call SendSGBPacket
	xor a
	ld [rBGP], a
	ei
	ret

Wait7000: ; 7214a (1c:614a)
; Each loop takes 9 cycles so this routine actually waits 63000 cycles.
	ld de, 7000
.loop
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .loop
	ret

; de = ptr to ATTR_BLK packet
; hl = ptr to PAL_SET packet
SetPalettesAndMaps: ; 72156 (1c:6156)
	ld a, [wGBC]
	and a
	jr z, .asm_72165
	push de
	call Func_7216d
	pop hl
	call Func_72187
	ret
.asm_72165
	push de
	call SendSGBPacket
	pop hl
	jp SendSGBPacket

Func_7216d: ; 7216d (1c:616d)
	ld a, $80
	ld [$ff68], a
	inc hl
	ld c, $20
.asm_72174
	ld a, [hli]
	inc hl
	add a
	add a
	add a
	ld de, SuperPalettes
	add e
	jr nc, .asm_72180
	inc d
.asm_72180
	ld a, [de]
	ld [$ff69], a
	dec c
	jr nz, .asm_72174
	ret

Func_72187: ; 72187 (1c:6187)
	ret

Func_72188: ; 72188 (1c:6188)
	ld b, $80
.asm_7218a
	ld c, $10
.asm_7218c
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_7218c
	ld c, $10
	xor a
.asm_72195
	ld [de], a
	inc de
	dec c
	jr nz, .asm_72195
	dec b
	jr nz, .asm_7218a
	ret

INCLUDE "data/sgb_packets.asm"

INCLUDE "data/mon_palettes.asm"

INCLUDE "data/sgb_border.asm"
