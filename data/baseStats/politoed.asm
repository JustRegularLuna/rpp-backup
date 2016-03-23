PolitoedBaseStats: ; 38a8a (e:4a8a)
db DEX_POLITOED ; pokedex id
db 90 ; base hp
db 75 ; base attack
db 75 ; base defense
db 70 ; base speed
db 100 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 185 ; base exp yield
INCBIN "pic/bmon/politoed.pic",0,1 ; 77, sprite dimensions
dw PolitoedPicFront
dw PolitoedPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,12,13,14
	tmlearn 17,18,19
	tmlearn 26,27,28,29,30,31,32
	tmlearn 34,40
	tmlearn 44,46
	tmlearn 53,54,55
db BANK(PolitoedPicFront)
