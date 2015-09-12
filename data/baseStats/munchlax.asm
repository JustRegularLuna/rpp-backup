MunchlaxBaseStats: ; 39366 (e:5366)
db DEX_MUNCHLAX ; pokedex id
db 135 ; base hp
db 85 ; base attack
db 40 ; base defense
db 5 ; base speed
db 85 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 25 ; catch rate
db 154 ; base exp yield
INCBIN "pic/bmon/munchlax.pic",0,1 ; 77, sprite dimensions
dw MunchlaxPicFront
dw MunchlaxPicBack
; attacks known at lvl 0
db TACKLE
db LICK
db 0
db 0
db 5 ; growth rate
; learnset
db %10110001
db %11111111
db %10101111
db %11010111
db %10110111
db %10101001
db %00110010
db BANK(MunchlaxPicFront)
