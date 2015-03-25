MismagiusBaseStats: ; 38aa6 (e:4aa6)
db DEX_MISMAGIUS ; pokedex id
db 60 ; base hp
db 60 ; base attack
db 60 ; base defense
db 105 ; base speed
db 105 ; base special
db GHOST ; species type 1
db GHOST ; species type 2
db 45 ; catch rate
db 187 ; base exp yield
INCBIN "pic/bmon/mismagius.pic",0,1 ; 55, sprite dimensions
dw MismagiusPicFront
dw MismagiusPicBack
; attacks known at lvl 0
db PSYWAVE
db GROWL
db HEX
db 0
db 3 ; growth rate
; learnset
db %10110001
db %00000011
db %00001111
db %11110000
db %10000111
db %00111001
db %01000011
db BANK(MismagiusPicFront)
