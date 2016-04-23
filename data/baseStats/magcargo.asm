MagcargoBaseStats: ; 384da (e:44da)
db DEX_MAGCARGO ; pokedex id
db 50 ; base hp
db 50 ; base attack
db 120 ; base defense
db 30 ; base speed
db 80 ; base special
db FIRE ; species type 1
db ROCK ; species type 2
db 75 ; catch rate
db 154 ; base exp yield
INCBIN "pic/bmon/magcargo.pic",0,1 ; 55, sprite dimensions
dw MagcargoPicFront
dw MagcargoPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,15
	tmlearn 18,22
	tmlearn 26,27,28,31,32
	tmlearn 33,34,36,37,38,40
	tmlearn 44,47,48
	tmlearn 54
db BANK(MagcargoPicFront)
