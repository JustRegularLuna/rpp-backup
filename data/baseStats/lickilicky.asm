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
db %10100101 ;8  - 1
db %01111111 ;16 - 9
db %10101111 ;24 - 17
db %11001011 ;32 - 25
db %10111011 ;40 - 33
db %11001011 ;48 - 41
db %00110110 ;H6 - 49
db BANK(LickilickyPicFront)
