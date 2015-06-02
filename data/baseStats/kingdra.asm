KingdraBaseStats: ; 3908e (e:508e)
db DEX_KINGDRA ; pokedex id
db 75 ; base hp
db 95 ; base attack
db 95 ; base defense
db 85 ; base speed
db 95 ; base special
db WATER ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 207 ; base exp yield
INCBIN "pic/bmon/kingdra.pic",0,1 ; 66, sprite dimensions
dw KingdraPicFront
dw KingdraPicBack
; attacks known at lvl 0
db BUBBLE
db SMOKESCREEN
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000 ;8  - 1
db %01111111 ;16 - 9
db %01001000 ;24 - 17
db %11000000 ;32 - 25
db %11000011 ;40 - 33
db %00001000 ;48 - 41
db %00110010 ;H6 - 49
db BANK(KingdraPicFront)
