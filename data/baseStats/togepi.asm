TogepiBaseStats: ; 38582 (e:4582)
db DEX_TOGEPI ; pokedex id
db 35 ; base hp
db 20 ; base attack
db 65 ; base defense
db 20 ; base speed
db 65 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 190 ; catch rate
db 74 ; base exp yield
INCBIN "pic/bmon/togepi.pic",0,1 ; 55, sprite dimensions
dw TogepiPicFront
dw TogepiPicBack
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
db BANK(TogepiPicFront)
