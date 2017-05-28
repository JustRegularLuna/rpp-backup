SteelixBaseStats:
db DEX_STEELIX ; pokedex id
db 75 ; base hp
db 85 ; base attack
db 200 ; base defense
db 30 ; base speed
db 65 ; base special
db STEEL ; species type 1
db GROUND ; species type 2
db 25 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/steelix.pic",0,1 ; 77, sprite dimensions
dw SteelixPicFront
dw SteelixPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 3,6,7,8
	tmlearn 9,10,15,16
	tmlearn 18,23
	tmlearn 26,27,28,31,32
	tmlearn 34,35,36,40
	tmlearn 44,47,48
	tmlearn 54
db BANK(SteelixPicFront)
