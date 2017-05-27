db DEX_MAGNETON ; pokedex id
db 50 ; base hp
db 60 ; base attack
db 95 ; base defense
db 70 ; base speed
db 120 ; base special
db ELECTRIC ; species type 1
db STEEL ; species type 2
db 60 ; catch rate
db 161 ; base exp yield
INCBIN "pic/bmon/magneton.pic",0,1 ; 66, sprite dimensions
dw MagnetonPicFront
dw MagnetonPicBack
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
db BANK(MagnetonPicFront)
