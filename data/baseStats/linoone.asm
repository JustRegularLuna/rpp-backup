db DEX_LINOONE ; pokedex id
db 78  ; base hp
db 70  ; base attack
db 61  ; base defense
db 100 ; base speed
db 61  ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 90 ; catch rate
db 147 ; base exp yield
INCBIN "pic/bmon/linoone.pic",0,1 ; sprite dimensions
dw LinoonePicFront
dw LinoonePicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 0 ; growth rate
; learnset
	tmlearn 2,3,5,6,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 17,18,19,20,24
	tmlearn 25,28,30,31,32
	tmlearn 34,39,40
	tmlearn 44,45
	tmlearn 51,53,54
db BANK(LinoonePicFront)
