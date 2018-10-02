TogepiBaseStats:
db DEX_TOGEPI ; pokedex id
db 35 ; base hp
db 20 ; base attack
db 65 ; base defense
db 20 ; base speed
db 65 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 190 ; catch rate
db 74 ; base exp yield
INCBIN "pic/bmon/togepi.pic",0,1 ; 55, sprite dimensions
dw TogepiPicFront
dw TogepiPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 5,6,8
	tmlearn 9,10,11
	tmlearn 18,22
	tmlearn 29,30,31,32
	tmlearn 34,37,38,39,40
	tmlearn 42,44,45,46
	tmlearn 49,50
db BANK(TogepiPicFront)
