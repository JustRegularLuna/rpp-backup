HoundourBaseStats: ; 38a1a (e:4a1a)
db DEX_HOUNDOUR ; pokedex id
db 45 ; base hp
db 60 ; base attack
db 30 ; base defense
db 65 ; base speed
db 80 ; base special
db DARK ; species type 1
db FIRE ; species type 2
db 190 ; catch rate
db 91 ; base exp yield
INCBIN "pic/bmon/houndour.pic",0,1 ; 55, sprite dimensions
dw HoundourPicFront
dw HoundourPicBack
; attacks known at lvl 0
db EMBER
db LEER
db 0
db 0
db 5 ; growth rate
; learnset
db %10101000 ;8  - 1
db %00000010 ;16 - 9
db %00101010 ;24 - 17
db %11000000 ;32 - 25
db %11010010 ;40 - 33
db %00001111 ;48 - 41
db %00000010 ;H6 - 49
db BANK(HoundourPicFront)
