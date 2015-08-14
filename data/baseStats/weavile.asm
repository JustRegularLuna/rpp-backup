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
db %00100101 ;8  - 1
db %11110011 ;16 - 9
db %00001010 ;24 - 17
db %11001000 ;32 - 25
db %11000011 ;40 - 33
db %00001111 ;48 - 41
db %00110110 ;H6 - 49
db BANK(WeavilePicFront)
