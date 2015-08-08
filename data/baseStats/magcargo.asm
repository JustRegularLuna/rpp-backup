MagcargoBaseStats: ; 384da (e:44da)
db DEX_MAGCARGO ; pokedex id
db 50 ; base hp
db 50 ; base attack
db 120 ; base defense
db 30 ; base speed
db 80 ; base special
db FIRE ; species type 1
db ROCK ; species type 2
db 75 ; catch rate
db 154 ; base exp yield
INCBIN "pic/bmon/magcargo.pic",0,1 ; 55, sprite dimensions
dw MagcargoPicFront
dw MagcargoPicBack
; attacks known at lvl 0
db SMOG
db EMBER
db ROCK_THROW
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %01100010
db %00001110
db %01111011
db %10001000
db %00100010
db BANK(MagcargoPicFront)
