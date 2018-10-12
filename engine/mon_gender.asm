; INPUTS - Mon DVs in de, species in wGenderTemp
; OUTPUT - Mon's gender in wGenderTemp
GetMonGender::
	ld hl, MonGenderRatios
	ld a, [wGenderTemp]
	dec a
	ld c, a
	ld b, 0
	add hl, bc ; hl now points to the species gender ratio
	
; Attack DV
	ld a, [de]
	and $f0
	ld b, a
; Speed DV
	inc de
	ld a, [de]
	and $f0
	swap a
; Put them together
	or b
	ld b, a ; b now has the combined DVs
	
; Get the gender ratio
	ld a, [hl]
	
; Check for always one or another
	cp NO_GENDER
	jr z, .genderless
	
	cp FEMALE_ONLY
	jr z, .female
	
	and a ; MALE_ONLY
	jr z, .male
	
; Compare the ratio to the value we found earlier
	cp b
	jr c, .male
	
.female
	ld a, FEMALE
	jr .done
.male
	ld a, MALE
	jr .done
.genderless
	ld a, GENDERLESS
.done
	ld [wGenderTemp], a
	ret
	
MonGenderRatios:
	db MALE_88_PERCENT   ; Bulbasaur
	db MALE_88_PERCENT   ; Ivysaur
	db MALE_88_PERCENT   ; Venusaur
	db MALE_88_PERCENT   ; Charmander
	db MALE_88_PERCENT   ; Charmeleon
	db MALE_88_PERCENT   ; Charizard
	db MALE_88_PERCENT   ; Squirtle
	db MALE_88_PERCENT   ; Wartortle
	db MALE_88_PERCENT   ; Blastoise
	db SAME_BOTH_GENDERS ; Caterpie
	db SAME_BOTH_GENDERS ; Metapod
	db SAME_BOTH_GENDERS ; Butterfree
	db SAME_BOTH_GENDERS ; Weedle
	db SAME_BOTH_GENDERS ; Kakuna
	db SAME_BOTH_GENDERS ; Beedrill
	db SAME_BOTH_GENDERS ; Pidgey
	db SAME_BOTH_GENDERS ; Pidgeotto
	db SAME_BOTH_GENDERS ; Pidgeot
	db SAME_BOTH_GENDERS ; Rattata
	db SAME_BOTH_GENDERS ; Raticate
	db SAME_BOTH_GENDERS ; Spearow
	db SAME_BOTH_GENDERS ; Fearow
	db SAME_BOTH_GENDERS ; Ekans
	db SAME_BOTH_GENDERS ; Arbok
	db SAME_BOTH_GENDERS ; Pikachu
	db SAME_BOTH_GENDERS ; Raichu
	db SAME_BOTH_GENDERS ; Sandshrew
	db SAME_BOTH_GENDERS ; Sandslash
	db FEMALE_ONLY       ; Nidoran F
	db FEMALE_ONLY       ; Nidorina
	db FEMALE_ONLY       ; Nidoqueen
	db MALE_ONLY         ; Nidoran M
	db MALE_ONLY         ; Nidorino
	db MALE_ONLY         ; Nidoking
	db FEMALE_75_PERCENT ; Clefairy
	db FEMALE_75_PERCENT ; Clefable
	db FEMALE_75_PERCENT ; Vulpix
	db FEMALE_75_PERCENT ; Ninetales
	db FEMALE_75_PERCENT ; Jigglypuff
	db FEMALE_75_PERCENT ; WIgglytuff
	db SAME_BOTH_GENDERS ; Zubat
	db SAME_BOTH_GENDERS ; Golbat
	db SAME_BOTH_GENDERS ; Oddish
	db SAME_BOTH_GENDERS ; Gloom
	db SAME_BOTH_GENDERS ; Vileplume
	db SAME_BOTH_GENDERS ; Paras
	db SAME_BOTH_GENDERS ; Parasect
	db SAME_BOTH_GENDERS ; Venonat
	db SAME_BOTH_GENDERS ; Venomoth
	db SAME_BOTH_GENDERS ; Diglett
	db SAME_BOTH_GENDERS ; Dugtrio
	db SAME_BOTH_GENDERS ; Meowth
	db SAME_BOTH_GENDERS ; Persian
	db SAME_BOTH_GENDERS ; Psyduck
	db SAME_BOTH_GENDERS ; Golduck
	db SAME_BOTH_GENDERS ; Mankey
	db SAME_BOTH_GENDERS ; Primeape
	db MALE_75_PERCENT   ; Growlithe
	db MALE_75_PERCENT   ; Arcanine
	db SAME_BOTH_GENDERS ; Poliwag
	db SAME_BOTH_GENDERS ; Poliwhirl
	db SAME_BOTH_GENDERS ; Poliwrath
	db MALE_75_PERCENT   ; Abra
	db MALE_75_PERCENT   ; Kadabra
	db MALE_75_PERCENT   ; Alakazam
	db MALE_75_PERCENT   ; Machop
	db MALE_75_PERCENT   ; Machoke
	db MALE_75_PERCENT   ; Machamp
	db SAME_BOTH_GENDERS ; Bellsprout
	db SAME_BOTH_GENDERS ; Weepinbell
	db SAME_BOTH_GENDERS ; Victreebel
	db SAME_BOTH_GENDERS ; Tentacool
	db SAME_BOTH_GENDERS ; Tentacruel
	db SAME_BOTH_GENDERS ; Geodude
	db SAME_BOTH_GENDERS ; Graveler
	db SAME_BOTH_GENDERS ; Golem
	db SAME_BOTH_GENDERS ; Ponyta
	db SAME_BOTH_GENDERS ; Rapidash
	db SAME_BOTH_GENDERS ; Slowpoke
	db SAME_BOTH_GENDERS ; Slowbro
	db NO_GENDER         ; Magnemite
	db NO_GENDER         ; Magneton
	db SAME_BOTH_GENDERS ; Farfetch'd
	db SAME_BOTH_GENDERS ; Doduo
	db SAME_BOTH_GENDERS ; Dodrio
	db SAME_BOTH_GENDERS ; Seel
	db SAME_BOTH_GENDERS ; Dewgong
	db SAME_BOTH_GENDERS ; Grimer
	db SAME_BOTH_GENDERS ; Muk
	db SAME_BOTH_GENDERS ; Shellder
	db SAME_BOTH_GENDERS ; Cloyster
	db SAME_BOTH_GENDERS ; Gastly
	db SAME_BOTH_GENDERS ; Haunter
	db SAME_BOTH_GENDERS ; Gengar
	db SAME_BOTH_GENDERS ; Onix
	db SAME_BOTH_GENDERS ; Drowzee
	db SAME_BOTH_GENDERS ; Hypno
	db SAME_BOTH_GENDERS ; Krabby
	db SAME_BOTH_GENDERS ; Kingler
	db NO_GENDER         ; Voltorb
	db NO_GENDER         ; Electrode
	db SAME_BOTH_GENDERS ; Exeggcute
	db SAME_BOTH_GENDERS ; Exeggutor
	db SAME_BOTH_GENDERS ; Cubone
	db SAME_BOTH_GENDERS ; Marowak
	db MALE_ONLY         ; Hitmonlee
	db MALE_ONLY         ; Hitmonchan
	db SAME_BOTH_GENDERS ; Lickitung
	db SAME_BOTH_GENDERS ; Koffing
	db SAME_BOTH_GENDERS ; Weezing
	db SAME_BOTH_GENDERS ; Rhyhorn
	db SAME_BOTH_GENDERS ; Rhydon
	db FEMALE_ONLY       ; Chansey
	db SAME_BOTH_GENDERS ; Tangela
	db FEMALE_ONLY       ; Kangaskhan
	db SAME_BOTH_GENDERS ; Horsea
	db SAME_BOTH_GENDERS ; Seadra
	db SAME_BOTH_GENDERS ; Goldeen
	db SAME_BOTH_GENDERS ; Seaking
	db NO_GENDER         ; Staryu
	db NO_GENDER         ; Starmie
	db SAME_BOTH_GENDERS ; Mr. Mime
	db SAME_BOTH_GENDERS ; Scyther
	db FEMALE_ONLY       ; Jynx
	db MALE_75_PERCENT   ; Electabuzz
	db MALE_75_PERCENT   ; Magmar
	db SAME_BOTH_GENDERS ; Pinsir
	db MALE_ONLY         ; Tauros
	db SAME_BOTH_GENDERS ; Magikarp
	db SAME_BOTH_GENDERS ; Gyarados
	db SAME_BOTH_GENDERS ; Lapras
	db NO_GENDER         ; Ditto
	db MALE_88_PERCENT   ; Eevee
	db MALE_88_PERCENT   ; Vaporeon
	db MALE_88_PERCENT   ; Jolteon
	db MALE_88_PERCENT   ; Flareon
	db NO_GENDER         ; Porygon
	db MALE_88_PERCENT   ; Omanyte
	db MALE_88_PERCENT   ; Omastar
	db MALE_88_PERCENT   ; Kabuto
	db MALE_88_PERCENT   ; Kabutops
	db MALE_88_PERCENT   ; Aerodactyl
	db MALE_88_PERCENT   ; Snorlax
	db NO_GENDER         ; Articuno
	db NO_GENDER         ; Zapdos
	db NO_GENDER         ; Moltres
	db SAME_BOTH_GENDERS ; Dratini
	db SAME_BOTH_GENDERS ; Dragonair
	db SAME_BOTH_GENDERS ; Dragonite
	db NO_GENDER         ; Mewtwo
	db NO_GENDER         ; Mew
	db NO_GENDER         ; Lugia
	db SAME_BOTH_GENDERS ; Houndour
	db SAME_BOTH_GENDERS ; Houndoom
	db SAME_BOTH_GENDERS ; Murkrow
	db SAME_BOTH_GENDERS ; Honchkrow
	db SAME_BOTH_GENDERS ; Heracross
	db MALE_88_PERCENT   ; Espeon
	db MALE_88_PERCENT   ; Umbreon
	db MALE_88_PERCENT   ; Glaceon
	db MALE_88_PERCENT   ; Leafeon
	db MALE_88_PERCENT   ; Sylveon
	db SAME_BOTH_GENDERS ; Scizor
	db SAME_BOTH_GENDERS ; Steelix
	db SAME_BOTH_GENDERS ; Crobat
	db SAME_BOTH_GENDERS ; Poitoed
	db SAME_BOTH_GENDERS ; Slowking
	db SAME_BOTH_GENDERS ; Bellossom
	db SAME_BOTH_GENDERS ; Kingdra
	db FEMALE_ONLY       ; Blissey
	db NO_GENDER         ; Porygon 2
	db NO_GENDER         ; Porygon Z
	db MALE_75_PERCENT   ; Magmortar
	db MALE_75_PERCENT   ; Electivire
	db NO_GENDER         ; Magnezone
	db SAME_BOTH_GENDERS ; Rhyperior
	db SAME_BOTH_GENDERS ; Tangrowth
	db SAME_BOTH_GENDERS ; Lickilicky
	db MALE_88_PERCENT   ; Togepi
	db MALE_88_PERCENT   ; Togetic
	db MALE_88_PERCENT   ; Togekiss
	db SAME_BOTH_GENDERS ; Sneasel
	db SAME_BOTH_GENDERS ; Weavile
	db SAME_BOTH_GENDERS ; Skarmory
	db SAME_BOTH_GENDERS ; Misdreavus
	db SAME_BOTH_GENDERS ; Mismagius
	db FEMALE_ONLY       ; Miltank
	db SAME_BOTH_GENDERS ; Chinchou
	db SAME_BOTH_GENDERS ; Lanturn
	db SAME_BOTH_GENDERS ; Slugma
	db SAME_BOTH_GENDERS ; Magcargo
	db SAME_BOTH_GENDERS ; Torkoal
	db NO_GENDER         ; Latios
	db NO_GENDER         ; Latias
	db MALE_ONLY         ; Hitmontop
	db MALE_ONLY         ; Tyrogue
	db SAME_BOTH_GENDERS ; Pichu
	db FEMALE_75_PERCENT ; Cleffa
	db FEMALE_75_PERCENT ; Igglybuff
	db FEMALE_ONLY       ; Smoochum
	db MALE_75_PERCENT   ; Elekid
	db MALE_75_PERCENT   ; Magby
	db SAME_BOTH_GENDERS ; Mime Jr
	db FEMALE_ONLY       ; Happiny
	db MALE_88_PERCENT   ; Munchlax
	db SAME_BOTH_GENDERS ; Zigzagoon
	db SAME_BOTH_GENDERS ; Linoone
	db NO_GENDER         ; Ho-oh
