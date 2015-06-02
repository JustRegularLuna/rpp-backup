EspeonBaseStats: ; 3926a (e:526a)
db DEX_ESPEON ; pokedex id
db 65 ; base hp
db 65 ; base attack
db 60 ; base defense
db 110 ; base speed
db 130 ; base special
db PSYCHIC ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/espeon.pic",0,1 ; 66, sprite dimensions
dw EspeonPicFront
dw EspeonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000 ;8  - 1
db %01000011 ;16 - 9
db %00001000 ;24 - 17
db %11111000 ;32 - 25
db %11000011 ;40 - 33
db %00101011 ;48 - 41
db %01000110 ;H6 - 49
db BANK(EspeonPicFront)
