VermilionDockObject:
	db $f ; border block

	db $2 ; warps
	db $0, $e, $5, $ff
	db $2, $e, $1, SS_ANNE_1

	db $2 ; signs
	db $0, $14, $1
	db $0, $15, $2

	db $0 ; objects

	; warp-to
	EVENT_DISP VERMILION_DOCK_WIDTH, $0, $e
	EVENT_DISP VERMILION_DOCK_WIDTH, $2, $e ; SS_ANNE_1
