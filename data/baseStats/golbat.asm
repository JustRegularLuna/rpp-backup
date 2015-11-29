GolbatBaseStats: ; 3885a (e:485a)
db DEX_GOLBAT ; pokedex id
db 75 ; base hp
db 80 ; base attack
db 70 ; base defense
db 90 ; base speed
db 75 ; base special
db POISON ; species type 1
db FLYING ; species type 2
db 90 ; catch rate
db 171 ; base exp yield
INCBIN "pic/bmon/golbat.pic",0,1 ; 77, sprite dimensions
dw GolbatPicFront
dw GolbatPicBack
; attacks known at lvl 0
db LEECH_LIFE
db SCREECH
db BITE
db 0
db 0 ; growth rate
; learnset
	tmlearn 3,4,6,8
	tmlearn 9,10,15
	tmlearn 21
	tmlearn 30,31,32
	tmlearn 33,34,39
	tmlearn 41,42,43,44
	tmlearn 52
db BANK(GolbatPicFront)
