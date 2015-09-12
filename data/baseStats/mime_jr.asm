MimeJrBaseStats: ; 3911a (e:511a)
db DEX_MIME_JR ; pokedex id
db 20 ; base hp
db 25 ; base attack
db 45 ; base defense
db 60 ; base speed
db 90 ; base special
db PSYCHIC ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 136 ; base exp yield
INCBIN "pic/bmon/mime_jr.pic",0,1 ; 66, sprite dimensions
dw MimeJrPicFront
dw MimeJrPicBack
; attacks known at lvl 0
db TACKLE
db BARRIER
db CONFUSION
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01000011
db %10101111
db %11110001
db %10000111
db %00111001
db %01000010
db BANK(MimeJrPicFront)
