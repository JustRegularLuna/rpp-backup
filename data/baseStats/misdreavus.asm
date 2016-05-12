MisdreavusBaseStats: ; 38aa6 (e:4aa6)
db DEX_MISDREAVUS ; pokedex id
db 60 ; base hp
db 60 ; base attack
db 60 ; base defense
db 85 ; base speed
db 85 ; base special
db GHOST ; species type 1
db GHOST ; species type 2
db 45 ; catch rate
db 147 ; base exp yield
INCBIN "pic/bmon/misdreavus.pic",0,1 ; 55, sprite dimensions
dw MisdreavusPicFront
dw MisdreavusPicBack
; move tutor compatibility flags
	m_tutor 7,8
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10
	tmlearn 17,18,19,21,24
	tmlearn 25,29,30,31,32
	tmlearn 33,34,40
	tmlearn 41,42,43,44,45,46
	tmlearn 49,50
db BANK(MisdreavusPicFront)
