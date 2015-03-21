ElectivireBaseStats: ; 3916e (e:516e)
db DEX_ELECTIVIRE ; pokedex id
db 75 ; base hp
db 123 ; base attack
db 67 ; base defense
db 95 ; base speed
db 95 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 30 ; catch rate
db 199 ; base exp yield
INCBIN "pic/bmon/electivire.pic",0,1 ; 66, sprite dimensions
dw ElectivirePicFront
dw ElectivirePicBack
; attacks known at lvl 0
db QUICK_ATTACK
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01000011
db %10001111
db %11110001
db %11010111
db %00111000
db %01100010
db BANK(ElectivirePicFront)
