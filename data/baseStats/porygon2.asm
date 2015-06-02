Porygon2BaseStats: ; 392be (e:52be)
db DEX_PORYGON2 ; pokedex id
db 85 ; base hp
db 80 ; base attack
db 90 ; base defense
db 60 ; base speed
db 105 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 180 ; base exp yield
INCBIN "pic/bmon/porygon2.pic",0,1 ; 66, sprite dimensions
dw Porygon2PicFront
dw Porygon2PicBack
; attacks known at lvl 0
db TACKLE
db SHARPEN
db CONVERSION
db 0
db 0 ; growth rate
; learnset
db %00100000 ;8  - 1
db %01110010 ;16 - 9
db %11001000 ;24 - 17
db %11110001 ;32 - 25
db %11000011 ;40 - 33
db %00111011 ;48 - 41
db %01000011 ;H6 - 49
db BANK(Porygon2PicFront)
