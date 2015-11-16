BeachHouseScript: ; 1deed (7:5eed)
	jp EnableAutoTextBoxDrawing

BeachHouseTextPointers: ; 1def0 (7:5ef0)
	dw BeachHouseText1
	dw BeachHouseText2
	dw BeachHouseText3
	dw BeachHouseText4

BeachHouseText1:
	TX_FAR _Route2HouseText1 ; placeholder, eventually Surfing Pikachu tutor
	db "@"

BeachHouseText2:
	TX_FAR _BeachHousePikachuText
	db "@"

BeachHouseText3:
	TX_FAR _BeachHouseGirlText
	db "@"
	
BeachHouseText4:
	TX_FAR _BeachHouseOldManText
	db "@"
