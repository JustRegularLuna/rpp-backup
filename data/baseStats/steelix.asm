SteelixBaseStats: ; 38e26 (e:4e26)
db DEX_STEELIX ; pokedex id
db 75 ; base hp
db 85 ; base attack
db 200 ; base defense
db 30 ; base speed
db 65 ; base special
db STEEL ; species type 1
db GROUND ; species type 2
db 25 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/steelix.pic",0,1 ; 77, sprite dimensions
dw SteelixPicFront
dw SteelixPicBack
; attacks known at lvl 0
db TACKLE
db HARDEN
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000 ;8  - 1
db %01000011 ;16 - 9
db %00001000 ;24 - 17
db %11001110 ;32 - 25
db %10001011 ;40 - 33
db %11001000 ;48 - 41
db %00100110 ;H6 - 49
db BANK(SteelixPicFront)
