TentacoolBaseStats: ; 38ba2 (e:4ba2)
db DEX_TENTACOOL ; pokedex id
db 40 ; base hp
db 40 ; base attack
db 35 ; base defense
db 70 ; base speed
db 100 ; base special
db WATER ; species type 1
db POISON ; species type 2
db 190 ; catch rate
db 105 ; base exp yield
INCBIN "pic/bmon/tentacool.pic",0,1 ; 55, sprite dimensions
dw TentacoolPicFront
dw TentacoolPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 3,6
	tmlearn 9,10,11,12,13,14
	tmlearn 21
	tmlearn 30,31,32
	tmlearn 33,34,40
	tmlearn 44,45,46
	tmlearn 49,50,51,53,55
db BANK(TentacoolPicFront)
