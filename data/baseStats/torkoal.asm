TorkoalBaseStats: ; 384da (e:44da)
db DEX_TORKOAL ; pokedex id
db 70 ; base hp
db 85 ; base attack
db 140 ; base defense
db 20 ; base speed
db 85 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 90 ; catch rate
db 161 ; base exp yield
INCBIN "pic/bmon/torkoal.pic",0,1 ; 55, sprite dimensions
dw TorkoalPicFront
dw TorkoalPicBack
; move tutor compatibility flags
	m_tutor 8
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 5,6,8
	tmlearn 9,10,15,16
	tmlearn 22,23
	tmlearn 26,27,28,31,32
	tmlearn 34,36,37,38,40
	tmlearn 44,48
	tmlearn 54
db BANK(TorkoalPicFront)
