SylveonBaseStats: ; 3926a (e:526a)
db DEX_SYLVEON ; pokedex id
db 95 ; base hp
db 65 ; base attack
db 65 ; base defense
db 60 ; base speed
db 130 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/sylveon.pic",0,1 ; 66, sprite dimensions
dw SylveonPicFront
dw SylveonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 5,6,8
	tmlearn 9,10,15,16
	tmlearn 0
	tmlearn 28,29,30,31,32
	tmlearn 33,34,39,40
	tmlearn 42,44,46
	tmlearn 49,50,54
db BANK(SylveonPicFront)
