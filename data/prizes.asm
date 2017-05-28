PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries
	dw PrizeMenuMon1Cost

	dw PrizeMenuMon2Entries
	dw PrizeMenuMon2Cost

	dw PrizeMenuTMsEntries
	dw PrizeMenuTMsCost

NoThanksText:
	db "No thanks@"

PrizeMenuMon1Entries:
	db ABRA
	db CLEFAIRY
	db EEVEE
	db "@"

PrizeMenuMon1Cost:
	coins 180
	coins 500
	coins 1200
	db "@"

PrizeMenuMon2Entries:
	db HERACROSS
	db DRATINI
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
	coins 2500
	coins 4600
	coins 6500
	db "@"

PrizeMenuTMsEntries:
	db TM_37
	db TM_24
	db TM_13
	db "@"

PrizeMenuTMsCost:
	coins 3300
	coins 3300
	coins 3300
	db "@"
