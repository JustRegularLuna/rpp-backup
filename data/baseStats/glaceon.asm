GlaceonBaseStats: ; 3926a (e:526a)
db DEX_GLACEON ; pokedex id
db 65 ; base hp
db 60 ; base attack
db 110 ; base defense
db 65 ; base speed
db 130 ; base special
db ICE ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/glaceon.pic",0,1 ; 66, sprite dimensions
dw GlaceonPicFront
dw GlaceonPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 5,6,8
	tmlearn 9,10,11,13,14,15,16
	tmlearn 0
	tmlearn 28,30,31,32
	tmlearn 33,34,39,40
	tmlearn 44
	tmlearn 54
db BANK(GlaceonPicFront)
