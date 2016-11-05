SneaselBaseStats: ; 38aa6 (e:4aa6)
db DEX_SNEASEL ; pokedex id
db 55 ; base hp
db 95 ; base attack
db 55 ; base defense
db 115 ; base speed
db 75 ; base special
db DARK ; species type 1
db ICE ; species type 2
db 60 ; catch rate
db 132 ; base exp yield
INCBIN "pic/bmon/sneasel.pic",0,1 ; 55, sprite dimensions
dw SneaselPicFront
dw SneaselPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 11
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 1,3,5,6,8
	tmlearn 9,10,13,14,16
	tmlearn 20
	tmlearn 28,30,31,32
	tmlearn 34,39,40
	tmlearn 41,43,44,46
	tmlearn 51,53,54
db BANK(SneaselPicFront)
