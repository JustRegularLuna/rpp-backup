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
db %00101010
db %00000011
db %00001000
db %11000000
db %01000010
db %00001100
db %00001010
db BANK(MurkrowPicFront)
