db DEX_GOLEM ; pokedex id
db 80 ; base hp
db 120 ; base attack
db 130 ; base defense
db 45 ; base speed
db 55 ; base special
db ROCK ; species type 1
db GROUND ; species type 2
db 45 ; catch rate
db 177 ; base exp yield
INCBIN "pic/bmon/golem.pic",0,1 ; 66, sprite dimensions
dw GolemPicFront
dw GolemPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 9,10
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 1,6,8
	tmlearn 9,10,15
	tmlearn 17,18,19
	tmlearn 26,27,28,31,32
	tmlearn 34,35,36,37,38
	tmlearn 44,47,48
	tmlearn 54
db BANK(GolemPicFront)
