Lab2Script: ; 75c21 (1d:5c21)
	jp EnableAutoTextBoxDrawing

Lab2TextPointers: ; 75c24 (1d:5c24)
	dw Lab2Text1
	dw Lab2Text2
	dw Lab2Text3

Lab2Text1: ; 75c2a (1d:5c2a)
	db $08 ;asm
	
	; check if you have already received the ticket
	ld a, [wExtraFlags]
	bit 4, a
	jr nz, .alreadyGiven
	
	; if not already given, talk about legendary birds
	ld hl, TalkAboutBirds
	call PrintText
	
	; check if you have seen all 3 legendary birds
	; exit the script if one is missing
	ld a, ARTICUNO
	call CheckBirdSeen
	jr z, .done
	ld a, ZAPDOS
	call CheckBirdSeen
	jr z, .done
	ld a, MOLTRES
	call CheckBirdSeen
	jr z, .done
	
	; if all are seen, talk about that and try to give ticket
	ld hl, SeenAllBirdsText
	call PrintText
	ld b, MYSTIC_TICKET
	ld c, 1
	call GiveItem
	jr nc, .bagFull
	
	; if the item was given successfully, say so...
	ld hl, ReceivedMysticTicketText
	call PrintText
	
	; ...mark the item as given...
	ld hl, wExtraFlags
	set 4, [hl]
	
	; ...and talk about the item
.alreadyGiven
	ld hl, TalkAboutNavelRockText
	call PrintText
	jp TextScriptEnd
	
	; if you haven't seen all of them
.done
	ld hl, MysticTooBadText
	call PrintText
	jp TextScriptEnd
	
	; if there is no room in the pack, say so
.bagFull
	ld hl, NoRoomForMysticText
	call PrintText
	jp TextScriptEnd


; Checks to see if the Pokémon has been seen
; [input]: a = Pokémon ID
; [output]: z if not seen, nz if seen
CheckBirdSeen:
	dec a
	ld c,a
	ld b, CHECK_FLAG
	ld hl, wPokedexSeen
	predef FlagActionPredef
	ld a,c
	and a
	ret

TalkAboutBirds:
	TX_FAR _TalkAboutBirds
	db "@"
	
MysticTooBadText:
	TX_FAR _MysticTooBadText
	db "@"
	
SeenAllBirdsText:
	TX_FAR _SeenAllBirdsText
	db "@"
	
ReceivedMysticTicketText:
	TX_FAR _ReceivedMysticTicketText
	db $0B
	db "@"
	
TalkAboutNavelRockText:
	TX_FAR _TalkAboutNavelRockText
	db "@"
	
NoRoomForMysticText:
	TX_FAR _NoMoreRoomForMysticText
	db "@"

Lab2Text2: ; 75c2f (1d:5c2f)
	db $8
	ld hl, Trader7Name ; the old man
	call SetCustomName
	ld a, $7
	ld [wWhichTrade], a
	jr asm_78552 ; 0x75c35 $6

Lab2Text3: ; 75c37 (1d:5c37)
	db $8
	ld hl, Trader8Name ; the girl
	call SetCustomName
	ld a, $8
	ld [wWhichTrade], a
asm_78552: ; 75c3d (1d:5c3d)
	predef DoInGameTradeDialogue
	jp TextScriptEnd

Trader7Name:
	db "Dwayne@"
	
Trader8Name:
	db "Christy@"
