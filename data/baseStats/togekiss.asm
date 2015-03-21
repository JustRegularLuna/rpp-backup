TogekissBaseStats: ; 38582 (e:4582)
db DEX_TOGEKISS ; pokedex id
db 85 ; base hp
db 50 ; base attack
db 95 ; base defense
db 80 ; base speed
db 120 ; base special
db FAIRY ; species type 1
db FLYING ; species type 2
db 30 ; catch rate
db 220 ; base exp yield
INCBIN "pic/bmon/togekiss.pic",0,1 ; 55, sprite dimensions
dw TogekissPicFront
dw TogekissPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10110001
db %00111111
db %10101111
db %11110001
db %10110111
db %00111001
db %01100011
db BANK(TogekissPicFront)
