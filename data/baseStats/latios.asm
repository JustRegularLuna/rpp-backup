LatiosBaseStats: ; 425b (1:425b)
db DEX_LATIOS ; pokedex id
db 80 ; base hp
db 90 ; base attack
db 80 ; base defense
db 110 ; base speed
db 130 ; base special
db DRAGON ; species type 1
db PSYCHIC  ; species type 2
db 45 ; catch rate
db 211 ; base exp yield
INCBIN "pic/bmon/latios.pic",0,1 ; 77, sprite dimensions
dw LatiosPicFront
dw LatiosPicBack
; attacks known at lvl 0
db ZEN_HEADBUTT
db DRAGONBREATH
db LUSTER_PURGE
db 0
db 3 ; growth rate
; include learnset directly
db %10101000 ;8  - 1
db %01111110 ;16 - 9
db %10011000 ;24 - 17
db %11110011 ;32 - 25
db %01000011 ;40 - 33
db %00111111 ;48 - 41
db %01111010 ;H6 - 49
db BANK(LatiosPicFront)
