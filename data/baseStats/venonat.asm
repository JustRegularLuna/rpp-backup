VenonatBaseStats: ; 38902 (e:4902)
db DEX_VENONAT ; pokedex id
db 60 ; base hp
db 55 ; base attack
db 50 ; base defense
db 45 ; base speed
db 40 ; base special
db BUG ; species type 1
db POISON ; species type 2
db 190 ; catch rate
db 75 ; base exp yield
INCBIN "pic/bmon/venonat.pic",0,1 ; 55, sprite dimensions
dw VenonatPicFront
dw VenonatPicBack
; attacks known at lvl 0
db TACKLE
db DISABLE
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 4,6
	tmlearn 9,10
	tmlearn 21,22
	tmlearn 29,30,31,32
	tmlearn 33,34,39
	tmlearn 41,44,46
	tmlearn 49,50
db BANK(VenonatPicFront)
