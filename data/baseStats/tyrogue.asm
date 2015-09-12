TyrogueBaseStats: ; 38f5a (e:4f5a)
db DEX_TYROGUE ; pokedex id
db 35 ; base hp
db 35 ; base attack
db 35 ; base defense
db 35 ; base speed
db 35 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 91 ; base exp yield
INCBIN "pic/bmon/tyrogue.pic",0,1 ; 77, sprite dimensions
dw TyroguePicFront
dw TyroguePicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %00001111
db %11000110
db %11001110
db %00001000
db %00100010
db BANK(TyroguePicFront)
