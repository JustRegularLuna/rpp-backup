LeafeonBaseStats: ; 3926a (e:526a)
db DEX_LEAFEON ; pokedex id
db 65 ; base hp
db 110 ; base attack
db 130 ; base defense
db 95 ; base speed
db 65 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/leafeon.pic",0,1 ; 66, sprite dimensions
dw LeafeonPicFront
dw LeafeonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10100100 ;8  - 1
db %01000011 ;16 - 9
db %00111000 ;24 - 17
db %11001000 ;32 - 25
db %11000011 ;40 - 33
db %00001001 ;48 - 41
db %01100010 ;H6 - 49
db BANK(LeafeonPicFront)
