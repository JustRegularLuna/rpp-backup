UmbreonBaseStats: ; 3926a (e:526a)
db DEX_UMBREON ; pokedex id
db 95 ; base hp
db 65 ; base attack
db 110 ; base defense
db 65 ; base speed
db 130 ; base special
db DARK ; species type 1
db DARK ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/umbreon.pic",0,1 ; 66, sprite dimensions
dw UmbreonPicFront
dw UmbreonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01001111
db %00001000
db %11010000
db %11000011
db %00001101
db %01000010
db BANK(UmbreonPicFront)
