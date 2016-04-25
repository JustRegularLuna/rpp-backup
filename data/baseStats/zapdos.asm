ZapdosBaseStats: ; 3939e (e:539e)
db DEX_ZAPDOS ; pokedex id
db 90 ; base hp
db 90 ; base attack
db 85 ; base defense
db 100 ; base speed
db 125 ; base special
db ELECTRIC ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 216 ; base exp yield
INCBIN "pic/bmon/zapdos.pic",0,1 ; 77, sprite dimensions
dw ZapdosPicFront
dw ZapdosPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 5 ; growth rate
; learnset
	tmlearn 4,6
	tmlearn 9,10,15
	tmlearn 24
	tmlearn 25,31,32
	tmlearn 33,34,39
	tmlearn 41,44,45
	tmlearn 49,50,52
db BANK(ZapdosPicFront)
