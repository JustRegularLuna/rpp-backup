MagmortarBaseStats: ; 3918a (e:518a)
db DEX_MAGMORTAR ; pokedex id
db 75 ; base hp
db 95 ; base attack
db 67 ; base defense
db 83 ; base speed
db 125 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 30 ; catch rate
db 199 ; base exp yield
INCBIN "pic/bmon/magmortar.pic",0,1 ; 66, sprite dimensions
dw MagmortarPicFront
dw MagmortarPicBack
; attacks known at lvl 0
db SMOG
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001 ;8  - 1
db %01000011 ;16 - 9
db %10101111 ;24 - 17
db %11110010 ;32 - 25
db %10111011 ;40 - 33
db %10101000 ;48 - 41
db %00100010 ;H6 - 49
db BANK(MagmortarPicFront)
