BlisseyBaseStats: ; 3901e (e:501e)
db DEX_BLISSEY ; pokedex id
db 255 ; base hp
db 10 ; base attack
db 10 ; base defense
db 55 ; base speed
db 135 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 30 ; catch rate
db 255 ; base exp yield
INCBIN "pic/bmon/blissey.pic",0,1 ; 66, sprite dimensions
dw BlisseyPicFront
dw BlisseyPicBack
; attacks known at lvl 0
db DOUBLE_EDGE
db DEFENSE_CURL
db POUND
db GROWL
db 4 ; growth rate
; learnset
db %10110001 ;8  - 1
db %10111111 ;16 - 9
db %10101111 ;24 - 17
db %11100011 ;32 - 25
db %11111111 ;40 - 33
db %10111011 ;48 - 41
db %01100011 ;H6 - 49
db BANK(BlisseyPicFront)
