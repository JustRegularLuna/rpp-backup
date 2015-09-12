IgglybuffBaseStats: ; 38806 (e:4806)
db DEX_IGGLYBUFF ; pokedex id
db 90 ; base hp
db 30 ; base attack
db 15 ; base defense
db 15 ; base speed
db 40 ; base special
db NORMAL ; species type 1
db FAIRY ; species type 2
db 170 ; catch rate
db 76 ; base exp yield
INCBIN "pic/bmon/igglybuff.pic",0,1 ; 55, sprite dimensions
dw IgglybuffPicFront
dw IgglybuffPicBack
; attacks known at lvl 0
db SING
db BABYDOLLEYES
db 0
db 0
db 4 ; growth rate
; learnset
db %10110001
db %00111111
db %10101111
db %11110001
db %10110011
db %00111001
db %01100011
db BANK(IgglybuffPicFront)
