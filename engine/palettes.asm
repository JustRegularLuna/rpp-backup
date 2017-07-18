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
	dw PalCmd_0e	; Set prof oak's color
	dw PalCmd_0f	; Name entry (partially replaces 08)

; HAXed to give trainers palettes independantly
; Also skips the "transform" check, caller does that instead
DeterminePaletteID:
	ld [wd11e], a
	and a

	push bc
	predef IndexToPokedex ; turn Pokemon ID number into Pokedex number
	pop bc

	ld a, [wd11e]
	ld hl, MonsterPalettes
	and a
	jr nz,.skipDexNumConversion ; Check if trainer?

IF GEN_2_GRAPHICS ; Trainers are given individualized palettes
	; In link battle, don't rely in wTrainerClass (for some reason it's set to
	; OPP_GARY, so ignore it)
	ld a,[wLinkState]
	cp LINK_STATE_BATTLING
	ld a, PAL_HERO
	ret z

	ld a,[wTrainerClass] ; Get trainer ID
	ld hl, TrainerPalettes
ELSE
	; Trainers are given a single palette (PAL_MEWMON)
	; However, check specifically for the player's sprite in linked battle
	ld e,a
	ld a,[wLinkState]
	cp LINK_STATE_BATTLING
	ld a, PAL_REDMON
	ret z

	ld a,e
ENDC

.skipDexNumConversion
	ld e, a
	ld d, $00
	add hl, de
	ld a, [hl]
	ret
	

DetermineBackSpritePaletteID:
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

	ORG $1c, $6075

PrepareSuperNintendoVRAMTransfer:
	ld hl, .packetPointers
	ld c, 9
.loop
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
	jr nz, .loop
	ret

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

CopyGfxToSuperNintendoVRAM:
	di
	push de
	call DisableLCD
	ld a, $e4
	ld [rBGP], a
	ld de, vChars1
	ld a, [wCopyingSGBTileData]
	and a
	jr z, .notCopyingTileData
	call CopySGBBorderTiles
	jr .next
.notCopyingTileData
	ld bc, $1000
	call CopyData
.next
	ld hl, vBGMap0
	ld de, $c
	ld a, $80
	ld c, $d
.loop
	ld b, $14
.innerLoop
	ld [hli], a
	inc a
	dec b
	jr nz, .innerLoop
	add hl, de
	dec c
	jr nz, .loop
	ld a, $e3
	ld [rLCDC], a
	pop hl
	call SendSGBPacket
	xor a
	ld [rBGP], a
	ei
	ret

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

; de = ptr to ATTR_BLK packet
; hl = ptr to PAL_SET packet
SetPalettesAndMaps:
	ld a, [wGBC]
	and a
	jr z, .notGBC
	push de
	call InitGBCPalettes
	pop hl
	call EmptyFunc5
	ret
.notGBC
	push de
	call SendSGBPacket
	pop hl
	jp SendSGBPacket

InitGBCPalettes:
	ld a, $80 ; index 0 with auto-increment
	ld [rBGPI], a
	inc hl
	ld c, $20
.loop
	ld a, [hli]
	inc hl
	add a
	add a
	add a
	ld de, SuperPalettes
	add e
	jr nc, .noCarry
	inc d
.noCarry
	ld a, [de]
	ld [rBGPD], a
	dec c
	jr nz, .loop
	ret

EmptyFunc5:
	ret

CopySGBBorderTiles:
; SGB tile data is stored in a 4BPP planar format.
; Each tile is 32 bytes. The first 16 bytes contain bit planes 1 and 2, while
; the second 16 bytes contain bit planes 3 and 4.
; This function converts 2BPP planar data into this format by mapping
; 2BPP colors 0-3 to 4BPP colors 0-3. 4BPP colors 4-15 are not used.
	ld b, 128

.tileLoop

; Copy bit planes 1 and 2 of the tile data.
	ld c, 16
.copyLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copyLoop

; Zero bit planes 3 and 4.
	ld c, 16
	xor a
.zeroLoop
	ld [de], a
	inc de
	dec c
	jr nz, .zeroLoop

	dec b
	jr nz, .tileLoop
	ret

INCLUDE "data/sgb_packets.asm"

INCLUDE "data/mon_palettes.asm"

INCLUDE "data/sgb_border.asm"
