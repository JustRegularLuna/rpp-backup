TyrogueBaseStats: ; 38f5a (e:4f5a)
db DEX_TYROGUE ; pokedex id
db 35 ; base hp
db 35 ; base attack
db 35 ; base defense
db 35 ; base speed
db 35 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 91 ; base exp yield
INCBIN "pic/bmon/tyrogue.pic",0,1 ; 77, sprite dimensions
dw TyroguePicFront
dw TyroguePicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10
	tmlearn 17,18,19
	tmlearn 26,27,31,32
	tmlearn 34,36,39,40
	tmlearn 44,48
	tmlearn 54
db BANK(TyroguePicFront)
