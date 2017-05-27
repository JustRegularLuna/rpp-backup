db DEX_DRAGONAIR ; pokedex id
db 61 ; base hp
db 84 ; base attack
db 65 ; base defense
db 70 ; base speed
db 70 ; base special
db DRAGON ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 144 ; base exp yield
INCBIN "pic/bmon/dragonair.pic",0,1 ; 66, sprite dimensions
dw DragonairPicFront
dw DragonairPicBack
; move tutor compatibility flags
	m_tutor 6
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 6,7,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 23,24
	tmlearn 25,31,32
	tmlearn 33,34,37,38,39,40
	tmlearn 44,45,46
	tmlearn 53,55
db BANK(DragonairPicFront)
