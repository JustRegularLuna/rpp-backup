SkarmoryBaseStats: ; 38aa6 (e:4aa6)
db DEX_SKARMORY ; pokedex id
db 65 ; base hp
db 80 ; base attack
db 140 ; base defense
db 70 ; base speed
db 70 ; base special
db STEEL ; species type 1
db FLYING ; species type 2
db 25 ; catch rate
db 168 ; base exp yield
INCBIN "pic/bmon/skarmory.pic",0,1 ; 55, sprite dimensions
dw SkarmoryPicFront
dw SkarmoryPicBack
; attacks known at lvl 0
db PECK
db LEER
db 0
db 0
db 3 ; growth rate
; learnset
db %00100100 ;8  - 1
db %00000011 ;16 - 9
db %00001010 ;24 - 17
db %11000000 ;32 - 25
db %01001001 ;40 - 33
db %10001100 ;48 - 41
db %01001110 ;H6 - 49
db BANK(SkarmoryPicFront)
