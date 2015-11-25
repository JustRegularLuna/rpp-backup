AerodactylBaseStats: ; 3934a (e:534a)
db DEX_AERODACTYL ; pokedex id
db 80 ; base hp
db 105 ; base attack
db 65 ; base defense
db 130 ; base speed
db 60 ; base special
db ROCK ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 202 ; base exp yield
INCBIN "pic/bmon/aerodactyl.pic",0,1 ; 77, sprite dimensions
dw AerodactylPicFront
dw AerodactylPicBack
; attacks known at lvl 0
db WING_ATTACK
db AGILITY
db 0
db 0
db 5 ; growth rate
; learnset
	tmlearn 2,3,4,6
	tmlearn 9,10,15,16
	tmlearn 19,23
	tmlearn 26,27,32
	tmlearn 34,35,36,37,38,39,40
	tmlearn 41,44,48
	tmlearn 52,54
db BANK(AerodactylPicFront)
