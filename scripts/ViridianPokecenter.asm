ViridianPokeCenterScript:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

ViridianPokecenterTextPointers:
	dw ViridianHealNurseText
	dw ViridianPokeCenterText2
	dw ViridianPokeCenterText3
	dw ViridianTradeNurseText
	dw ViridianCityPokecenterBenchGuyText

ViridianHealNurseText:
	TX_POKECENTER_NURSE

ViridianPokeCenterText2:
	TX_FAR _ViridianPokeCenterText2
	db "@"

ViridianPokeCenterText3:
	TX_FAR _ViridianPokeCenterText3
	db "@"

ViridianTradeNurseText:
	TX_CABLE_CLUB_RECEPTIONIST

; I don't want to risk issues from possible leftover IDs that don't use a constant
; so I added these dummy labels here to avoid shifting the tx_pre IDs in the middle
UnusedPokecenterBenchGuyText1:
UnusedPokecenterBenchGuyText2:
UnusedPokecenterBenchGuyText3:
ViridianCityPokecenterBenchGuyText:
	TX_FAR _ViridianCityPokecenterGuyText
	db "@"
