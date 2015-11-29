MagbyBaseStats: ; 3918a (e:518a)
db DEX_MAGBY ; pokedex id
db 45 ; base hp
db 75 ; base attack
db 37 ; base defense
db 83 ; base speed
db 70 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 45 ; catch rate
db 167 ; base exp yield
INCBIN "pic/bmon/magby.pic",0,1 ; 66, sprite dimensions
dw MagbyPicFront
dw MagbyPicBack
; attacks known at lvl 0
db SMOG
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10
	tmlearn 17,18,19
	tmlearn 29,30,31,32
	tmlearn 34,36,37,38,40
	tmlearn 44,46
	tmlearn 54
db BANK(MagbyPicFront)
