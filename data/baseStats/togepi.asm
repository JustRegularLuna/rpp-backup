TogepiBaseStats: ; 38582 (e:4582)
db DEX_TOGEPI ; pokedex id
db 35 ; base hp
db 20 ; base attack
db 65 ; base defense
db 20 ; base speed
db 65 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 190 ; catch rate
db 74 ; base exp yield
INCBIN "pic/bmon/togepi.pic",0,1 ; 55, sprite dimensions
dw TogepiPicFront
dw TogepiPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10110000 ;8  - 1
db %10001111 ;16 - 9
db %00101110 ;24 - 17
db %11010000 ;32 - 25
db %11110111 ;40 - 33
db %00011011 ;48 - 41
db %01000010 ;H6 - 49
db BANK(TogepiPicFront)
