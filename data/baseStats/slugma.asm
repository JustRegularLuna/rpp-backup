SlugmaBaseStats: ; 384da (e:44da)
db DEX_SLUGMA ; pokedex id
db 40 ; base hp
db 40 ; base attack
db 40 ; base defense
db 20 ; base speed
db 70 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 190 ; catch rate
db 78 ; base exp yield
INCBIN "pic/bmon/slugma.pic",0,1 ; 55, sprite dimensions
dw SlugmaPicFront
dw SlugmaPicBack
; move tutor compatibility flags
	m_tutor 5
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10
	tmlearn 18,22
	tmlearn 26,27,28,31,32
	tmlearn 33,34,36,37,38,40
	tmlearn 44,47,48
	tmlearn 54
db BANK(SlugmaPicFront)
