SmoochumBaseStats: ; 39152 (e:5152)
db DEX_SMOOCHUM ; pokedex id
db 45 ; base hp
db 30 ; base attack
db 15 ; base defense
db 65 ; base speed
db 85 ; base special
db ICE ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 137 ; base exp yield
INCBIN "pic/bmon/smoochum.pic",0,1 ; 66, sprite dimensions
dw SmoochumPicFront
dw SmoochumPicBack
; attacks known at lvl 0
db POUND
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01111111
db %00001111
db %11110000
db %10000111
db %00101001
db %00000010
db BANK(SmoochumPicFront)
