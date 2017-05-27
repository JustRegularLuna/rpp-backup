SmoochumBaseStats:
db DEX_SMOOCHUM ; pokedex id
db 45 ; base hp
db 30 ; base attack
db 15 ; base defense
db 65 ; base speed
db 85 ; base special
db ICE ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 137 ; base exp yield
INCBIN "pic/bmon/smoochum.pic",0,1 ; 66, sprite dimensions
dw SmoochumPicFront
dw SmoochumPicBack
; move tutor compatibility flags
	m_tutor 8
	m_tutor 11
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,12,13,14
	tmlearn 17,18,19
	tmlearn 29,30,31,32
	tmlearn 33,34,40
	tmlearn 42,44,46
	tmlearn 50
db BANK(SmoochumPicFront)
