MiltankBaseStats: ; 38aa6 (e:4aa6)
db DEX_MILTANK ; pokedex id
db 95 ; base hp
db 80 ; base attack
db 105 ; base defense
db 100 ; base speed
db 70 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
INCBIN "pic/bmon/miltank.pic",0,1 ; 55, sprite dimensions
dw MiltankPicFront
dw MiltankPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db 0
db 0
db 3 ; growth rate
; learnset
db %10110001
db %00000011
db %00001111
db %11110000
db %10000111
db %00111001
db %01000011
db BANK(MiltankPicFront)
