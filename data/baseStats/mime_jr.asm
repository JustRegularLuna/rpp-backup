MimeJrBaseStats: ; 3911a (e:511a)
db DEX_MIME_JR ; pokedex id
db 20 ; base hp
db 25 ; base attack
db 45 ; base defense
db 60 ; base speed
db 90 ; base special
db PSYCHIC ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 136 ; base exp yield
INCBIN "pic/bmon/mime_jr.pic",0,1 ; 66, sprite dimensions
dw MimeJrPicFront
dw MimeJrPicBack
; attacks known at lvl 0
db TACKLE
db BARRIER
db CONFUSION
db 0
db 0 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10
	tmlearn 17,18,19,22,24
	tmlearn 25,29,30,31,32
	tmlearn 33,34,40
	tmlearn 41,42,44,45,46
	tmlearn 49,50
db BANK(MimeJrPicFront)
