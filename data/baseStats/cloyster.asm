CloysterBaseStats: ; 38db6 (e:4db6)
db DEX_CLOYSTER ; pokedex id
db 50 ; base hp
db 95 ; base attack
db 180 ; base defense
db 70 ; base speed
db 85 ; base special
db WATER ; species type 1
db ICE ; species type 2
db 60 ; catch rate
db 203 ; base exp yield
INCBIN "pic/bmon/cloyster.pic",0,1 ; 77, sprite dimensions
dw CloysterPicFront
dw CloysterPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 6,7
	tmlearn 9,10,11,12,13,14,15
	tmlearn 0
	tmlearn 30,31,32
	tmlearn 33,39
	tmlearn 44,47
	tmlearn 53,55
db BANK(CloysterPicFront)
