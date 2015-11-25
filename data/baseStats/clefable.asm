ClefableBaseStats: ; 387b2 (e:47b2)
db DEX_CLEFABLE ; pokedex id
db 95 ; base hp
db 70 ; base attack
db 73 ; base defense
db 60 ; base speed
db 95 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 25 ; catch rate
db 129 ; base exp yield
INCBIN "pic/bmon/clefable.pic",0,1 ; 66, sprite dimensions
dw ClefablePicFront
dw ClefablePicBack
; attacks known at lvl 0
db SING
db DOUBLESLAP
db MINIMIZE
db METRONOME
db 4 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,13,14,15,16
	tmlearn 17,18,19,22,24
	tmlearn 25,29,30,31,32
	tmlearn 33,34,37,38,40
	tmlearn 42,43,44,45,46
	tmlearn 49,50,54
db BANK(ClefablePicFront)
