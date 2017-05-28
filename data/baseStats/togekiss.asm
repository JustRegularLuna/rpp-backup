TogekissBaseStats:
db DEX_TOGEKISS ; pokedex id
db 85 ; base hp
db 50 ; base attack
db 95 ; base defense
db 80 ; base speed
db 120 ; base special
db FAIRY ; species type 1
db FLYING ; species type 2
db 30 ; catch rate
db 220 ; base exp yield
INCBIN "pic/bmon/togekiss.pic",0,1 ; 55, sprite dimensions
dw TogekissPicFront
dw TogekissPicBack
; move tutor compatibility flags
	m_tutor 0
	m_tutor 0
	m_tutor 0
	m_tutor 0
db 3 ; growth rate
; learnset
	tmlearn 4,6,8
	tmlearn 9,10,15
	tmlearn 22,23
	tmlearn 29,30,31,32
	tmlearn 34,37,38,39,40
	tmlearn 41,42,44,45,46
	tmlearn 49,50,52
db BANK(TogekissPicFront)
