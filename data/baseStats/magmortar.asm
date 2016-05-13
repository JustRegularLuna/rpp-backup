MagmortarBaseStats: ; 3918a (e:518a)
db DEX_MAGMORTAR ; pokedex id
db 75 ; base hp
db 95 ; base attack
db 67 ; base defense
db 83 ; base speed
db 125 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 30 ; catch rate
db 199 ; base exp yield
INCBIN "pic/bmon/magmortar.pic",0,1 ; 66, sprite dimensions
dw MagmortarPicFront
dw MagmortarPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 9,10
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,15
	tmlearn 17,18,19
	tmlearn 29,30,31,32
	tmlearn 34,36,37,38,40
	tmlearn 44,46
	tmlearn 54
db BANK(MagmortarPicFront)
