VaporeonBaseStats: ; 3926a (e:526a)
db DEX_VAPOREON ; pokedex id
db 130 ; base hp
db 65 ; base attack
db 60 ; base defense
db 65 ; base speed
db 110 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/vaporeon.pic",0,1 ; 66, sprite dimensions
dw VaporeonPicFront
dw VaporeonPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 5,6,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 0
	tmlearn 28,30,31,32
	tmlearn 33,34,39,40
	tmlearn 44
	tmlearn 53,54,55
db BANK(VaporeonPicFront)
