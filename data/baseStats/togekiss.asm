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
db %10110000 ;8  - 1
db %11001111 ;16 - 9
db %00101110 ;24 - 17
db %11010000 ;32 - 25
db %11110111 ;40 - 33
db %00011111 ;48 - 41
db %01001010 ;H6 - 49
db BANK(TogekissPicFront)
