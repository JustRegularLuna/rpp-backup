EvolveTradeMon:
; Set wWhichPokemon to the last PartyMon (aka the one you received)
; Temporarily set the link state, try to evolve the Pokemon, and set the link state back

	ld a, [wPartyCount]
	dec a
	ld [wWhichPokemon], a
	ld a, $1
	ld [wForceEvolution], a
	ld a, LINK_STATE_TRADING
	ld [wLinkState], a
	callab TryEvolvingMon
	xor a ; LINK_STATE_NONE
	ld [wLinkState], a
	jp PlayDefaultMusic
