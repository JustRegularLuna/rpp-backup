HoundoomBaseStats: ; 38a36 (e:4a36)
db DEX_HOUNDOOM ; pokedex id
db 75 ; base hp
db 90 ; base attack
db 50 ; base defense
db 95 ; base speed
db 110 ; base special
db DARK ; species type 1
db FIRE ; species type 2
db 75 ; catch rate
db 213 ; base exp yield
INCBIN "pic/bmon/houndoom.pic",0,1 ; 77, sprite dimensions
dw HoundoomPicFront
dw HoundoomPicBack
; move tutor compatibility flags
	m_tutor 8
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,15,16
	tmlearn 22,23
	tmlearn 28,30,32,33
	tmlearn 34,37,38,39,40
	tmlearn 41,42,43,44
	tmlearn 54
db BANK(HoundoomPicFront)
