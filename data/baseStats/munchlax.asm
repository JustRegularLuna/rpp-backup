MunchlaxBaseStats: ; 39366 (e:5366)
db DEX_MUNCHLAX ; pokedex id
db 135 ; base hp
db 85 ; base attack
db 40 ; base defense
db 5 ; base speed
db 85 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 25 ; catch rate
db 154 ; base exp yield
INCBIN "pic/bmon/munchlax.pic",0,1 ; 77, sprite dimensions
dw MunchlaxPicFront
dw MunchlaxPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,12,13,14,16
	tmlearn 17,18,19,20,22,24
	tmlearn 25,26,27,29,30,31,32
	tmlearn 33,34,36,37,38,40
	tmlearn 44,46,48
	tmlearn 53,54
db BANK(MunchlaxPicFront)
