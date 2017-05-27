db DEX_EXEGGUTOR ; pokedex id
db 95 ; base hp
db 95 ; base attack
db 85 ; base defense
db 55 ; base speed
db 125 ; base special
db GRASS ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 212 ; base exp yield
INCBIN "pic/bmon/exeggutor.pic",0,1 ; 77, sprite dimensions
dw ExeggutorPicFront
dw ExeggutorPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 3,5,6
	tmlearn 9,10,15
	tmlearn 21,22
	tmlearn 29,31,32
	tmlearn 33,34,40
	tmlearn 42,44,46,47
	tmlearn 50,54
db BANK(ExeggutorPicFront)
