GastlyBaseStats: ; 38dd2 (e:4dd2)
db DEX_GASTLY ; pokedex id
db 30 ; base hp
db 35 ; base attack
db 30 ; base defense
db 80 ; base speed
db 100 ; base special
db GHOST ; species type 1
db POISON ; species type 2
db 190 ; catch rate
db 95 ; base exp yield
INCBIN "pic/bmon/gastly.pic",0,1 ; 77, sprite dimensions
dw GastlyPicFront
dw GastlyPicBack
; attacks known at lvl 0
db HYPNOSIS
db LICK
db 0
db 0
db 3 ; growth rate
; learnset
	tmlearn 6
	tmlearn 0
	tmlearn 21,24
	tmlearn 25,29,30,31,32
	tmlearn 0
	tmlearn 42,43,44,46,47
	tmlearn 49
db BANK(GastlyPicFront)
