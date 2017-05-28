LeafeonBaseStats:
db DEX_LEAFEON ; pokedex id
db 65 ; base hp
db 110 ; base attack
db 130 ; base defense
db 95 ; base speed
db 65 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/leafeon.pic",0,1 ; 66, sprite dimensions
dw LeafeonPicFront
dw LeafeonPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 3,5,6,8
	tmlearn 9,10,15,16
	tmlearn 21,22
	tmlearn 28,30,31,32
	tmlearn 33,34,39,40
	tmlearn 41,44
	tmlearn 50,54
db BANK(LeafeonPicFront)
