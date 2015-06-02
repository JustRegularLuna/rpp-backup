CrobatBaseStats: ; 3885a (e:485a)
db DEX_CROBAT ; pokedex id
db 85 ; base hp
db 90 ; base attack
db 80 ; base defense
db 130 ; base speed
db 80 ; base special
db POISON ; species type 1
db FLYING ; species type 2
db 90 ; catch rate
db 204 ; base exp yield
INCBIN "pic/bmon/crobat.pic",0,1 ; 77, sprite dimensions
dw CrobatPicFront
dw CrobatPicBack
; attacks known at lvl 0
db LEECH_LIFE
db SCREECH
db BITE
db 0
db 0 ; growth rate
; learnset
db %00101000 ;8  - 1
db %01000011 ;16 - 9
db %00011000 ;24 - 17
db %11000000 ;32 - 25
db %01000001 ;40 - 33
db %00001101 ;48 - 41
db %00001010 ;H6 - 49
db BANK(CrobatPicFront)
