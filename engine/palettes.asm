; HAX: This is the super gameboy palette command handler.
; I hijaxed a jump table so I can reimplement all SGB colorization functions.
; Value of b is the "command". Jumps to function "XX" of SetPalFunctions where X is the command.
_RunPaletteCommand:
	call GetPredefRegisters
	ld a, b
	cp $ff
	jr nz, .next
	ld a, [wDefaultPaletteCommand] ; use default command if command ID is $ff
.next
	cp UPDATE_PARTY_MENU_BLK_PACKET
	jp z, UpdatePartyMenuBlkPacket
	ld l, a
	ld h, 0
	add hl, hl
	ld de, SetPalFunctions
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de,SetPalRet
	push de
 	jp [hl]

SetPalRet:
	ret


; HAX: Custom functions squeezed in here
; Before, SetPal functions were here

WaitForVBlank:
	ld a,[rSTAT]
	and a,3
	dec a
	jr nz,WaitForVBlank
 	ret

; Palette commands are moved to the end of the bank (in color/color.asm)
SetPalFunctions:
	dw SetPal_BattleBlack
	dw SetPal_Battle
	dw SetPal_TownMap
	dw SetPal_StatusScreen
	dw SetPal_Pokedex
	dw SetPal_Slots
	dw SetPal_TitleScreen
	dw SetPal_NidorinoIntro
	dw SetPal_Generic
	dw SetPal_Overworld
	dw SetPal_PartyMenu
	dw SetPal_PokemonWholeScreen
	dw SetPal_GameFreakIntro
	dw SetPal_TrainerCard
	; Past here are codes which didn't previously exist.
	dw SetPal_OakIntro	   ; Set prof oak's color
	dw SetPal_NameEntry	   ; Name entry (partially replaces 08)
	dw SetPal_BattleAfterBlack ; Like SetPal_Battle but specifically for clearing the black palettes
	dw SetPal_WholeScreen
	dw SetPal_TrainerWholeScreen
	dw SetPal_VersionScreen
	dw SetPal_GenderSelect

; HAXed to give trainers palettes independantly
; Also skips the "transform" check, caller does that instead
DeterminePaletteID:
	ld [wd11e], a
	and a
	jr nz, GetMonPalette
	
	; Trainers are given individualized palettes
	; In link battle, don't rely in wTrainerClass (for some reason it's set to
	; OPP_GARY, so ignore it)
	ld a,[wLinkState]
	cp LINK_STATE_BATTLING
	ld a, PAL_PLAYER_M
	ret z
	
	ld a, [wTrainerPicID]
	ld hl, TrainerPalettes
	jr GetPaletteID

DeterminePaletteIDBack:
	ld [wd11e],a
	and a
	jr nz, GetMonPalette
	ld a, [wPlayerGender]
	and a
	jr z, .male
	ld a, PAL_PLAYER_F
	ret
.male
	ld a, PAL_PLAYER_M
	ret

GetMonPalette:
	push bc
	predef IndexToPokedex ; turn Pokemon ID number into Pokedex number
	pop bc

	ld a, [wd11e]
	ld hl, MonsterPalettes
	ld e, a
	ld d, $00
	add hl, de
	ld a, [hl]
	ret

GetPaletteID:
	ld e, a
	ld d, $00
	add hl, de
	ld a, [hl]
	ret


InitPartyMenuBlkPacket:
	ld hl, BlkPacket_PartyMenu
	ld de, wPartyMenuBlkPacket
	ld bc, $30
	jp CopyData

UpdatePartyMenuBlkPacket:
; Update the blk packet with the palette of the HP bar that is
; specified in [wWhichPartyMenuHPBar].
	ld hl, wPartyMenuHPBarColors
	ld a, [wWhichPartyMenuHPBar]
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, (1 << 2) | 1 ; green
	jr z, .next
	dec a
	ld e, (2 << 2) | 2 ; yellow
	jr z, .next
	ld e, (3 << 2) | 3 ; red
.next
	push de
	ld hl, wPartyMenuBlkPacket + 8 + 1
	ld bc, 6
	ld a, [wWhichPartyMenuHPBar]
	call AddNTimes
	pop de
	ld [hl], e
	ret

SendSGBPacket:
;check number of packets
	ld a,[hl]
	and a,$07
	ret z
; store number of packets in B
	ld b,a
.loop2
; save B for later use
	push bc
; disable ReadJoypad to prevent it from interfering with sending the packet
	ld a, 1
	ld [hDisableJoypadPolling], a
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
	ld [hDisableJoypadPolling],a
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
; It also lets me hijack RunPaletteCommand.
LoadSGB:
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

.packetPointers
; Only the first packet is needed.
	dw MaskEnFreezePacket
	dw DataSnd_72548
	dw DataSnd_72558
	dw DataSnd_72568
	dw DataSnd_72578
	dw DataSnd_72588
	dw DataSnd_72598
	dw DataSnd_725a8
	dw DataSnd_725b8

CheckSGB:
; Returns whether the game is running on an SGB in carry.
	ld hl, MltReq2Packet
	di
	call SendSGBPacket
	ld a, 1
	ld [hDisableJoypadPolling], a
	ei
	call Wait7000
	ld a, [rJOYP]
	and $3
	cp $3
	jr nz, .isSGB
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
	jr nz, .isSGB
	call SendMltReq1Packet
	and a
	ret
.isSGB
	call SendMltReq1Packet
	scf
	ret

SendMltReq1Packet:
	ld hl, MltReq1Packet
	call SendSGBPacket
	jp Wait7000

Wait7000:
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

INCLUDE "data/sgb_packets.asm"

INCLUDE "data/mon_palettes.asm"

; SGB border not needed in color hack
;INCLUDE "data/sgb_border.asm"
