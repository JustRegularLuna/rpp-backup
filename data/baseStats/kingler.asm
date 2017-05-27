db DEX_KINGLER ; pokedex id
db 55 ; base hp
db 130 ; base attack
db 115 ; base defense
db 75 ; base speed
db 50 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 60 ; catch rate
db 206 ; base exp yield
INCBIN "pic/bmon/kingler.pic",0,1 ; 77, sprite dimensions
dw KinglerPicFront
dw KinglerPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 3,6,8
	tmlearn 9,10,11,12,13,14,15
	tmlearn 20
	tmlearn 26,27,28,31,32
	tmlearn 34,36
	tmlearn 44
	tmlearn 51,53,54,55
db BANK(KinglerPicFront)
