HoundourBaseStats:
db DEX_HOUNDOUR ; pokedex id
db 45 ; base hp
db 60 ; base attack
db 30 ; base defense
db 65 ; base speed
db 80 ; base special
db DARK ; species type 1
db FIRE ; species type 2
db 190 ; catch rate
db 91 ; base exp yield
INCBIN "pic/bmon/houndour.pic",0,1 ; 55, sprite dimensions
dw HoundourPicFront
dw HoundourPicBack
; move tutor compatibility flags
	m_tutor 8
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,16
	tmlearn 22,23
	tmlearn 28,30,32,33
	tmlearn 34,37,38,39,40
	tmlearn 41,42,43,44
	tmlearn 54
db BANK(HoundourPicFront)
