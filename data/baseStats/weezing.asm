db DEX_WEEZING ; pokedex id
db 65 ; base hp
db 90 ; base attack
db 120 ; base defense
db 60 ; base speed
db 85 ; base special
db POISON ; species type 1
db POISON ; species type 2
db 60 ; catch rate
db 173 ; base exp yield
INCBIN "pic/bmon/weezing.pic",0,1 ; 77, sprite dimensions
dw WeezingPicFront
dw WeezingPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6
	tmlearn 9,10,15
	tmlearn 24
	tmlearn 25,30,31,32
	tmlearn 34,37,38
	tmlearn 43,44,47
	tmlearn 50,54
db BANK(WeezingPicFront)
