ScizorBaseStats: ; 39136 (e:5136)
db DEX_SCIZOR ; pokedex id
db 70 ; base hp
db 130 ; base attack
db 100 ; base defense
db 65 ; base speed
db 80 ; base special
db BUG ; species type 1
db STEEL ; species type 2
db 25 ; catch rate
db 200 ; base exp yield
INCBIN "pic/bmon/scizor.pic",0,1 ; 77, sprite dimensions
dw ScizorPicFront
dw ScizorPicBack
; attacks known at lvl 0
db QUICK_ATTACK
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
db %00100110 ;8  - 1
db %01000011 ;16 - 9
db %00001010 ;24 - 17
db %11000000 ;32 - 25
db %11000011 ;40 - 33
db %00001000 ;48 - 41
db %00100110 ;H6 - 49
db BANK(ScizorPicFront)
