GyaradosBaseStats: ; 391fa (e:51fa)
db DEX_GYARADOS ; pokedex id
db 95 ; base hp
db 125 ; base attack
db 79 ; base defense
db 81 ; base speed
db 100 ; base special
db WATER ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 214 ; base exp yield
INCBIN "pic/bmon/gyarados.pic",0,1 ; 77, sprite dimensions
dw GyaradosPicFront
dw GyaradosPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 23,24
	tmlearn 25,26,27,31,32
	tmlearn 33,34,37,38,40
	tmlearn 41,43,44
	tmlearn 53,54,55
db BANK(GyaradosPicFront)
