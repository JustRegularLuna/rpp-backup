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
db %11110001
db %11111111
db %10001111
db %11001111
db %10111010
db %10001000
db %00110010
db BANK(RhyperiorPicFront)
