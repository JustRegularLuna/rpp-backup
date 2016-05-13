CleffaBaseStats: ; 38796 (e:4796)
db DEX_CLEFFA ; pokedex id
db 50 ; base hp
db 25 ; base attack
db 28 ; base defense
db 15 ; base speed
db 55 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 150 ; catch rate
db 68 ; base exp yield
INCBIN "pic/bmon/cleffa.pic",0,1 ; 55, sprite dimensions
dw CleffaPicFront
dw CleffaPicBack
; move tutor compatibility flags
	m_tutor 7
	m_tutor 9,10,11
	m_tutor 0
	m_tutor 0
db 4 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,13,14,16
	tmlearn 17,18,19,22,24
	tmlearn 25,29,30,31,32
	tmlearn 33,34,37,38,40
	tmlearn 42,43,44,45,46
	tmlearn 49,50
db BANK(CleffaPicFront)
