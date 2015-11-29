SkarmoryBaseStats: ; 38aa6 (e:4aa6)
db DEX_SKARMORY ; pokedex id
db 65 ; base hp
db 80 ; base attack
db 140 ; base defense
db 70 ; base speed
db 70 ; base special
db STEEL ; species type 1
db FLYING ; species type 2
db 25 ; catch rate
db 168 ; base exp yield
INCBIN "pic/bmon/skarmory.pic",0,1 ; 55, sprite dimensions
dw SkarmoryPicFront
dw SkarmoryPicBack
; attacks known at lvl 0
db PECK
db LEER
db 0
db 0
db 3 ; growth rate
; learnset
	tmlearn 3,4,6
	tmlearn 9,10,15,16
	tmlearn 17,18,19,23
	tmlearn 26,27,31,32
	tmlearn 33,34,36,39,40
	tmlearn 41,43,44,48
	tmlearn 50,51,52,54
db BANK(SkarmoryPicFront)
