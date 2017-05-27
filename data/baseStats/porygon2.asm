Porygon2BaseStats:
db DEX_PORYGON2 ; pokedex id
db 85 ; base hp
db 80 ; base attack
db 90 ; base defense
db 60 ; base speed
db 105 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 180 ; base exp yield
INCBIN "pic/bmon/porygon2.pic",0,1 ; 66, sprite dimensions
dw Porygon2PicFront
dw Porygon2PicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6
	tmlearn 9,10,13,14,15
	tmlearn 22,24
	tmlearn 25,29,30,31,32
	tmlearn 33,34,39,40
	tmlearn 41,43,44,45,46
	tmlearn 49,50
db BANK(Porygon2PicFront)
