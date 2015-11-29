WeavileBaseStats: ; 38aa6 (e:4aa6)
db DEX_WEAVILE ; pokedex id
db 70 ; base hp
db 120 ; base attack
db 65 ; base defense
db 125 ; base speed
db 85 ; base special
db DARK ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 199 ; base exp yield
INCBIN "pic/bmon/weavile.pic",0,1 ; 55, sprite dimensions
dw WeavilePicFront
dw WeavilePicBack
; attacks known at lvl 0
db SCRATCH
db LEER
db QUICK_ATTACK
db 0
db 3 ; growth rate
; learnset
	tmlearn 1,3,5,6,8
	tmlearn 9,10,13,14,15,16
	tmlearn 20
	tmlearn 28,30,31,32
	tmlearn 34,39,40
	tmlearn 41,43,44,46
	tmlearn 51,53,54
db BANK(WeavilePicFront)
