HonchkrowBaseStats: ; 3860e (e:460e)
db DEX_HONCHKROW ; pokedex id
db 100 ; base hp
db 125 ; base attack
db 52 ; base defense
db 71 ; base speed
db 105 ; base special
db DARK ; species type 1
db FLYING ; species type 2
db 30 ; catch rate
db 177 ; base exp yield
INCBIN "pic/bmon/honchkrow.pic",0,1 ; sprite dimensions
dw HonchkrowPicFront
dw HonchkrowPicBack
; attacks known at lvl 0
db WING_ATTACK
db HAZE
db FEINT_ATTACK
db 0
db 0 ; growth rate
; learnset
	tmlearn 4,6
	tmlearn 9,10,15
	tmlearn 18
	tmlearn 29,30,31,32
	tmlearn 34,39
	tmlearn 41,42,43,44,45
	tmlearn 52
db BANK(HonchkrowPicFront)
