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
db %10110001 ;8  - 1
db %01000011 ;16 - 9
db %10001111 ;24 - 17
db %11111011 ;32 - 25
db %01011011 ;40 - 33
db %10101000 ;48 - 41
db %01100010 ;H6 - 49
db BANK(ElectivirePicFront)
