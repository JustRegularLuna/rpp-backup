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
db %10110101
db %01111011
db %00000010
db %10011110
db %01000010
db %00101001
db %00100110
db BANK(WeavilePicFront)
