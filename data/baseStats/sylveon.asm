SylveonBaseStats: ; 3926a (e:526a)
db DEX_SYLVEON ; pokedex id
db 95 ; base hp
db 65 ; base attack
db 65 ; base defense
db 60 ; base speed
db 130 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
INCBIN "pic/bmon/sylveon.pic",0,1 ; 66, sprite dimensions
dw SylveonPicFront
dw SylveonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000 ;8  - 1
db %01000011 ;16 - 9
db %00001000 ;24 - 17
db %11001000 ;32 - 25
db %11000011 ;40 - 33
db %00001001 ;48 - 41
db %01000010 ;H6 - 49
db BANK(SylveonPicFront)
