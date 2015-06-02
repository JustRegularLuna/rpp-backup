ChinchouBaseStats: ; 38aa6 (e:4aa6)
db DEX_CHINCHOU ; pokedex id
db 75 ; base hp
db 38 ; base attack
db 38 ; base defense
db 67 ; base speed
db 56 ; base special
db WATER ; species type 1
db ELECTRIC ; species type 2
db 190 ; catch rate
db 90 ; base exp yield
INCBIN "pic/bmon/chinchou.pic",0,1 ; 55, sprite dimensions
dw ChinchouPicFront
dw ChinchouPicBack
; attacks known at lvl 0
db BUBBLE
db SUPERSONIC
db 0
db 0
db 3 ; growth rate
; learnset
db %00100000 ;8  - 1
db %00111110 ;16 - 9
db %10001000 ;24 - 17
db %11000001 ;32 - 25
db %00000000 ;40 - 33
db %00011000 ;48 - 41
db %01010010 ;H6 - 49
db BANK(ChinchouPicFront)
