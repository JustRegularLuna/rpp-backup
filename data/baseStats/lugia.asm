LugiaBaseStats: ; 425b (1:425b)
db DEX_LUGIA ; pokedex id
db 106 ; base hp
db 90 ; base attack
db 130 ; base defense
db 110 ; base speed
db 154 ; base special
db PSYCHIC ; species type 1
db FLYING  ; species type 2
db 45 ; catch rate
db 64 ; base exp yield
INCBIN "pic/bmon/lugia.pic",0,1 ; 77, sprite dimensions
dw LugiaPicFront
dw LugiaPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; include learnset directly
	tmlearn 4,6,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 22,23,24
	tmlearn 25,26,27,29,30,31,32
	tmlearn 33,34,35,36,40
	tmlearn 41,42,44,45,46
	tmlearn 50,52,53,54,55
db BANK(LugiaPicFront)
