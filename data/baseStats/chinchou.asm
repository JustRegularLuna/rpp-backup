ChinchouBaseStats:
db DEX_CHINCHOU ; pokedex id
db 75 ; base hp
db 38 ; base attack
db 38 ; base defense
db 67 ; base speed
db 56 ; base special
db WATER ; species type 1
db ELECTRIC ; species type 2
db 190 ; catch rate
db 90 ; base exp yield
INCBIN "pic/bmon/chinchou.pic",0,1 ; 55, sprite dimensions
dw ChinchouPicFront
dw ChinchouPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,11,12,13,14
	tmlearn 24
	tmlearn 25,30,31,32
	tmlearn 33,34
	tmlearn 44,45,46
	tmlearn 49,50,53,55
db BANK(ChinchouPicFront)
