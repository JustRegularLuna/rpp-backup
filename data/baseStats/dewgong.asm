db DEX_DEWGONG ; pokedex id
db 90 ; base hp
db 70 ; base attack
db 80 ; base defense
db 70 ; base speed
db 95 ; base special
db WATER ; species type 1
db ICE ; species type 2
db 75 ; catch rate
db 176 ; base exp yield
INCBIN "pic/bmon/dewgong.pic",0,1 ; 66, sprite dimensions
dw DewgongPicFront
dw DewgongPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6,7,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 0
	tmlearn 31,32
	tmlearn 33,34,40
	tmlearn 44
	tmlearn 53,55
db BANK(DewgongPicFront)
