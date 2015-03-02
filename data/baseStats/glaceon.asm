GlaceonBaseStats: ; 3926a (e:526a)
db DEX_GLACEON ; pokedex id
db 65 ; base hp
db 60 ; base attack
db 110 ; base defense
db 65 ; base speed
db 130 ; base special
db ICE ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/glaceon.pic",0,1 ; 66, sprite dimensions
dw GlaceonPicFront
dw GlaceonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01111111
db %00001000
db %11000000
db %11000011
db %00001000
db %00010010
db BANK(GlaceonPicFront)
