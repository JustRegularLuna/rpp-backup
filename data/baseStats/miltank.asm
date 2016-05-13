MiltankBaseStats: ; 38aa6 (e:4aa6)
db DEX_MILTANK ; pokedex id
db 95 ; base hp
db 80 ; base attack
db 105 ; base defense
db 100 ; base speed
db 70 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
INCBIN "pic/bmon/miltank.pic",0,1 ; 55, sprite dimensions
dw MiltankPicFront
dw MiltankPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 9
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,13,14,15,16
	tmlearn 22,24
	tmlearn 25,26,27,30,31,32
	tmlearn 34,36,40
	tmlearn 44,45
	tmlearn 53,54
db BANK(MiltankPicFront)
