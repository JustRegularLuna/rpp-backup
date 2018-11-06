RoofPalettes:
	dw PalletRoof
	dw ViridianRoof
	dw PewterRoof
	dw CeruleanRoof
	dw LavenderRoof
	dw VermilionRoof
	dw CeladonRoof
	dw FuchsiaRoof
	dw CinnabarRoof
	dw IndigoRoof
	dw SaffronRoof
	dw PalletRoof    ; unused map $0B
	dw PalletRoof    ; ROUTE_1
	dw ViridianRoof  ; ROUTE_2
	dw PewterRoof    ; ROUTE_3
	dw PewterRoof    ; ROUTE_4
	dw SaffronRoof   ; ROUTE_5
	dw VermilionRoof ; ROUTE_6 (hardcoded to use SaffronRoof for top 2 rows)
	dw SaffronRoof   ; ROUTE_7
	dw SaffronRoof   ; ROUTE_8
	dw LavenderRoof  ; ROUTE_9
	dw LavenderRoof  ; ROUTE_10
	dw VermilionRoof ; ROUTE_11
	dw VermilionRoof ; ROUTE_12
	dw FuchsiaRoof   ; ROUTE_13
	dw FuchsiaRoof   ; ROUTE_14
	dw FuchsiaRoof   ; ROUTE_15
	dw CeladonRoof   ; ROUTE_16
	dw CeladonRoof   ; ROUTE_17
	dw CeladonRoof   ; ROUTE_18
	dw FuchsiaRoof   ; ROUTE_19
	dw CinnabarRoof  ; ROUTE_20
	dw CinnabarRoof  ; ROUTE_21
	dw IndigoRoof    ; ROUTE_22
	dw IndigoRoof    ; ROUTE_23
	dw CeruleanRoof  ; ROUTE_24
	dw CeruleanRoof  ; ROUTE_25

PalletRoof:
	RGB 31,16,14
	RGB 25,10,08

ViridianRoof:
	RGB 00,29,07
	RGB 00,24,07

PewterRoof:
	RGB 19,19,16
	RGB 10,12,15

CeruleanRoof:
	RGB 17,27,31
	RGB 05,15,31

LavenderRoof:
	RGB 23,15,31
	RGB 16,05,31

VermilionRoof:
	RGB 27,23,01
	RGB 23,11,00

CeladonRoof:
	RGB 15,26,19
	RGB 03,20,11

FuchsiaRoof:
	RGB 31,18,29
	RGB 17,13,20

CinnabarRoof:
	RGB 31,08,08
	RGB 22,04,04

IndigoRoof:
	RGB 16,00,31
	RGB 10,00,25

SaffronRoof:
	RGB 31,26,00
	RGB 31,15,00
