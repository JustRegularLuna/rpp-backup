; This gets run when you try to play it on a DMG. Shows an error message, plays a jingle.
; There's a copy of the audio engine in bank $31 that's used for this, hasn't been
; disassembled for now...

RunDmgError:
	ld hl,Code_d000
	ld de,$d000
	ld b,Code_d000_end-Code_d000

.codeCopyLoop
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.codeCopyLoop

	xor a
	ld [wAudioFadeOutCounterReloadValue],a
	ld [wAudioFadeOutCounter],a

	; Use sound engine copy in bank $31
	ld a,$31
	ld [wAudioSavedROMBank],a
	ld [wAudioROMBank],a

	ld a,$c3
	ld [wAudioFadeOutControl],a

	di
	call DisableLCD

	; Load font
	ld de,FontCopy
	ld bc,$0200
	ld hl,$8800

.nextByte
	ld a,[de]
	ld [hli],a
	ld [hli],a
	inc de
	dec bc
	ld a,c
	or b
	jr nz,.nextByte

	; Load text

	ld de,DmgText
	ld bc,$0414
	ld hl,$98e0

.nextCharacter
	ld a,[de]
	inc de
	ldi [hl],a
	dec c
	jr nz,.nextCharacter

	push de
	ld de,$000c
	add hl,de
	pop de
	ld c,$14
	dec b
	jr nz,.nextCharacter

	call EnableLCD
	ei
	jp $d000


; Copied to RAM at $d000
Code_d000:
	push af
	push bc
	push de
	push hl
	call FadeOutAudio
	ld a,[wAudioROMBank]
	ld [H_LOADEDROMBANK],a
	ld [MBC1RomBank],a
	call $5177
	pop hl
	pop de
	pop bc
	pop af
	ld hl,rSTAT
.frameWait
	bit 2,[hl]
	jr z,.frameWait
	jr Code_d000
Code_d000_end:



FontCopy:
	INCBIN "gfx/font.1bpp"

DmgText:
	db "This game will only "
	db "     work on a      "
	db "   Gameboy Color    "
	db "  or GBA handheld   "
