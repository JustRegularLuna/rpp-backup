WartortleBaseStats: ; 384a2 (e:44a2)
db DEX_WARTORTLE ; pokedex id
db 59 ; base hp
db 63 ; base attack
db 80 ; base defense
db 58 ; base speed
db 65 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 143 ; base exp yield
INCBIN "pic/bmon/wartortle.pic",0,1 ; 66, sprite dimensions
dw WartortlePicFront
dw WartortlePicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db BUBBLE
db 0
db 3 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,12,13,14,16
	tmlearn 17,18,19
	tmlearn 26,27,28,31,32
	tmlearn 33,34,36,40
	tmlearn 44,48
	tmlearn 53,54,55
db BANK(WartortlePicFront)
