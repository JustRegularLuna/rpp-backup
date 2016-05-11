HaunterBaseStats: ; 38dee (e:4dee)
db DEX_HAUNTER ; pokedex id
db 45 ; base hp
db 50 ; base attack
db 45 ; base defense
db 95 ; base speed
db 115 ; base special
db GHOST ; species type 1
db POISON ; species type 2
db 90 ; catch rate
db 126 ; base exp yield
INCBIN "pic/bmon/haunter.pic",0,1 ; 66, sprite dimensions
dw HaunterPicFront
dw HaunterPicBack
; move tutor compatibility flags
	m_tutor 7
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10
	tmlearn 17,18,19,21,24
	tmlearn 25,29,30,31,32
	tmlearn 40
	tmlearn 42,43,44,46,47
	tmlearn 49,54
db BANK(HaunterPicFront)
