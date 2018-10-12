db DEX_HO_OH ; pokedex id
db 106 ; base hp
db 130 ; base attack
db 90  ; base defense
db 90  ; base speed
db 154 ; base special
db FIRE ; species type 1
db FLYING ; species type 2
db 3 ; catch rate
db 220 ; base exp yield
INCBIN "pic/bmon/hooh.pic",0,1 ; sprite dimensions
dw HoohPicFront
dw HoohPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 4,6
	tmlearn 9,10,15
	tmlearn 22,23
	tmlearn 31,32
	tmlearn 33,34,37,38,39
	tmlearn 41,44
	tmlearn 50,52
db BANK(HoohPicFront)
