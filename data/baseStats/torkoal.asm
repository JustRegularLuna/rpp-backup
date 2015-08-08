TorkoalBaseStats: ; 384da (e:44da)
db DEX_TORKOAL ; pokedex id
db 70 ; base hp
db 85 ; base attack
db 140 ; base defense
db 20 ; base speed
db 85 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 90 ; catch rate
db 161 ; base exp yield
INCBIN "pic/bmon/torkoal.pic",0,1 ; 55, sprite dimensions
dw TorkoalPicFront
dw TorkoalPicBack
; attacks known at lvl 0
db EMBER
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110000
db %01000011
db %00101010
db %10001110
db %11111010
db %10001000
db %00100010
db BANK(TorkoalPicFront)
