SlugmaBaseStats: ; 384da (e:44da)
db DEX_SLUGMA ; pokedex id
db 40 ; base hp
db 40 ; base attack
db 40 ; base defense
db 20 ; base speed
db 70 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 190 ; catch rate
db 78 ; base exp yield
INCBIN "pic/bmon/slugma.pic",0,1 ; 55, sprite dimensions
dw SlugmaPicFront
dw SlugmaPicBack
; attacks known at lvl 0
db SMOG
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00000011
db %01100010
db %00001110
db %01111011
db %10001000
db %00000010
db BANK(SlugmaPicFront)
