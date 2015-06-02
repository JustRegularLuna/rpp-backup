HonchkrowBaseStats: ; 3860e (e:460e)
db DEX_HONCHKROW ; pokedex id
db 100 ; base hp
db 125 ; base attack
db 52 ; base defense
db 71 ; base speed
db 105 ; base special
db DARK ; species type 1
db FLYING ; species type 2
db 30 ; catch rate
db 177 ; base exp yield
INCBIN "pic/bmon/honchkrow.pic",0,1 ; sprite dimensions
dw HonchkrowPicFront
dw HonchkrowPicBack
; attacks known at lvl 0
db WING_ATTACK
db HAZE
db FEINT_ATTACK
db 0
db 0 ; growth rate
; learnset
db %00101000 ;8  - 1
db %01000010 ;16 - 9
db %00001000 ;24 - 17
db %11010000 ;32 - 25
db %01000000 ;40 - 33
db %00011111 ;48 - 41
db %00001010 ;H6 - 49
db BANK(HonchkrowPicFront)
