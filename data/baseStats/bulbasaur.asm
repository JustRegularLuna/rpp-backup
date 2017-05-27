MonBaseStats:
db DEX_BULBASAUR ; pokedex id
db 45 ; base hp
db 49 ; base attack
db 49 ; base defense
db 45 ; base speed
db 65 ; base special
db GRASS ; species type 1
db POISON ; species type 2
db 45 ; catch rate
db 64 ; base exp yield
INCBIN "pic/bmon/bulbasaur.pic",0,1 ; 55, sprite dimensions
dw BulbasaurPicFront
dw BulbasaurPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 3,6,8
	tmlearn 9,10
	tmlearn 21,22
	tmlearn 31,32
	tmlearn 33,34
	tmlearn 44
	tmlearn 50,51,54
db BANK(BulbasaurPicFront)
MonBaseStatsEnd:
