LanturnBaseStats:
db DEX_LANTURN ; pokedex id
db 125 ; base hp
db 58 ; base attack
db 58 ; base defense
db 67 ; base speed
db 76 ; base special
db WATER ; species type 1
db ELECTRIC ; species type 2
db 75 ; catch rate
db 161 ; base exp yield
INCBIN "pic/bmon/lanturn.pic",0,1 ; 55, sprite dimensions
dw LanturnPicFront
dw LanturnPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,11,12,13,14,15
	tmlearn 24
	tmlearn 25,30,31,32
	tmlearn 33,34
	tmlearn 44,45,46
	tmlearn 49,50,53,54,55
db BANK(LanturnPicFront)
