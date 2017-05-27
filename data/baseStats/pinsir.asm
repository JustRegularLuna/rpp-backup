db DEX_PINSIR ; pokedex id
db 65 ; base hp
db 125 ; base attack
db 100 ; base defense
db 85 ; base speed
db 55 ; base special
db BUG ; species type 1
db BUG ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
INCBIN "pic/bmon/pinsir.pic",0,1 ; 77, sprite dimensions
dw PinsirPicFront
dw PinsirPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 1,3,5,6,8
	tmlearn 9,10,15
	tmlearn 17,18,19
	tmlearn 26,27,28,31,32
	tmlearn 34,36
	tmlearn 41,44,48
	tmlearn 51,54
db BANK(PinsirPicFront)
