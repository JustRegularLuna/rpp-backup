LugiaBaseStats: ; 425b (1:425b)
db DEX_LUGIA ; pokedex id
db 100 ; base hp
db 100 ; base attack
db 100 ; base defense
db 100 ; base speed
db 100 ; base special
db PSYCHIC ; species type 1
db FLYING  ; species type 2
db 45 ; catch rate
db 64 ; base exp yield
db $77 ; sprite dimensions
dw LugiaPicFront
dw LugiaPicBack
; attacks known at lvl 0
db WATER_GUN
db SKY_ATTACK
db 0
db 0
db 3 ; growth rate
; include learnset directly
db %11111111
db %11111111
db %11111111
db %11111111
db %11111111
db %11111111
db %11111111
db BANK(LugiaPicFront)
