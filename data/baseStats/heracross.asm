HeracrossBaseStats: ; 391a6 (e:51a6)
db DEX_HERACROSS ; pokedex id
db 80 ; base hp
db 125 ; base attack
db 75 ; base defense
db 85 ; base speed
db 95 ; base special
db BUG ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
INCBIN "pic/bmon/heracross.pic",0,1 ; 77, sprite dimensions
dw HeracrossPicFront
dw HeracrossPicBack
; attacks known at lvl 0
db TACKLE
db LEER
db HORN_ATTACK
db 0
db 5 ; growth rate
; learnset
db %10100100
db %01000011
db %00001101
db %11000000
db %00000010
db %00001000
db %00100110
db BANK(HeracrossPicFront)
