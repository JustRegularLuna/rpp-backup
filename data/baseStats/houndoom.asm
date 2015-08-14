HoundoomBaseStats: ; 38a36 (e:4a36)
db DEX_HOUNDOOM ; pokedex id
db 75 ; base hp
db 90 ; base attack
db 50 ; base defense
db 95 ; base speed
db 110 ; base special
db DARK ; species type 1
db FIRE ; species type 2
db 75 ; catch rate
db 213 ; base exp yield
INCBIN "pic/bmon/houndoom.pic",0,1 ; 77, sprite dimensions
dw HoundoomPicFront
dw HoundoomPicBack
; attacks known at lvl 0
db EMBER
db LEER
db ROAR
db SMOG
db 5 ; growth rate
; learnset
db %10100000 ;8  - 1
db %01000011 ;16 - 9
db %00101010 ;24 - 17
db %11000000 ;32 - 25
db %11010010 ;40 - 33
db %00001111 ;48 - 41
db %00100010 ;H6 - 49
db BANK(HoundoomPicFront)
