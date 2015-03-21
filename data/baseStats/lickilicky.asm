LickilickyBaseStats: ; 38f92 (e:4f92)
db DEX_LICKILICKY ; pokedex id
db 110 ; base hp
db 85 ; base attack
db 95 ; base defense
db 50 ; base speed
db 95 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 30 ; catch rate
db 193 ; base exp yield
INCBIN "pic/bmon/lickilicky.pic",0,1 ; 77, sprite dimensions
dw LickilickyPicFront
dw LickilickyPicBack
; attacks known at lvl 0
db LICK
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110101
db %01111111
db %10001111
db %11000111
db %10111010
db %00001001
db %00110110
db BANK(LickilickyPicFront)
