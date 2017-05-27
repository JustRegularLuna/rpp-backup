db DEX_LICKITUNG ; pokedex id
db 90 ; base hp
db 55 ; base attack
db 75 ; base defense
db 30 ; base speed
db 60 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 127 ; base exp yield
INCBIN "pic/bmon/lickitung.pic",0,1 ; 77, sprite dimensions
dw LickitungPicFront
dw LickitungPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 9,10,11
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 1,3,5,6,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 17,18,19,24
	tmlearn 25,26,27,30,31,32
	tmlearn 34,35,36,37,38,40
	tmlearn 42,44,48
	tmlearn 51,53,54
db BANK(LickitungPicFront)
