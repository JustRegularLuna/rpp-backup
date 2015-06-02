MagnezoneBaseStats: ; 38cba (e:4cba)
db DEX_MAGNEZONE ; pokedex id
db 70 ; base hp
db 70 ; base attack
db 115 ; base defense
db 60 ; base speed
db 130 ; base special
db ELECTRIC ; species type 1
db STEEL ; species type 2
db 30 ; catch rate
db 211 ; base exp yield
INCBIN "pic/bmon/magnezone.pic",0,1 ; 66, sprite dimensions
dw MagnezonePicFront
dw MagnezonePicBack
; attacks known at lvl 0
db TACKLE
db SONICBOOM
db THUNDERSHOCK
db 0
db 0 ; growth rate
; learnset
db %00100000 ;8  - 1
db %01000011 ;16 - 9
db %10001000 ;24 - 17
db %11100001 ;32 - 25
db %01000001 ;40 - 33
db %01011000 ;48 - 41
db %01000011 ;H6 - 49
db BANK(MagnezonePicFront)
