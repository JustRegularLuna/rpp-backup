MukBaseStats: ; 38d7e (e:4d7e)
db DEX_MUK ; pokedex id
db 105 ; base hp
db 105 ; base attack
db 75 ; base defense
db 50 ; base speed
db 65 ; base special
db POISON ; species type 1
db POISON ; species type 2
db 75 ; catch rate
db 157 ; base exp yield
INCBIN "pic/bmon/muk.pic",0,1 ; 77, sprite dimensions
dw MukPicFront
dw MukPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,12,15
	tmlearn 21,24
	tmlearn 25,28,31,32
	tmlearn 34,36,37,38
	tmlearn 44,47,48
	tmlearn 54
db BANK(MukPicFront)
