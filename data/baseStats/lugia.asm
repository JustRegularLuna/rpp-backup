LugiaBaseStats: ; 425b (1:425b)
db DEX_LUGIA ; pokedex id
db 106 ; base hp
db 90 ; base attack
db 130 ; base defense
db 110 ; base speed
db 154 ; base special
db PSYCHIC ; species type 1
db FLYING  ; species type 2
db 45 ; catch rate
db 64 ; base exp yield
INCBIN "pic/bmon/lugia.pic",0,1 ; 77, sprite dimensions
dw LugiaPicFront
dw LugiaPicBack
; attacks known at lvl 0
db WATER_GUN
db SKY_ATTACK
db 0
db 0
db 3 ; growth rate
; include learnset directly
db %10101000 ;8  - 1
db %01111110 ;16 - 9
db %10011000 ;24 - 17
db %11110011 ;32 - 25
db %01000011 ;40 - 33
db %00111111 ;48 - 41
db %01111010 ;H6 - 49
db BANK(LugiaPicFront)
