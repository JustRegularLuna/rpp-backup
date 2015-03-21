PorygonZBaseStats: ; 392be (e:52be)
db DEX_PORYGONZ ; pokedex id
db 85 ; base hp
db 80 ; base attack
db 70 ; base defense
db 90 ; base speed
db 135 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 30 ; catch rate
db 185 ; base exp yield
INCBIN "pic/bmon/porygonz.pic",0,1 ; 66, sprite dimensions
dw PorygonZPicFront
dw PorygonZPicBack
; attacks known at lvl 0
db TACKLE
db SHARPEN
db CONVERSION
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01110011
db %10001000
db %11110001
db %11000011
db %00111101
db %01000011
db BANK(PorygonZPicFront)
