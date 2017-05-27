LatiosBaseStats:
db DEX_LATIOS ; pokedex id
db 80 ; base hp
db 90 ; base attack
db 80 ; base defense
db 110 ; base speed
db 130 ; base special
db DRAGON ; species type 1
db PSYCHIC  ; species type 2
db 3 ; catch rate
db 211 ; base exp yield
INCBIN "pic/bmon/latios.pic",0,1 ; 77, sprite dimensions
dw LatiosPicFront
dw LatiosPicBack
; move tutor compatibility flags
	m_tutor 6
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; include learnset directly
	tmlearn 2,3,4,6,8
	tmlearn 9,10,11,13,14,15,16
	tmlearn 22,23,24
	tmlearn 25,26,27,29,30,31,32
	tmlearn 33,34,39,40
	tmlearn 41,42,44,45,46
	tmlearn 50,52,53,55
db BANK(LatiosPicFront)
