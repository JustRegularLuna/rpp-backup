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
db %10110001
db %00000011
db %00001111
db %11110000
db %10000111
db %00111001
db %01000011
db BANK(SkarmoryPicFront)
