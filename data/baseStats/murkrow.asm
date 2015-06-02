MurkrowBaseStats: ; 3860e (e:460e)
db DEX_MURKROW ; pokedex id
db 60 ; base hp
db 85 ; base attack
db 42 ; base defense
db 91 ; base speed
db 85 ; base special
db DARK ; species type 1
db FLYING ; species type 2
db 30 ; catch rate
db 81 ; base exp yield
INCBIN "pic/bmon/murkrow.pic",0,1 ; 55, sprite dimensions
dw MurkrowPicFront
dw MurkrowPicBack
; attacks known at lvl 0
db PECK
db GROWL
db 0
db 0
db 0 ; growth rate
; learnset
db %00101000 ;8  - 1
db %00000010 ;16 - 9
db %00001000 ;24 - 17
db %11010000 ;32 - 25
db %01000000 ;40 - 33
db %00011111 ;48 - 41
db %00001010 ;H6 - 49
db BANK(MurkrowPicFront)
