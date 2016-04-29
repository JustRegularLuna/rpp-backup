TreeMonPointerTable:
	dw TreeMons1  ; PALLET_TOWN
	dw TreeMons1  ; VIRIDIAN_CITY
	dw TreeMons2  ; PEWTER_CITY
	dw TreeMons2  ; CERULEAN_CITY
	dw TreeMons4  ; LAVENDER_TOWN
	dw TreeMons3  ; VERMILION_CITY
	dw TreeMons4  ; CELADON_CITY
	dw TreeMons5  ; FUCHSIA_CITY
	dw TreeMons7  ; CINNABAR_ISLAND
	dw TreeMons7  ; INDIGO_PLATEAU
	dw TreeMons4  ; SAFFRON_CITY
	dw TreeMons1  ; unused map
	dw TreeMons1  ; ROUTE_1
	dw TreeMons1  ; ROUTE_2
	dw TreeMons2  ; ROUTE_3
	dw TreeMons2  ; ROUTE_4
	dw TreeMons3  ; ROUTE_5
	dw TreeMons3  ; ROUTE_6
	dw TreeMons4  ; ROUTE_7
	dw TreeMons4  ; ROUTE_8
	dw TreeMons4  ; ROUTE_9
	dw TreeMons3  ; ROUTE_10
	dw TreeMons3  ; ROUTE_11
	dw TreeMons5  ; ROUTE_12
	dw TreeMons5  ; ROUTE_13
	dw TreeMons5  ; ROUTE_14
	dw TreeMons5  ; ROUTE_15
	dw TreeMons4  ; ROUTE_16
	dw TreeMons5  ; ROUTE_17
	dw TreeMons6  ; ROUTE_18
	dw TreeMons6  ; ROUTE_19
	dw TreeMons7  ; ROUTE_20
	dw TreeMons7  ; ROUTE_21
	dw TreeMons1  ; ROUTE_22
	dw TreeMons7  ; ROUTE_23
	dw TreeMons2  ; ROUTE_24
	dw TreeMons2  ; ROUTE_25
	; Any map not in this list defaults to TreeMons1

TreeMons1:
	db 10, CATERPIE
	db 10, CATERPIE
	db 10, WEEDLE
	db 10, WEEDLE
	db 10, KAKUNA
	db 10, METAPOD
	db 10, PARAS
	db 10, SPEAROW
	db 10, BEEDRILL
	db 10, BUTTERFREE

TreeMons2:
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, SPEAROW
	db 10, SPEAROW
	db 10, VENONAT
	db 10, VENONAT
	db 10, EKANS
	db 10, EKANS
	db 10, MURKROW
	db 10, MURKROW

TreeMons3:
	db 15, VENONAT
	db 15, VENONAT
	db 15, PARAS
	db 15, PARAS
	db 15, SPEAROW
	db 15, SPEAROW
	db 15, EKANS
	db 15, EKANS
	db 15, EXEGGCUTE
	db 15, EXEGGCUTE

TreeMons4:
	db 15, EKANS
	db 15, EKANS
	db 15, EKANS
	db 15, SPEAROW
	db 15, SPEAROW
	db 15, SPEAROW
	db 15, EXEGGCUTE
	db 15, EXEGGCUTE
	db 15, HERACROSS
	db 15, HERACROSS

TreeMons5:
	db 25, PARAS
	db 25, PARAS
	db 25, VENONAT
	db 25, VENONAT
	db 25, BEEDRILL
	db 25, BUTTERFREE
	db 25, MURKROW
	db 25, MURKROW
	db 25, HERACROSS
	db 25, SCYTHER

TreeMons6:
	db 25, PARAS
	db 25, PARAS
	db 25, VENONAT
	db 25, VENONAT
	db 25, BEEDRILL
	db 25, BUTTERFREE
	db 25, MURKROW
	db 25, MURKROW
	db 25, HERACROSS
	db 25, PINSIR

TreeMons7:
	db 30, BEEDRILL
	db 30, BUTTERFREE
	db 30, TANGELA
	db 30, TANGELA
	db 30, VENONAT
	db 31, VENOMOTH
	db 31, EXEGGCUTE
	db 31, EXEGGCUTE
	db 31, ARBOK
	db 31, HERACROSS

TreeMons8: ; unused for now
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY

TreeMons9: ; unused for now
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY

TreeMons10: ; unused for now
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY

TreeMons11: ; unused for now
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY

TreeMons12: ; unused for now
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
	db 10, PIDGEY
