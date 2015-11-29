MurkrowBaseStats: ; 3860e (e:460e)
db DEX_MURKROW ; pokedex id
db 60 ; base hp
db 85 ; base attack
db 42 ; base defense
db 91 ; base speed
db 85 ; base special
db DARK ; species type 1
db FLYING ; species type 2
db 30 ; catch rate
db 81 ; base exp yield
INCBIN "pic/bmon/murkrow.pic",0,1 ; 55, sprite dimensions
dw MurkrowPicFront
dw MurkrowPicBack
; attacks known at lvl 0
db PECK
db GROWL
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 4,6
	tmlearn 9,10
	tmlearn 18
	tmlearn 29,30,31,32
	tmlearn 34,39
	tmlearn 41,42,43,44,45
	tmlearn 52
db BANK(MurkrowPicFront)
