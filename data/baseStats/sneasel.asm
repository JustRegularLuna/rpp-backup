SneaselBaseStats: ; 38aa6 (e:4aa6)
db DEX_SNEASEL ; pokedex id
db 55 ; base hp
db 95 ; base attack
db 55 ; base defense
db 115 ; base speed
db 75 ; base special
db DARK ; species type 1
db ICE ; species type 2
db 60 ; catch rate
db 132 ; base exp yield
INCBIN "pic/bmon/sneasel.pic",0,1 ; 55, sprite dimensions
dw SneaselPicFront
dw SneaselPicBack
; attacks known at lvl 0
db SCRATCH
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
db BANK(SneaselPicFront)
