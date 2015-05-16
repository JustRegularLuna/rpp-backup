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
db %00100000
db %01000000
db %10011000
db %11010001
db %00000010
db %01101111
db %00000010
db BANK(MismagiusPicFront)
