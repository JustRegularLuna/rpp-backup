MagnezoneBaseStats: ; 38cba (e:4cba)
db DEX_MAGNEZONE ; pokedex id
db 70 ; base hp
db 70 ; base attack
db 115 ; base defense
db 60 ; base speed
db 130 ; base special
db ELECTRIC ; species type 1
db STEEL ; species type 2
db 30 ; catch rate
db 211 ; base exp yield
INCBIN "pic/bmon/magnezone.pic",0,1 ; 66, sprite dimensions
dw MagnezonePicFront
dw MagnezonePicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6
	tmlearn 9,10,15
	tmlearn 24
	tmlearn 25,31,32
	tmlearn 33,34,39
	tmlearn 44,45
	tmlearn 50
db BANK(MagnezonePicFront)
