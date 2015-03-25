WeavileBaseStats: ; 38aa6 (e:4aa6)
db DEX_WEAVILE ; pokedex id
db 70 ; base hp
db 120 ; base attack
db 65 ; base defense
db 125 ; base speed
db 85 ; base special
db DARK ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 199 ; base exp yield
INCBIN "pic/bmon/weavile.pic",0,1 ; 55, sprite dimensions
dw WeavilePicFront
dw WeavilePicBack
; attacks known at lvl 0
db SCRATCH
db LEER
db QUICK_ATTACK
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
db BANK(WeavilePicFront)
