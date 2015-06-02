RhyperiorBaseStats: ; 39002 (e:5002)
db DEX_RHYPERIOR ; pokedex id
db 115 ; base hp
db 140 ; base attack
db 130 ; base defense
db 40 ; base speed
db 55 ; base special
db GROUND ; species type 1
db ROCK ; species type 2
db 30 ; catch rate
db 217 ; base exp yield
INCBIN "pic/bmon/rhyperior.pic",0,1 ; 77, sprite dimensions
dw RhyperiorPicFront
dw RhyperiorPicBack
; attacks known at lvl 0
db HORN_ATTACK
db STOMP
db TAIL_WHIP
db FURY_ATTACK
db 5 ; growth rate
; learnset
db %11110101 ;8  - 1
db %11111011 ;16 - 9
db %10001110 ;24 - 17
db %11001011 ;32 - 25
db %00111011 ;40 - 33
db %10001000 ;48 - 41
db %00110110 ;H6 - 49
db BANK(RhyperiorPicFront)
