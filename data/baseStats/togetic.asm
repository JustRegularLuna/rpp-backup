TogeticBaseStats: ; 38582 (e:4582)
db DEX_TOGETIC ; pokedex id
db 55 ; base hp
db 40 ; base attack
db 85 ; base defense
db 40 ; base speed
db 105 ; base special
db FAIRY ; species type 1
db FLYING ; species type 2
db 75 ; catch rate
db 114 ; base exp yield
INCBIN "pic/bmon/togetic.pic",0,1 ; 55, sprite dimensions
dw TogeticPicFront
dw TogeticPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10110000 ;8  - 1
db %11001111 ;16 - 9
db %00101110 ;24 - 17
db %11010000 ;32 - 25
db %11110111 ;40 - 33
db %00011111 ;48 - 41
db %01001010 ;H6 - 49
db BANK(TogeticPicFront)
