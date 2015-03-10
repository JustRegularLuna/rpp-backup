TangrowthBaseStats: ; 3903a (e:503a)
db DEX_TANGROWTH ; pokedex id
db 100 ; base hp
db 100 ; base attack
db 125 ; base defense
db 50 ; base speed
db 110 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 30 ; catch rate
db 211 ; base exp yield
INCBIN "pic/bmon/tangrowth.pic",0,1 ; 66, sprite dimensions
dw TangrowthPicFront
dw TangrowthPicBack
; attacks known at lvl 0
db CONSTRICT
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10100100
db %01000011
db %00111000
db %11000000
db %10000010
db %00001000
db %00000110
db BANK(TangrowthPicFront)
