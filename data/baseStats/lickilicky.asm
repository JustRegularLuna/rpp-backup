LickilickyBaseStats: ; 38f92 (e:4f92)
db DEX_LICKILICKY ; pokedex id
db 110 ; base hp
db 85 ; base attack
db 95 ; base defense
db 50 ; base speed
db 95 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 30 ; catch rate
db 193 ; base exp yield
INCBIN "pic/bmon/lickilicky.pic",0,1 ; 77, sprite dimensions
dw LickilickyPicFront
dw LickilickyPicBack
; attacks known at lvl 0
db LICK
db 0
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 1,3,5,6,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 17,18,19,24
	tmlearn 25,26,27,30,31,32
	tmlearn 34,35,36,37,38,40
	tmlearn 42,44,48
	tmlearn 51,53,54
db BANK(LickilickyPicFront)
