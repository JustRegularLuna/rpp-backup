CleffaBaseStats: ; 38796 (e:4796)
db DEX_CLEFFA ; pokedex id
db 50 ; base hp
db 25 ; base attack
db 28 ; base defense
db 15 ; base speed
db 55 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 150 ; catch rate
db 68 ; base exp yield
INCBIN "pic/bmon/cleffa.pic",0,1 ; 55, sprite dimensions
dw CleffaPicFront
dw CleffaPicBack
; attacks known at lvl 0
db POUND
db BABYDOLLEYES
db 0
db 0
db 4 ; growth rate
; learnset
db %10110001
db %00111111
db %10101111
db %11110001
db %10110111
db %00111001
db %01100011
db BANK(CleffaPicFront)
