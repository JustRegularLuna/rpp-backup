
INCLUDE "constants.asm"

flag_array: MACRO
	ds ((\1) + 7) / 8
ENDM

box_struct_length EQU 25 + NUM_MOVES * 2
box_struct: MACRO
\1Species::    db
\1HP::         dw
\1BoxLevel::   db
\1Status::     db
\1Type::
\1Type1::      db
\1Type2::      db
\1CatchRate::  db
\1Moves::      ds NUM_MOVES
\1OTID::       dw
\1Exp::        ds 3
\1HPExp::      dw
\1AttackExp::  dw
\1DefenseExp:: dw
\1SpeedExp::   dw
\1SpecialExp:: dw
\1DVs::        ds 2
\1PP::         ds NUM_MOVES
ENDM

party_struct: MACRO
	box_struct \1
\1Level::      db
\1Stats::
\1MaxHP::      dw
\1Attack::     dw
\1Defense::    dw
\1Speed::      dw
\1Special::    dw
ENDM

battle_struct: MACRO
\1Species::    db
\1HP::         dw
\1BoxLevel::   db
\1Status::     db
\1Type::
\1Type1::      db
\1Type2::      db
\1CatchRate::  db
\1Moves::      ds NUM_MOVES
\1DVs::        ds 2
\1Level::      db
\1MaxHP::      dw
\1Attack::     dw
\1Defense::    dw
\1Speed::      dw
\1Special::    dw
\1PP::         ds NUM_MOVES
ENDM


SECTION "WRAM Bank 0", WRAM0

wc000:: ds 1
wc001:: ds 1
wc002:: ds 1
wc003:: ds 1
wc004:: ds 1
wc005:: ds 1
wc006:: ds 8
wc00e:: ds 4
wc012:: ds 4
wc016:: ds 16
wc026:: ds 1
wc027:: ds 1
wc028:: ds 2
wc02a:: ds 1
wc02b:: ds 1
wc02c:: ds 1
wc02d:: ds 1
wc02e:: ds 8
wc036:: ds 8
wc03e:: ds 8
wc046:: ds 8
wc04e:: ds 8
wc056:: ds 8
wc05e:: ds 8
wc066:: ds 8
wc06e:: ds 8
wc076:: ds 8
wc07e:: ds 8
wc086:: ds 8
wc08e:: ds 8
wc096:: ds 8
wc09e:: ds 8
wc0a6:: ds 8
wc0ae:: ds 8
wc0b6:: ds 8
wc0be:: ds 8
wc0c6:: ds 8
wc0ce:: ds 1
wc0cf:: ds 1
wc0d0:: ds 1
wc0d1:: ds 1
wc0d2:: ds 1
wc0d3:: ds 1
wc0d4:: ds 1
wc0d5:: ds 1
wc0d6:: ds 8
wc0de:: ds 8
wc0e6:: ds 1
wc0e7:: ds 1
wc0e8:: ds 1
wc0e9:: ds 1
wc0ea:: ds 1
wc0eb:: ds 1
wc0ec:: ds 1
wc0ed:: ds 1
wc0ee:: ds 1
wc0ef:: ds 1
wc0f0:: ds 1
wc0f1:: ds 1
wc0f2:: ds 14


SECTION "Sprite State Data", WRAM0[$c100]

wSpriteDataStart::

wSpriteStateData1:: ; c100
; data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
; player sprite is always sprite 0
; C1x0: picture ID (fixed, loaded at map init)
; C1x1: movement status (0: uninitialized, 1: ready, 2: delayed, 3: moving)
; C1x2: sprite image index (changed on update, $ff if off screen, includes facing direction, progress in walking animation and a sprite-specific offset)
; C1x3: Y screen position delta (-1,0 or 1; added to c1x4 on each walking animation update)
; C1x4: Y screen position (in pixels, always 4 pixels above grid which makes sprites appear to be in the center of a tile)
; C1x5: X screen position delta (-1,0 or 1; added to c1x6 on each walking animation update)
; C1x6: X screen position (in pixels, snaps to grid if not currently walking)
; C1x7: intra-animation-frame counter (counting upwards to 4 until c1x8 is incremented)
; C1x8: animation frame counter (increased every 4 updates, hold four states (totalling to 16 walking frames)
; C1x9: facing direction (0: down, 4: up, 8: left, $c: right)
; C1xA
; C1xB
; C1xC
; C1xD
; C1xE
; C1xF
spritestatedata1: MACRO
\1SpriteStateData1::
\1PictureID:: db
\1MovementStatus:: db
\1SpriteImageIdx:: db
\1YStepVector:: db
\1YPixels:: db
\1XStepVector:: db
\1XPixels:: db
\1IntraAnimFrameCounter:: db
\1AnimFrameCounter:: db
\1FacingDirection:: db
	ds 6
\1SpriteStateData1End::
endm

	spritestatedata1 Player
	spritestatedata1 Sprite01
	spritestatedata1 Sprite02
	spritestatedata1 Sprite03
	spritestatedata1 Sprite04
	spritestatedata1 Sprite05
	spritestatedata1 Sprite06
	spritestatedata1 Sprite07
	spritestatedata1 Sprite08
	spritestatedata1 Sprite09
	spritestatedata1 Sprite10
	spritestatedata1 Sprite11
	spritestatedata1 Sprite12
	spritestatedata1 Sprite13
	spritestatedata1 Sprite14
	spritestatedata1 Sprite15
	; ds $10 * $10


;SECTION "Sprite State Data 2", WRAM0[$c200]

wSpriteStateData2:: ; c200
; more data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
; player sprite is always sprite 0
; C2x0: walk animation counter (counting from $10 backwards when moving)
; C2x1:
; C2x2: Y displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; C2x3: X displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; C2x4: Y position (in 2x2 tile grid steps, topmost 2x2 tile has value 4)
; C2x5: X position (in 2x2 tile grid steps, leftmost 2x2 tile has value 4)
; C2x6: movement byte 1 (determines whether a sprite can move, $ff:not moving, $fe:random movements, others unknown)
; C2x7: (?) (set to $80 when in grass, else $0; may be used to draw grass above the sprite)
; C2x8: delay until next movement (counted downwards, status (c1x1) is set to ready if reached 0)
; C2x9
; C2xA
; C2xB
; C2xC
; C2xD
; C2xE: sprite image base offset (in video ram, player always has value 1, used to compute c1x2)
; C2xF
spritestatedata2: MACRO
\1SpriteStateData2::
\1WalkAnimationCounter:: db
	ds 1
\1YDisplacement:: db
\1XDisplacement:: db
\1MapY:: db
\1MapX:: db
\1MovementByte1:: db
\1GrassPriority:: db
\1MovementDelay:: db
	ds 5
\1SpriteImageBaseOffset:: db
	ds 1
\1SpriteStateData2End::
endm

	spritestatedata2 Player
	spritestatedata2 Sprite01
	spritestatedata2 Sprite02
	spritestatedata2 Sprite03
	spritestatedata2 Sprite04
	spritestatedata2 Sprite05
	spritestatedata2 Sprite06
	spritestatedata2 Sprite07
	spritestatedata2 Sprite08
	spritestatedata2 Sprite09
	spritestatedata2 Sprite10
	spritestatedata2 Sprite11
	spritestatedata2 Sprite12
	spritestatedata2 Sprite13
	spritestatedata2 Sprite14
	spritestatedata2 Sprite15
	; ds $10 * $10

wSpriteDataEnd::

SECTION "OAM Buffer", WRAM0[$c300]

wOAMBuffer:: ; c300
; buffer for OAM data. Copied to OAM by DMA
	ds 4 * 40

wTileMap:: ; c3a0
; buffer for tiles that are visible on screen (20 columns by 18 rows)
	ds 20 * 18

wSerialPartyMonsPatchList:: ; c508
; list of indexes to patch with SERIAL_NO_DATA_BYTE after transfer

wTileMapBackup:: ; c508
; buffer for temporarily saving and restoring current screen's tiles
; (e.g. if menus are drawn on top)
;	ds 20 * 18

	ds 200

wSerialEnemyMonsPatchList:: ; c5d0
; list of indexes to patch with SERIAL_NO_DATA_BYTE after transfer
	ds 200

	ds 80

wTempLevel::
wTempDVs::
W_AIBUFFER1::
wTempMoveID::
wTempPic::
wOverworldMap:: ; c6e8
	ds 1300

wScreenEdgeTiles:: ; cbfc
; the tiles of the row or column to be redrawn by RedrawExposedScreenEdge
	ds 20 * 2

; coordinates of the position of the cursor for the top menu item (id 0)
wTopMenuItemY:: ; cc24
	ds 1
wTopMenuItemX:: ; cc25
	ds 1

wCurrentMenuItem:: ; cc26
; the id of the currently selected menu item
; the top item has id 0, the one below that has id 1, etc.
; note that the "top item" means the top item currently visible on the screen
; add this value to [wListScrollOffset] to get the item's position within the list
	ds 1

wTileBehindCursor:: ; cc27
; the tile that was behind the menu cursor's current location
	ds 1

wMaxMenuItem:: ; cc28
; id of the bottom menu item
	ds 1

wMenuWatchedKeys:: ; cc29
; bit mask of keys that the menu will respond to
	ds 1

wLastMenuItem:: ; cc2a
; id of previously selected menu item
	ds 1

wPartyAndBillsPCSavedMenuItem:: ; cc2b
; It is mainly used by the party menu to remember the cursor position while the
; menu isn't active.
; It is also used to remember the cursor position of mon lists (for the
; withdraw/deposit/release actions) in Bill's PC so that it doesn't get lost
; when you choose a mon from the list and a sub-menu is shown. It's reset when
; you return to the main Bill's PC menu.
	ds 1

wBagSavedMenuItem:: ; cc2c
; It is used by the bag list to remember the cursor position while the menu
; isn't active.
	ds 1

wBattleAndStartSavedMenuItem:: ; cc2d
; It is used by the start menu to remember the cursor position while the menu
; isn't active.
; The battle menu uses it so that the cursor position doesn't get lost when
; a sub-menu is shown. It's reset at the start of each battle.
	ds 1

wPlayerMoveListIndex:: ; cc2e
	ds 1

wPlayerMonNumber:: ; cc2f
; index in party of currently battling mon
	ds 1

wMenuCursorLocation:: ; cc30
; the address of the menu cursor's current location within wTileMap
	ds 2

; unused?
	ds 2

wMenuJoypadPollCount:: ; cc34
; how many times should HandleMenuInput poll the joypad state before it returns?
	ds 1

wMenuItemToSwap:: ; cc35
; id of menu item selected for swapping (counts from 1) (0 means that no menu item has been selected for swapping)
	ds 1

wListScrollOffset:: ; cc36
; offset of the current top menu item from the beginning of the list
; keeps track of what section of the list is on screen
	ds 1

wMenuWatchMovingOutOfBounds:: ; cc37
; If non-zero, then when wrapping is disabled and the player tries to go past
; the top or bottom of the menu, return from HandleMenuInput. This is useful for
; menus that have too many items to display at once on the screen because it
; allows the caller to scroll the entire menu up or down when this happens.
	ds 1

wTradeCenterPointerTableIndex:: ; cc38
	ds 1

; unused?
	ds 1

; group these two together
wcc3a:: ds 1 ; both used in home/text.asm
wcc3b:: ds 1

wDoNotWaitForButtonPressAfterDisplayingText:: ; cc3c
; if non-zero, skip waiting for a button press after displaying text in DisplayTextID
	ds 1

wSerialSyncAndExchangeNybbleReceiveData:: ; cc3d
; the final received nybble is stored here by Serial_SyncAndExchangeNybble

wSerialExchangeNybbleTempReceiveData:: ; cc3d
; temporary nybble used by Serial_ExchangeNybble

wLinkMenuSelectionReceiveBuffer:: ; cc3d
; two byte buffer
; the received menu selection is stored twice

wcc3d:: ds 1 ; not used for anything other than mentioned above (haha link function)

wSerialExchangeNybbleReceiveData:: ; cc3e
; the final received nybble is stored here by Serial_ExchangeNybble
	ds 1

; unused?
	ds 3

wSerialExchangeNybbleSendData:: ; cc42
; this nybble is sent when using Serial_SyncAndExchangeNybble or Serial_ExchangeNybble

wLinkMenuSelectionSendBuffer:: ; cc42
; two byte buffer
; the menu selection byte is stored twice before sending

	ds 5

wLinkTimeoutCounter:: ; cc47
; 1 byte

wUnknownSerialCounter:: ; cc47
; 2 bytes

wcc47:: ds 1 ; used in text id stuff
wcc48:: ds 1 ; part of wUnknownSerialCounter

wWhichTradeMonSelectionMenu:: ; cc49
; $00 = player mons
; $01 = enemy mons

wMonDataLocation:: ; cc49
; 0 = player's party
; 1 = enemy party
; 2 = current box
; 3 = daycare
; 4 = in-battle mon
;
; AddPartyMon uses it slightly differently.
; If the lower nybble is 0, the mon is added to the player's party, else the enemy's.
; If the entire value is 0, then the player is allowed to name the mon.
	ds 1

wMenuWrappingEnabled:: ; cc4a
; set to 1 if you can go from the bottom to the top or top to bottom of a menu
; set to 0 if you can't go past the top or bottom of the menu
	ds 1

wcc4b:: ds 2 ; used as a joypad storage value
wcc4d:: ds 1 ; used in sprite hiding/showing related operations

wPredefID:: ; cc4e
	ds 1
wPredefRegisters:: ; cc4f
	ds 6

wTrainerHeaderFlagBit:: ; probably removable once I switch to Gen 2 style event flags
	ds 1

; unused?
	ds 1

wNPCMovementScriptPointerTableNum:: ; cc57
; which NPC movement script pointer is being used
; 0 if an NPC movement script is not running
	ds 1

wNPCMovementScriptBank:: ; cc58
; ROM bank of current NPC movement script
	ds 1

; unused?
	ds 2

wSlotMachineSevenAndBarModeChance:: ; cc5b
; If a random number greater than this value is generated, then the player is
; allowed to have three 7 symbols or bar symbols line up.
; So, this value is actually the chance of NOT entering that mode.
; If the slot is lucky, it equals 250, giving a 5/256 (~2%) chance.
; Otherwise, it equals 253, giving a 2/256 (~0.8%) chance.

wHallOfFame:: ; cc5b
wBoostExpByExpAll:: ; cc5b
wAnimationType:: ; cc5b
; values between 0-6. Shake screen horizontally, shake screen vertically, blink Pokemon...

wNPCMovementDirections:: ; cc5b

wcc5b:: ds 1 ; these upcoming values below are miscellaneous storage values
wcc5c:: ds 1 ; used in pokedex evaluation as well
wcc5d:: ds 1 ; used in pokedex evaluation

wSlotMachineSavedROMBank:: ; cc5e
; ROM back to return to when the player is done with the slot machine
	ds 1

	ds 12

wcc6b:: ds 14 ; doesn't seem to be used for anything, probably just more storage
wcc79:: ds 30 ; used in battle animations

wNPCMovementDirections2:: ; cc97

wSwitchPartyMonTempBuffer:: ; cc97
; temporary buffer when swapping party mon data
wEnemyWentFirst::
; 1 = enemy mon attacked before player mon in battle
; 0 = player mon attacked before enemy mon in battle
wShinyMonFlag::
; Bit 0 is set if the mon should be Shiny.
; Bit 1 is set for enemy mon animation, reset for player mon animation
wRelearnableMoves::
; List of move ids that can be re-learend (Move Relearner)
; First byte is the number of moves in this list.
; List is terminated with $ff
wDeletableMoves::
; List of move ids that can be deleted (Move Deleter)
; First byte is the number of moves in this list.
; List is terminated with $ff
	ds 1
wGenderTemp::
; temporary buffer used when checking/displaying a Pokemon's gender
	ds 9

wNumStepsToTake:: ; cca1
; used in Pallet Town scripted movement
	ds 49

wRLEByteCount:: ; ccd2
	ds 1

wSimulatedJoypadStatesEnd:: ; ccd3
; this is the end of the joypad states
; the list starts above this address and extends downwards in memory until here
; overloaded with below labels

wParentMenuItem:: ; ccd3

wccd3:: ds 1 ; used in battle, pokemon, PC and game corner stuff
wForceEvolution::
wccd4:: ds 1 ; has a direct reference for simulated joypad stuff in vermillion and seafoam

; if [ccd5] != 1, the second AI layer is not applied
wAILayer2Encouragement:: ; ccd5
	ds 1
	ds 1

; current HP of player and enemy substitutes
wPlayerSubstituteHP:: ; ccd7
	ds 1
wEnemySubstituteHP:: ; ccd8
	ds 1

wccd9:: ds 2 ; used in InitBattleVariablesLoop (written to after the loop is finished)

wMoveMenuType:: ; ccdb
; 0=regular, 1=mimic, 2=above message box (relearn, heal pp..)
	ds 1

wPlayerSelectedMove:: ; ccdc
	ds 1
wEnemySelectedMove:: ; ccdd
	ds 1

wLinkBattleRandomNumberListIndex:: ; ccde
	ds 1

wAICount:: ; ccdf
; number of times remaining that AI action can occur
	ds 1

; unused?
	ds 2

wEnemyMoveListIndex:: ; cce2
	ds 1

wcce3:: ds 1 ; used in battle-related text functions
wcce4:: ds 1 ; used in battle-related text functions

wTotalPayDayMoney:: ; cce5
; total amount of money made using Pay Day during the current battle
	ds 3

wSafariEscapeFactor:: ; cce8
	ds 1
wSafariBaitFactor:: ; cce9
	ds 1;

; unused?
	ds 1

wcceb:: ds 1 ; used to save the dvs of a mon when it uses transform
wccec:: ds 1 ; also used with above case

wMonIsDisobedient:: ds 1 ; cced

wPlayerDisabledMoveNumber:: ds 1 ; ccee
wEnemyDisabledMoveNumber:: ds 1 ; ccef

wccf0:: ds 1 ; used as a check if a mon fainted

wPlayerUsedMove:: ds 1 ; ccf1
wEnemyUsedMove:: ds 1 ; ccf2

wEnemyMonMinimized:: ds 1 ; ccf3

wMoveDidntMiss:: ds 1 ; ccf4

wPartyFoughtCurrentEnemyFlags:: ; ccf5
; flags that indicate which party members have fought the current enemy mon
	flag_array 6

wccf6:: ds 1 ; used in some hp bar thing
wPlayerMonMinimized:: ds 1 ; ccf7

	ds 13

wLuckySlotHiddenObjectIndex:: ; cd05

wEnemyNumHits:: ; cd05
; number of hits by enemy in attacks like Double Slap, etc.

wEnemyBideAccumulatedDamage:: ; cd05
; the amount of damage accumulated by the enemy while biding (2 bytes)
	ds 2

; unused?
	ds 8

wInGameTradeGiveMonSpecies:: ; cd0f

wPlayerMonUnmodifiedLevel:: ; cd0f
	ds 1

wInGameTradeTextPointerTablePointer:: ; cd10

wPlayerMonUnmodifiedMaxHP:: ; cd10
	ds 2

wInGameTradeTextPointerTableIndex:: ; cd12

wPlayerMonUnmodifiedAttack:: ; cd12
	ds 1
wInGameTradeGiveMonName:: ; cd13
	ds 1
wPlayerMonUnmodifiedDefense:: ; cd14
	ds 2
wPlayerMonUnmodifiedSpeed:: ; cd16
	ds 2
wPlayerMonUnmodifiedSpecial:: ; cd18
	ds 2

; stat modifiers for the player's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal

wPlayerMonStatMods::
wPlayerMonAttackMod:: ; cd1a
	ds 1
wPlayerMonDefenseMod:: ; cd1b
	ds 1
wPlayerMonSpeedMod:: ; cd1c
	ds 1
wPlayerMonSpecialMod:: ; cd1d
	ds 1

wInGameTradeReceiveMonName:: ; cd1e

wPlayerMonAccuracyMod:: ; cd1e
	ds 1
wPlayerMonEvasionMod:: ; cd1f
	ds 1

; unused?
	ds 3

wEnemyMonUnmodifiedLevel:: ; cd23
	ds 1
wEnemyMonUnmodifiedMaxHP:: ; cd24
	ds 2
wEnemyMonUnmodifiedAttack:: ; cd26
	ds 2
wEnemyMonUnmodifiedDefense:: ; cd28
	ds 1

wInGameTradeMonNick:: ; cd29
	ds 1

wEnemyMonUnmodifiedSpeed:: ; cd2a
	ds 2
wEnemyMonUnmodifiedSpecial:: ; cd2c
	ds 1

wEngagedTrainerClass:: ; cd2d
	ds 1
wEngagedTrainerSet:: ; cd2e
;	ds 1

; stat modifiers for the enemy's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal

wEnemyMonStatMods::
wEnemyMonAttackMod:: ; cd2e
	ds 1
wEnemyMonDefenseMod:: ; cd2f
	ds 1
wEnemyMonSpeedMod:: ; cd30
	ds 1
wEnemyMonSpecialMod:: ; cd31
	ds 1
wEnemyMonAccuracyMod:: ; cd32
	ds 1
wEnemyMonEvasionMod:: ; cd33
	ds 1

wInGameTradeReceiveMonSpecies::
	ds 1

; unused?
	ds 2

wNPCMovementDirections2Index:: ; cd37

wcd37:: ds 1 ; used in list menus, like the fossil lab menu or drink girl menu. Also used in link menu.

wSimulatedJoypadStatesIndex:: ; cd38
; the next simulated joypad state is at wSimulatedJoypadStatesEnd plus this value minus 1
; 0 if the joypad state is not being simulated
	ds 1

wWastedByteCD39:: ; cd39
; written to but nothing ever reads it
	ds 1

wWastedByteCD3A:: ; cd3a
; written to but nothing ever reads it
	ds 1

wOverrideSimulatedJoypadStatesMask:: ; cd3b
; mask indicating which real button presses can override simulated ones
; XXX is it ever not 0?
	ds 1

; unused?
	ds 1

wTitleMonSpecies:: ; cd3d

wPlayerCharacterOAMTile:: ; cd3d

wMoveDownSmallStarsOAMCount:: ; cd3d
; the number of small stars OAM entries to move down

wChargeMoveNum:: ; cd3d

wCoordIndex:: ; cd3d

wOptionsTextSpeedCursorX:: ; cd3d

wBoxNumString:: ; cd3d

wTrainerInfoTextBoxWidthPlus1:: ; cd3d

wSwappedMenuItem:: ; cd3d

wHoFMonSpecies:: ; cd3d

wFieldMoves:: ; cd3d
; 4 bytes
; the current mon's field moves

wBadgeNumberTile:: ; cd3d
; tile ID of the badge number being drawn

wRodResponse:: ; cd3d
; 0 = no bite
; 1 = bite
; 2 = no fish on map

wWhichTownMapLocation:: ; cd3d

wStoppingWhichSlotMachineWheel:: ; cd3d
; which wheel the player is trying to stop
; 0 = none, 1 = wheel 1, 2 = wheel 2, 3 or greater = wheel 3

wTradedPlayerMonSpecies:: ; cd3d

wTradingWhichPlayerMon:: ; cd3d

wChangeBoxSavedMapTextPointer:: ; cd3d

wFlyAnimUsingCoordList:: ; cd3d

wPlayerSpinInPlaceAnimFrameDelay:: ; cd3d

wPlayerSpinWhileMovingUpOrDownAnimDeltaY:: ; cd3d

wHiddenObjectFunctionArgument:: ; cd3d

wSubtrahend:: ; cd3d
; subtract (BCD) wSubtrahend, wSubtrahend+1, wSubtrahend+2

wWhichTrade:: ; cd3d
; which entry from TradeMons to select

wTrainerSpriteOffset:: ; cd3d
	ds 1

wOptionsBattleAnimCursorX:: ; cd3e

wTrainerInfoTextBoxWidth:: ; cd3e

wHoFPartyMonIndex:: ; cd3e

wNumCreditsMonsDisplayed:: ; cd3e
; the number of credits mons that have been displayed so far

wBadgeNameTile:: ; cd3e
; first tile ID of the name being drawn

wFlyLocationsList:: ; cd3e
; 11 bytes plus $ff sentinel values at each end

wSlotMachineWheel1Offset:: ; cd3e

wTradedEnemyMonSpecies:: ; cd3e

wTradingWhichEnemyMon:: ; cd3e

wFlyAnimCounter:: ; cd3e

wPlayerSpinInPlaceAnimFrameDelayDelta:: ; cd3e

wPlayerSpinWhileMovingUpOrDownAnimMaxY:: ; cd3e

wHiddenObjectFunctionRomBank:: ; cd3e

wTrainerEngageDistance:: ; cd3e
	ds 1

wOptionsBattleStyleCursorX:: ; cd3f

wTrainerInfoTextBoxNextRowOffset:: ; cd3f

wHoFMonLevel:: ; cd3f

wBadgeOrFaceTiles:: ; cd3f
; 8 bytes
; a list of the first tile IDs of each badge or face (depending on whether the
; badge is owned) to be drawn on the trainer screen

wSlotMachineWheel2Offset:: ; cd3f

wNameOfPlayerMonToBeTraded:: ; cd3f

wFlyAnimBirdSpriteImageIndex:: ; cd3f

wPlayerSpinInPlaceAnimFrameDelayEndValue:: ; cd3f

wPlayerSpinWhileMovingUpOrDownAnimFrameDelay:: ; cd3f

wHiddenObjectIndex:: ; cd3f

wTrainerFacingDirection:: ; cd3f
wcd3f:: ; used with daycare text for money amount
	ds 1

wHoFMonOrPlayer:: ; cd40
; show mon or show player?
; 0 = mon
; 1 = player

wSlotMachineWheel3Offset:: ; cd40

wPlayerSpinInPlaceAnimSoundID:: ; cd40

wHiddenObjectY:: ; cd40

wTrainerScreenY:: ; cd40
	ds 1

wTradedPlayerMonOT:: ; cd41

wHiddenObjectX:: ; cd41

wSlotMachineWinningSymbol:: ; cd41
; the OAM tile number of the upper left corner of the winning symbol minus 2

wNumFieldMoves:: ; cd41

wSlotMachineWheel1BottomTile:: ; cd41

wTrainerScreenX:: ; cd41
	ds 1
; a lot of the uses for these values use more than the said address

wHoFTeamNo:: ; cd42

wSlotMachineWheel1MiddleTile:: ; cd42

wFieldMovesLeftmostXCoord:: ; cd42

wcd42:: ds 1 ; used in pewter center script, printing field mon moves, slot machines and HoF PC

wLastFieldMoveID:: ; cd43
; unused

wSlotMachineWheel1TopTile:: ; cd43
	ds 1

wSlotMachineWheel2BottomTile:: ; cd44
	ds 1

wSlotMachineWheel2MiddleTile:: ; cd45
	ds 1

wTempCoins1:: ; cd46
; 2 bytes
; temporary variable used to add payout amount to the player's coins

wSlotMachineWheel2TopTile:: ; cd46
	ds 1

wBattleTransitionSpiralDirection:: ; cd47
; 0 = outward, 1 = inward

wSlotMachineWheel3BottomTile:: ; cd47
	ds 1

wSlotMachineWheel3MiddleTile:: ; cd48

wFacingDirectionList:: ; cd48
; 4 bytes (also, the byte before the start of the list (cd47) is used a temp
;          variable when the list is rotated)
; used when spinning the player's sprite
	ds 1

wSlotMachineWheel3TopTile:: ; cd49

wTempObtainedBadgesBooleans::
; 8 bytes
; temporary list created when displaying the badges on the trainer screen
; one byte for each badge; 0 = not obtained, 1 = obtained
	ds 1

wTempCoins2:: ; cd4a
; 2 bytes
; temporary variable used to subtract the bet amount from the player's coins

wPayoutCoins:: ; cd4a
; 2 bytes
	ds 2

wTradedPlayerMonOTID:: ; cd4c

wSlotMachineFlags:: ; cd4c
; These flags are set randomly and control when the wheels stop.
; bit 6: allow the player to win in general
; bit 7: allow the player to win with 7 or bar (plus the effect of bit 6)
	ds 1

wSlotMachineWheel1SlipCounter:: ; cd4d
; wheel 1 can "slip" while this is non-zero

wCutTile:: ; cd4d
; $3d = tree tile
; $52 = grass tile
	ds 1

wSlotMachineWheel2SlipCounter:: ; cd4e
; wheel 2 can "slip" while this is non-zero

wTradedEnemyMonOT:: ; cd4e
	ds 1

wSavedPlayerScreenY:: ; cd4f

wSlotMachineRerollCounter:: ; cd4f
; The remaining number of times wheel 3 will roll down a symbol until a match is
; found, when winning is enabled. It's initialized to 4 each bet.

wEmotionBubbleSpriteIndex:: ; cd4f
; the index of the sprite the emotion bubble is to be displayed above
	ds 1

wWhichEmotionBubble:: ; cd50

wSlotMachineBet:: ; cd50
; how many coins the player bet on the slot machine (1 to 3)

wSavedPlayerFacingDirection:: ; cd50

wWhichAnimationOffsets:: ; cd50
; 0 = cut animation, 1 = boulder dust animation
	ds 9

wTradedEnemyMonOTID:: ; cd59
	ds 2

wOAMBaseTile:: ; cd5b

wcd5b:: ds 1 ; used in some sprite stuff, town map and surge gym trash cans
wcd5c:: ds 1 ; used in town map

wMonPartySpriteSpecies:: ; cd5d
	ds 1

wLeftGBMonSpecies:: ; cd5e
; in the trade animation, the mon that leaves the left gameboy
	ds 1

wRightGBMonSpecies:: ; cd5f
; in the trade animation, the mon that leaves the right gameboy
	ds 1

wFlags_0xcd60:: ; cd60
; bit 0: is player engaged by trainer (to avoid being engaged by multiple trainers simultaneously)
; bit 1: boulder dust animation (from using Strength) pending
; bit 3: using generic PC
; bit 5: don't play sound when A or B is pressed in menu
; bit 6: tried pushing against boulder once (you need to push twice before it will move)
	ds 1

; unused?
	ds 9

wActionResultOrTookBattleTurn:: ; cd6a
; This has overlapping related uses.
; When the player tries to use an item or use certain field moves, 0 is stored
; when the attempt fails and 1 is stored when the attempt succeeds.
; In addition, some items store 2 for certain types of failures, but this
; cannot happen in battle.
; In battle, a non-zero value indicates the player has taken their turn using
; something other than a move (e.g. using an item or switching pokemon).
; So, when an item is successfully used in battle, this value becomes non-zero
; and the player is not allowed to make a move and the two uses are compatible.
	ds 1

wJoyIgnore:: ; cd6b
; Set buttons are ignored.
	ds 1

wDownscaledMonSize:: ; cd6c
; size of downscaled mon pic used in pokeball entering/exiting animation
; $00 = 5×5
; $01 = 3×3

wNumMovesMinusOne:: ; cd6c
; FormatMovesString stores the number of moves minus one here
	ds 1

wcd6d:: ds 4 ; buffer for various data

wStatusScreenCurrentPP:: ; cd71
; temp variable used to print a move's current PP on the status screen
	ds 1

	ds 6

wNormalMaxPPList:: ; cd78
; list of normal max PP (without PP up) values
	ds 9

wSerialOtherGameboyRandomNumberListBlock:: ; cd81
; buffer for transferring the random number list generated by the other gameboy

wTileMapBackup2:: ; cd81
; second buffer for temporarily saving and restoring current screen's tiles (e.g. if menus are drawn on top)
	ds 20 * 18

wBuffer:: ; cee9
; Temporary storage area of 30 bytes.

wTownMapCoords:: ; cee9
; lower nybble is x, upper nybble is y

wHPBarMaxHP:: ; cee9
	ds 2
wHPBarOldHP:: ; ceeb
	ds 2
wHPBarNewHP:: ; ceed
	ds 2
wHPBarDelta:: ; ceef
	ds 1

wcef0:: ds 1  ; used with HP bar stuff, probably used with wBuffer too.
wcef1:: ds 12 ; same case as above

wHPBarHPDifference:: ; cefd
	ds 1
	ds 7 ; unused?

wAIItem:: ; cf05
; the item that the AI used
	ds 1

wUsedItemOnWhichPokemon:: ; cf05
	ds 1

wAnimSoundID:: ; cf07
; sound ID during battle animations
	ds 1

wBankswitchHomeSavedROMBank:: ; cf08
; used as a storage value for the bank to return to after a BankswitchHome (bankswitch in homebank)
	ds 1

wBankswitchHomeTemp:: ; cf09
; used as a temp storage value for the bank to switch to
	ds 1

wBoughtOrSoldItemInMart:: ; cf0a
; 0 = nothing bought or sold in pokemart
; 1 = bought or sold something in pokemart
; this value is not used for anything
	ds 1

wBattleResult:: ; cf0b
; $00 - win
; $01 - lose
; $02 - draw
	ds 1

wAutoTextBoxDrawingControl:: ; cf0c
; bit 0: if set, DisplayTextID automatically draws a text box
	ds 1

wcf0d:: ds 1 ; used with some overworld scripts (not exactly sure what it's used for)

wTilePlayerStandingOn:: ; cf0e
; used in CheckForTilePairCollisions2 to store the tile the player is on
	ds 1

wNPCNumScriptedSteps:: ds 1 ; cf0f

wNPCMovementScriptFunctionNum:: ; cf10
; which script function within the pointer table indicated by
; wNPCMovementScriptPointerTableNum
	ds 1

wTextPredefFlag:: ; cf11
; bit 0: set when printing a text predef so that DisplayTextID doesn't switch
;        to the current map's bank
	ds 1

wPredefParentBank:: ; cf12
	ds 1

wSpriteIndex:: ds 1

wCurSpriteMovement2:: ; cf14
; movement byte 2 of current sprite
	ds 1

; unused?
	ds 2

wNPCMovementScriptSpriteOffset:: ; cf17
; sprite offset of sprite being controlled by NPC movement script
	ds 1

wScriptedNPCWalkCounter:: ; cf18
	ds 1

	ds 1

wGBC:: ; cf1a
	ds 1

wOnSGB:: ; cf1b
; if running on SGB, it's 1, else it's 0
	ds 1

wcf1c:: ds 1 ; used with sgb palettes
wcf1d:: ds 1 ; used when displaying palettes for Pokemon
wcf1e:: ds 1 ; used to display palettes for HP bar
wcf1f:: ds 6 ; used to display HP bars in Pokemon Menu (probably palettes)
wcf25:: ds 8 ; used to display HP bar for Pokemon Status Screen (probably palettes too)
wcf2d:: ds 1 ; also used to display HP bar for Pokemon Menu (something about HP colour)
wcf2e:: ds 2 ; more HP bar palette stuff.
wcf30:: ds 7 ; used with palettes (apparently for Pokedex)
wcf37:: ds 20 ; used with palletes too (used for Party Menu)
wcf4b:: ds 1 ; storage buffer for various strings
wcf4c:: ds 1 ; used with displaying EXP value, probably also overflowed with wcf4b
wGainBoostedExp:: ; cf4d
	ds 1
	ds 17

wGymCityName:: ; cf5f
	ds 17

wGymLeaderName:: ; cf70
	ds 11

wItemList:: ; cf7b
	ds 16

wListPointer:: ; cf8b
	ds 2

wcf8d:: ds 1 ; used in GetMonName
wcf8e:: ds 1 ; also used in GetMonName (probably as a pointer)

wItemPrices:: ; cf8f
	ds 2

wcf91:: ds 1 ; used with a lot of things (too much to list here)

wWhichPokemon:: ; cf92
; which pokemon you selected
	ds 1

wPrintItemPrices:: ; cf93
; if non-zero, then print item prices when displaying lists
	ds 1

wHPBarType:: ; cf94
; type of HP bar
; $00 = enemy HUD in battle
; $01 = player HUD in battle / status screen
; $02 = party menu

wListMenuID:: ; cf94
; ID used by DisplayListMenuID
	ds 1

wRemoveMonFromBox:: ; cf95
; if non-zero, RemovePokemon will remove the mon from the current box,
; else it will remove the mon from the party

wMoveMonType:: ; cf95
; 0 = move from box to party
; 1 = move from party to box
; 2 = move from daycare to party
; 3 = move from party to daycare
	ds 1

wItemQuantity:: ; cf96
	ds 1

wMaxItemQuantity:: ; cf97
	ds 1

; LoadMonData copies mon data here
wLoadedMon:: party_struct wLoadedMon ; cf98

wFontLoaded:: ; cfc4
; bit 0: The space in VRAM that is used to store walk animation tile patterns
;        for the player and NPCs is in use for font tile patterns.
;        This means that NPC movement must be disabled.
; The other bits are unused.
	ds 1

wWalkCounter:: ; cfc5
; walk animation counter
	ds 1

wTileInFrontOfPlayer:: ; cfc6
; background tile number in front of the player (either 1 or 2 steps ahead)
	ds 1

wMusicHeaderPointer:: ; cfc7
; (the current music channel address - $4000) / 3
	ds 1

wcfc8:: ds 1 ; used with audio
wcfc9:: ds 1 ; also used with audio
wcfca:: ds 1 ; also used with audio too

wUpdateSpritesEnabled:: ; cfcb
; $00 = causes sprites to be hidden and the value to change to $ff
; $01 = enabled
; $ff = disabled
; other values aren't used
	ds 1

W_ENEMYMOVENUM:: ; cfcc
	ds 1
W_ENEMYMOVEEFFECT:: ; cfcd
	ds 1
W_ENEMYMOVEPOWER:: ; cfce
	ds 1
W_ENEMYMOVETYPE:: ; cfcf
	ds 1
W_ENEMYMOVEACCURACY:: ; cfd0
	ds 1
W_ENEMYMOVEMAXPP:: ; cfd1
	ds 1
W_PLAYERMOVENUM:: ; cfd2
	ds 1
W_PLAYERMOVEEFFECT:: ; cfd3
	ds 1
W_PLAYERMOVEPOWER:: ; cfd4
	ds 1
W_PLAYERMOVETYPE:: ; cfd5
	ds 1
W_PLAYERMOVEACCURACY:: ; cfd6
	ds 1
W_PLAYERMOVEMAXPP:: ; cfd7
	ds 1


wEnemyMonSpecies2:: ; cfd8
	ds 1
wBattleMonSpecies2:: ; cfd9
	ds 1

wEnemyMonNick:: ds 11 ; cfda

wEnemyMon:: ; cfe5
; The wEnemyMon struct reaches past 0xcfff,
; the end of wram bank 0 on cgb.
; This has no significance on dmg, where wram
; isn't banked (c000-dfff is contiguous).
; However, recent versions of rgbds have replaced
; dmg-style wram with cgb wram banks.

; Until this is fixed, this struct will have
; to be declared manually.

wEnemyMonSpecies::   db
wEnemyMonHP::        dw
wEnemyMonPartyPos::
wEnemyMonBoxLevel::  db
wEnemyMonStatus::    db
wEnemyMonType::
wEnemyMonType1::     db
wEnemyMonType2::     db
wEnemyMonCatchRate_NotReferenced:: db
wEnemyMonMoves::     ds NUM_MOVES
wEnemyMonDVs::       ds 2
wEnemyMonLevel::     db
wEnemyMonMaxHP::     dw
wEnemyMonAttack::    dw
wEnemyMonDefense::   dw
wEnemyMonSpeed::     dw
wEnemyMonSpecial::   dw
wEnemyMonPP::        ds 2 ; NUM_MOVES - 2
SECTION "WRAM Bank 1", WRAMX, BANK[1]
                     ds 2 ; NUM_MOVES - 2

wEnemyMonBaseStats:: ds 5
wEnemyMonCatchRate:: ds 1
wEnemyMonBaseExp:: ds 1

wBattleMonNick:: ds 11 ; d009
wBattleMon:: battle_struct wBattleMon ; d014


W_TRAINERCLASS:: ; d031
	ds 1

; unused?
	ds 1
	
wTrainerPicID::
; Defaults to trainer class, can be changed with trainer type $FE
	ds 1
	
wTrainerAINumber::
; Defaults to trainer class, can be changed with trainer type $FE
	ds 1
	
wTrainerPicBank:: ds 1

wTrainerPicPointer:: ; d033
	ds 2
	ds 1
wd036:: ds 16 ; used as a temporary buffer to print "XXX learned YYY"
wd046:: ds 1 ; used with trainer pointer stuff (not exactly sure, but the label is incremented and loaded with a value, so wd047 is accessed)
wd047:: ds 1 ; used with unloading trainer data?
wd048:: ds 2 ; used as a pointer for missable object loop

W_TRAINERNAME:: ; d04a
; 13 bytes for the letters of the opposing trainer
; the name is terminated with $50 with possible
; unused trailing letters
	ds 13

W_ISINBATTLE:: ; d057
; no battle, this is 0
; wild battle, this is 1
; trainer battle, this is 2
	ds 1

wPartyGainExpFlags:: ; d058
; flags that indicate which party members should be be given exp when GainExperience is called
	flag_array 6

W_CUROPPONENT:: ; d059
; in a wild battle, this is the species of pokemon
; in a trainer battle, this is the trainer class + $C8
	ds 1

W_BATTLETYPE:: ; d05a
; in normal battle, this is 0
; in old man battle, this is 1
; in safari battle, this is 2
	ds 1

wDamageMultipliers:: ; d05b
; bits 0-6: Effectiveness
   ;  $0 = immune
   ;  $5 = not very effective
   ;  $a = neutral
   ; $14 = super-effective
; bit 7: STAB
	ds 1

; probably removable with the new trainer move system, double check
W_LONEATTACKNO:: ; d05c
; which entry in LoneAttacks to use
W_GYMLEADERNO:: ; d05c
; it's actually the same thing as ^
	ds 1
W_TRAINERNO:: ; d05d
; which instance of [youngster, lass, etc] is this?
	ds 1

wCriticalHitOrOHKO:: ; d05e
; $00 = normal attack
; $01 = critical hit
; $02 = successful OHKO
; $ff = failed OHKO
	ds 1

W_MOVEMISSED:: ; d05f
	ds 1

wPlayerStatsToDouble:: ; removable?
; always 0
	ds 1

wPlayerStatsToHalve:: ; removable?
; always 0
	ds 1

W_PLAYERBATTSTATUS1:: ; d062
; bit 0 - bide
; bit 1 - thrash / petal dance
; bit 2 - attacking multiple times (e.g. double kick)
; bit 3 - flinch
; bit 4 - charging up for attack
; bit 5 - using multi-turn move (e.g. wrap)
; bit 6 - invulnerable to normal attack (using fly/dig)
; bit 7 - confusion
	ds 1

W_PLAYERBATTSTATUS2:: ; d063
; bit 0 - X Accuracy effect
; bit 1 - protected by "mist"
; bit 2 - focus energy effect
; bit 4 - has a substitute
; bit 5 - need to recharge
; bit 6 - rage
; bit 7 - leech seeded
	ds 1

W_PLAYERBATTSTATUS3:: ; d064
; bit 0 - toxic
; bit 1 - light screen
; bit 2 - reflect
; bit 3 - tranformed
	ds 1

wEnemyStatsToDouble:: ; removable?
; always 0
	ds 1

wEnemyStatsToHalve:: ; removable?
; always 0
	ds 1

W_ENEMYBATTSTATUS1:: ; d067
	ds 1
W_ENEMYBATTSTATUS2:: ; d068
	ds 1
W_ENEMYBATTSTATUS3:: ; d069
	ds 1

wPlayerNumAttacksLeft::
; when the player is attacking multiple times, the number of attacks left
	ds 1

W_PLAYERCONFUSEDCOUNTER:: ; d06b
	ds 1

W_PLAYERTOXICCOUNTER:: ; d06c
	ds 1
W_PLAYERDISABLEDMOVE:: ; d06d
; high nibble: which move is disabled (1-4)
; low nibble: disable turns left
	ds 1
; unused?
	ds 1

wEnemyNumAttacksLeft:: ; d06f
; when the enemy is attacking multiple times, the number of attacks left
	ds 1

W_ENEMYCONFUSEDCOUNTER:: ; d070
	ds 1

W_ENEMYTOXICCOUNTER:: ; d071
	ds 1
W_ENEMYDISABLEDMOVE:: ; d072
; high nibble: which move is disabled (1-4)
; low nibble: disable turns left
	ds 1
; unused?
	ds 1

wPlayerNumHits:: ; d074
; number of hits by player in attacks like Double Slap, etc.

wPlayerBideAccumulatedDamage:: ; d074
; the amount of damage accumulated by the player while biding (2 bytes)

wUnknownSerialCounter2:: ; d075
; 2 bytes

	ds 4

wEscapedFromBattle::
; non-zero when an item or move that allows escape from battle was used
	ds 1

wAmountMoneyWon:: ; wd079 - wd07b
wd079:: ds 1 ; used as a value to print the money won from a battle, as well as a misc. value in seafoam
wd07a:: ds 1 ; same case as above
wd07b:: ds 1 ; used as a buffer to convert the money won from a battle into BCD

W_ANIMATIONID:: ; d07c
; ID number of the current battle animation
	ds 1

wNamingScreenType:: ; d07d

wPartyMenuTypeOrMessageID:: ; d07d

wTempTilesetNumTiles:: ; d07d
; temporary storage for the number of tiles in a tileset
	ds 1

wSavedListScrollOffset:: ; d07e
; used by the pokemart code to save the existing value of wListScrollOffset
; so that it can be restored when the player is done with the pokemart NPC
	ds 1

	ds 2

; base coordinates of frame block
W_BASECOORDX:: ; d081
	ds 1
W_BASECOORDY:: ; d082
	ds 1

; low health alarm counter/enable
; high bit = enable, others = timer to cycle frequencies
wLowHealthAlarm:: ds 1 ; d083

W_FBTILECOUNTER:: ; d084
; counts how many tiles of the current frame block have been drawn
	ds 1

wd085:: ds 1 ; used with animating water/flowers

W_SUBANIMFRAMEDELAY:: ; d086
; duration of each frame of the current subanimation in terms of screen refreshes
	ds 1
W_SUBANIMCOUNTER:: ; d087
; counts the number of subentries left in the current subanimation
	ds 1

wd088:: ds 1 ; savefile checksum (if file is corrupted)

W_NUMFBTILES:: ; d089
; number of tiles in current battle animation frame block
	ds 1

wTradedMonMovingRight:: ; d08a
; $01 if mon is moving from left gameboy to right gameboy; $00 if vice versa

wd08a:: ds 1 ; used with sprites and displaying the option menu on the main menu screen?

wAnimCounter:: ; d08b
; generic counter variable for various animations

W_SUBANIMTRANSFORM:: ; d08b
; controls what transformations are applied to the subanimation
; 01: flip horizontally and vertically
; 02: flip horizontally and translate downwards 40 pixels
; 03: translate base coordinates of frame blocks, but don't change their internal coordinates or flip their tiles
; 04: reverse the subanimation
	ds 1

wEndBattleWinTextPointer:: ; d08c
	ds 2

wEndBattleLoseTextPointer:: ; d08e
	ds 2

	ds 2

wEndBattleTextRomBank:: ; d092
	ds 1

	ds 1

W_SUBANIMADDRPTR:: ; d094
; the address _of the address_ of the current subanimation entry
	ds 2

wSlotMachineAllowMatchesCounter:: ; d096
; If non-zero, the allow matches flag is always set.
; There is a 1/256 (~0.4%) chance that this value will be set to 60, which is
; the only way it can increase. Winning certain payout amounts will decrement it
; or zero it.

W_SUBANIMSUBENTRYADDR:: ; d096
; the address of the current subentry of the current subanimation
	ds 2

	ds 2

wd09a:: ds 1 ; used with the battle transition screen when entering a battle (screen slowly draws into black)

wTownMapSpriteBlinkingEnabled:: ; d09b
; non-zero when enabled. causes nest locations to blink on and off.
; the town selection cursor will blink regardless of what this value is

wd09b:: ds 1 ; also used with battle transition screen and move animations

W_FBDESTADDR:: ; d09c
; current destination address in OAM for frame blocks (big endian)
	ds 2

W_FBMODE:: ; d09e
; controls how the frame blocks are put together to form frames
; specifically, after finishing drawing the frame block, the frame block's mode determines what happens
; 00: clean OAM buffer and delay
; 02: move onto the next frame block with no delay and no cleaning OAM buffer
; 03: delay, but don't clean OAM buffer
; 04: delay, without cleaning OAM buffer, and do not advance [W_FBDESTADDR], so that the next frame block will overwrite this one
; sprite data is written column by column, each byte contains 8 columns (one for ech bit)
; for 2bpp sprites, pairs of two consecutive bytes (i.e. pairs of consecutive rows of sprite data)
; contain the upper and lower bit of each of the 8 pixels, respectively
	ds 1

wNewTileBlockID:: ; d09f

wd09f:: ds 1 ; used with predef ReplaceTileBlock
wDisableVBlankWYUpdate:: ds 1 ; if non-zero, don't update WY during V-blank

W_SPRITECURPOSX:: ; d0a1
	ds 1
W_SPRITECURPOSY:: ; d0a2
	ds 1
W_SPRITEWITDH:: ; d0a3
	ds 1
W_SPRITEHEIGHT:: ; d0a4
	ds 1
W_SPRITEINPUTCURBYTE:: ; d0a5
; current input byte
	ds 1
W_SPRITEINPUTBITCOUNTER:: ; d0a6
; bit offset of last read input bit
	ds 1

W_SPRITEOUTPUTBITOFFSET:: ; d0a7; determines where in the output byte the two bits are placed. Each byte contains four columns (2bpp data)
; 3 -> XX000000   1st column
; 2 -> 00XX0000   2nd column
; 1 -> 0000XX00   3rd column
; 0 -> 000000XX   4th column
	ds 1

W_SPRITELOADFLAGS:: ; d0a8
; bit 0 determines used buffer (0 -> $a188, 1 -> $a310)
; bit 1 loading last sprite chunk? (there are at most 2 chunks per load operation)
	ds 1
W_SPRITEUNPACKMODE:: ; d0a9
	ds 1
W_SPRITEFLIPPED:: ; d0aa
	ds 1

W_SPRITEINPUTPTR:: ; d0ab
; pointer to next input byte
	ds 2
W_SPRITEOUTPUTPTR:: ; d0ad
; pointer to current output byte
	ds 2
W_SPRITEOUTPUTPTRCACHED:: ; d0af
; used to revert pointer for different bit offsets
	ds 2
W_SPRITEDECODETABLE0PTR:: ; d0b1
; pointer to differential decoding table (assuming initial value 0)
	ds 2
W_SPRITEDECODETABLE1PTR:: ; d0b3
; pointer to differential decoding table (assuming initial value 1)
	ds 2

wd0b5:: ds 1 ; used as a temp storage area for Pokemon Species, and other Pokemon/Battle related things

wNameListType:: ; d0b6
	ds 1

wPredefBank:: ; d0b7
	ds 1

W_MONHEADER:: ; d0b8
W_MONHDEXNUM:: ; d0b8
	ds 1

W_MONHBASESTATS:: ; d0b9
W_MONHBASEHP:: ; d0b9
	ds 1
W_MONHBASEATTACK:: ; d0ba
	ds 1
W_MONHBASEDEFENSE:: ; d0bb
	ds 1
W_MONHBASESPEED:: ; d0bc
	ds 1
W_MONHBASESPECIAL:: ; d0bd
	ds 1

W_MONHTYPES:: ; d0be
W_MONHTYPE1:: ; d0be
	ds 1
W_MONHTYPE2:: ; d0bf
	ds 1

W_MONHCATCHRATE:: ; d0c0
	ds 1
W_MONHBASEXP:: ; d0c1
	ds 1
W_MONHSPRITEDIM:: ; d0c2
	ds 1
W_MONHFRONTSPRITE:: ; d0c3
	ds 2
W_MONHBACKSPRITE:: ; d0c5
	ds 2

W_MONHMOVES:: ; d0c7
	ds 4

W_MONHGROWTHRATE:: ; d0cb
	ds 1

W_MONHLEARNSET:: ; d0cc
; bit field
    flag_array 50 + 5

W_MONHPICBANK:: ; d0d3
    ds 1

wd0d4:: ds 3 ; temp storage for hTilesetType


W_DAMAGE:: ; d0d7
	ds 2

; unused?
	ds 2

wRepelRemainingSteps:: ; d0db
	ds 1

wMoves:: ; d0dc
; list of moves for FormatMovesString
	ds 4

wMoveNum:: ; d0e0
	ds 1

wMovesString:: ; d0e1
	ds 56

wd119:: ds 1 ; written to from W_CURMAPTILESET but never read

wWalkBikeSurfStateCopy:: ; d11a
; wWalkBikeSurfState is sometimes copied here, but it doesn't seem to be used for anything
	ds 1

wInitListType:: ; d11b
; the type of list for InitList to init
	ds 1

wd11c:: ds 1 ; temp storage value for catching pokemon
wd11d:: ds 1 ; used with battle switchout and testing if the enemy mon fainted
wd11e:: ds 1 ; used as a Pokemon and Item storage value. Also used as an output value for CountSetBits
wd11f:: ds 1 ; used when running from battle and PartyMenuInit

wNumRunAttempts::
; number of times the player has tried to run from battle
	ds 1

wd121:: ds 1 ; used with evolving pokemon
wd122:: ds 2 ; saved ROM bank number for vblank
wIsKeyItem:: ds 1 ; d124

wTextBoxID:: ; d125
	ds 1

wd126:: ds 1 ; not exactly sure what this is used for, but it seems to be used as a multipurpose temp flag value

W_CURENEMYLVL:: ; d127
	ds 1

wItemListPointer:: ; d128
; pointer to list of items terminated by $FF
	ds 2

wListCount::
; number of entries in a list
	ds 1

wLinkState:: ; d12b
	ds 1

wTwoOptionMenuID:: ; d12c
	ds 1

wChosenMenuItem:: ; d12d
; the id of the menu item the player ultimately chose

wOutOfBattleBlackout:: ; d12d
; non-zero when the whole party has fainted due to out-of-battle poison damage
	ds 1

wMenuExitMethod:: ; d12e
; the way the user exited a menu
; for list menus and the buy/sell/quit menu:
; $01 = the user pressed A to choose a menu item
; $02 = the user pressed B to cancel
; for two-option menus:
; $01 = the user pressed A with the first menu item selected
; $02 = the user pressed B or pressed A with the second menu item selected
	ds 1

wd12f:: ds 1 ; used in some coordinatestuff, npc pathstuff, and game corner prize stuff
wd130:: ds 1 ; saved value of screen Y coord of trainer sprite
wd131:: ds 1 ; saved value of screen X coord of trainer sprite
wd132:: ds 1 ; saved value of map Y coordinate of trainer sprite (not sure for purpose)
wd133:: ds 6 ; saved value of map X coordinate of trainer sprite
wd139:: ds 1 ; backup of selected menu entry for game corner prizes

wIgnoreInputCounter:: ; d13a
; counts downward each frame
; when it hits 0, bit 5 (ignore input bit) of wd730 is reset
	ds 1

wStepCounter:: ; d13b
; counts down once every step
	ds 1

wNumberOfNoRandomBattleStepsLeft:: ; d13c
; after a battle, you have at least 3 steps before a random battle can occur
	ds 1

W_PRIZE1:: ; d13d
	ds 1
W_PRIZE2:: ; d13e
	ds 1
W_PRIZE3:: ; d13f
	ds 1

; unused?
	ds 1

wSerialRandomNumberListBlock:: ; d141
; the first 7 bytes are the preamble

wd141:: ds 2 ; prices for prizes
wd143:: ds 2 ; prices for prizes
wd145:: ds 3 ; prices for prizes

wLinkBattleRandomNumberList:: ; d148
; shared list of 9 random numbers, indexed by wLinkBattleRandomNumberListIndex
	ds 10

wSerialPlayerDataBlock:: ; d152
; the first 6 bytes are the preamble

wd152:: ds 1 ; used as a temporary storage for the item used
wd153:: ds 3 ; written to during pokedex flag action but doesn't seem to be read from
wd156:: ds 1 ; evolution stone ID used
wd157:: ds 1 ; used with oak's lab script (related to npc movement directions), possibly indirectly accessed with values below

wIsTrainerBattle::
	ds 1
wWasTrainerBattle::
	ds 1

wPlayerName:: ; d158
	ds 11


wPartyDataStart::

wPartyCount::   ds 1 ; d163
wPartySpecies:: ds PARTY_LENGTH ; d164
wPartyEnd::     ds 1 ; d16a

wPartyMons::
wPartyMon1:: party_struct wPartyMon1 ; d16b
wPartyMon2:: party_struct wPartyMon2 ; d197
wPartyMon3:: party_struct wPartyMon3 ; d1c3
wPartyMon4:: party_struct wPartyMon4 ; d1ef
wPartyMon5:: party_struct wPartyMon5 ; d21b
wPartyMon6:: party_struct wPartyMon6 ; d247

wPartyMonOT::    ds 11 * PARTY_LENGTH ; d273
wPartyMonNicks:: ds 11 * PARTY_LENGTH ; d2b5

wPartyDataEnd::


wMainDataStart::

wPokedexOwned:: ; d2f7
	flag_array NUM_POKEMON
wPokedexOwnedEnd::

wPokedexSeen:: ; d30a
	flag_array NUM_POKEMON
wPokedexSeenEnd::


wNumBagItems:: ; d31d
	ds 1
wBagItems:: ; d31e
; item, quantity
	ds BAG_ITEM_CAPACITY * 2
	ds 1 ; end

wPlayerMoney:: ; d347
	ds 3 ; BCD

wRivalName:: ; d34a
	ds 11

wOptions:: ; d355
; bit 7 = battle animation
; 0: On
; 1: Off
; bit 6 = battle style
; 0: Shift
; 1: Set
; bits 0-3 = text speed (number of frames to delay after printing a letter)
; 1: Fast
; 3: Medium
; 5: Slow
	ds 1

wObtainedKantoBadges:: ; d356
	ds 1

wObtainedJohtoBadges::
	ds 1

wLetterPrintingDelayFlags:: ; d358
; bit 0: If 0, limit the delay to 1 frame. Note that this has no effect if
;        the delay has been disabled entirely through bit 1 of this variable
;        or bit 6 of wd730.
; bit 1: If 0, no delay.
	ds 1

wPlayerID:: ; d359
	ds 2

wd35b:: ds 1 ; used with audio stuff
wd35c:: ds 1 ; storage for audio bank for current map?

wMapPalOffset:: ; d35d
; offset subtracted from FadePal4 to get the background and object palettes for the current map
; normally, it is 0. it is 6 when Flash is needed, causing FadePal2 to be used instead of FadePal4
	ds 1

W_CURMAP:: ; d35e
	ds 1

wCurrentTileBlockMapViewPointer:: ; d35f
; pointer to the upper left corner of the current view in the tile block map
	ds 2

W_YCOORD:: ; d361
; player’s position on the current map
	ds 1

W_XCOORD:: ; d362
	ds 1

W_YBLOCKCOORD:: ; d363
; player's y position (by block)
	ds 1

W_XBLOCKCOORD:: ; d364
	ds 1

wLastMap:: ; d365
	ds 1

wd366:: ds 1 ; W_CURMAPWIDTH of the last outdoor map visited when entering an inside map

W_CURMAPTILESET:: ; d367
	ds 1

W_CURMAPHEIGHT:: ; d368
; blocks
	ds 1

W_CURMAPWIDTH:: ; d369
; blocks
	ds 1

W_MAPDATAPTR:: ; d36a
	ds 2

W_MAPTEXTPTR:: ; d36c
	ds 2

W_MAPSCRIPTPTR:: ; d36e
	ds 2

W_MAPCONNECTIONS:: ; d370
; connection byte
	ds 1

W_MAPCONN1PTR:: ; d371
	ds 1

wd372:: ds 1 ; some connection stuff, too bothered to label it
wd373:: ds 1
wd374:: ds 1
wd375:: ds 1
wd376:: ds 1
wd377:: ds 1
wd378:: ds 1
wd379:: ds 1
wd37a:: ds 1
wd37b:: ds 1

W_MAPCONN2PTR:: ; d37c
	ds 1

wd37d:: ds 1
wd37e:: ds 1
wd37f:: ds 1
wd380:: ds 1
wd381:: ds 1
wd382:: ds 1
wd383:: ds 1
wd384:: ds 1
wd385:: ds 1
wd386:: ds 1

W_MAPCONN3PTR:: ; d387
	ds 1

wd388:: ds 1
wd389:: ds 1
wd38a:: ds 1
wd38b:: ds 1
wd38c:: ds 1
wd38d:: ds 1
wd38e:: ds 1
wd38f:: ds 1
wd390:: ds 1
wd391:: ds 1

W_MAPCONN4PTR:: ; d392
	ds 1

wd393:: ds 1
wd394:: ds 1
wd395:: ds 1
wd396:: ds 1
wd397:: ds 1
wd398:: ds 1
wd399:: ds 1
wd39a:: ds 1
wd39b:: ds 1
wd39c:: ds 1

W_SPRITESET:: ; d39d
; sprite set for the current map (11 sprite picture ID's)
	ds 11

W_SPRITESETID:: ; d3a8
; sprite set ID for the current map
	ds 1

wd3a9:: ds 1 ; used when getting the object data pointer
wd3aa:: ds 3 ; second part of the pointer
wd3ad:: ds 1 ; used as the beginning value for copying warp data

wNumberOfWarps:: ; d3ae
; number of warps in current map
	ds 1

wWarpEntries:: ; d3af
; current map warp entries
	ds 128

wDestinationWarpID:: ; d42f
; if $ff, the player's coordinates are not updated when entering the map
	ds 1

; unused?
	ds 128

wd4b0:: ds 1 ; number of signs on the map
wd4b1:: ds 32 ; starting address for sign coords
wd4d1:: ds 16 ; starting address for sign text IDs

W_NUMSPRITES:: ; d4e1
; number of sprites on the current map
	ds 1

; these two variables track the X and Y offset in blocks from the last special warp used
; they don't seem to be used for anything
wYOffsetSinceLastSpecialWarp:: ; d4e2
	ds 1
wXOffsetSinceLastSpecialWarp:: ; d4e3
	ds 1

W_MAPSPRITEDATA:: ; d4e4
; two bytes per sprite (movement byte 2, text ID)
	ds 32

W_MAPSPRITEEXTRADATA:: ; d504
; two bytes per sprite (trainer class/item ID, trainer set ID)
	ds 32

;wMapSpriteHideShowFlags::
; two bytes per sprite (event flag, hidden if set)
;	ds 32

wd524:: ds 1 ; map height in 2x2 metatiles, also used with checking connections
wd525:: ds 1 ; map width in 2x2 metatiles, also used with checking connections

wMapViewVRAMPointer:: ; d526
; the address of the upper left corner of the visible portion of the BG tile map in VRAM
	ds 2

wd528:: ds 1 ; additional storage for directions
wd529:: ds 1 ; same case as above, but used differently
wd52a:: ds 1 ; same case as above

W_TILESETBANK:: ; d52b
	ds 1

W_TILESETBLOCKSPTR:: ; d52c
; maps blocks (4x4 tiles) to tiles
	ds 2

W_TILESETGFXPTR:: ; d52e
	ds 2

W_TILESETCOLLISIONPTR:: ; d530
; list of all walkable tiles
	ds 2

W_TILESETTALKINGOVERTILES:: ; d532
	ds 3

W_GRASSTILE:: ; d535
	ds 1

	ds 4

wNumBoxItems:: ; d53a
	ds 1
wBoxItems:: ; d53b
; item, quantity
	ds PC_ITEM_CAPACITY * 2
	ds 1 ; end

wCurrentBoxNum:: ; d5a0
	ds 1

; unused 
	ds 1

wNumHoFTeams:: ; d5a2
	ds 1

wd5a3:: ; removable?
	ds 1

wPlayerCoins:: ; d5a4
	ds 2 ; BCD

wMissableObjectFlags:: ; d5a6
; bit array of missable objects. set = removed
; TODO: will be removed once hide/show uses normal flags with the Gen 2 style system
	flag_array $E7

wd5cd:: ds 1 ; temp copy of c1x2 (sprite facing/anim)

wMissableObjectList:: ; d5ce
; each entry consists of 2 bytes
; * the sprite ID (depending on the current map)
; * the missable object index (global, used for wMissableObjectFlags)
; terminated with $FF
; TODO: Remove this, make Hide/Show work off normal event flags
	ds 17 * 2

wGameProgressFlags::
; TODO: Remove some of these from maps that don't need a unique one
; Use something like wGenericMapScript for those to save wram
; Reset that one on every map change

W_OAKSLABCURSCRIPT:: ; d5f0
	ds 1
W_PALLETTOWNCURSCRIPT:: ; d5f1
	ds 1
wFarawayIslandInsideCurScript:: ; d5f2
	ds 1
W_BLUESHOUSECURSCRIPT:: ; d5f3
	ds 1
W_VIRIDIANCITYCURSCRIPT:: ; d5f4
	ds 1
wSouthernIslandInsideCurScript::
	ds 1
wNavelRockLugiaRoomCurScript::
	ds 1
W_PEWTERCITYCURSCRIPT:: ; d5f7
	ds 1
W_ROUTE3CURSCRIPT:: ; d5f8
	ds 1
W_ROUTE4CURSCRIPT:: ; d5f9
	ds 1
W_VIRIDIANGYMCURSCRIPT:: ; d5fb
	ds 1
W_PEWTERGYMCURSCRIPT:: ; d5fc
	ds 1
W_CERULEANGYMCURSCRIPT:: ; d5fd
	ds 1
W_VERMILIONGYMCURSCRIPT:: ; d5fe
	ds 1
W_CELADONGYMCURSCRIPT:: ; d5ff
	ds 1
W_ROUTE6CURSCRIPT:: ; d600
	ds 1
W_ROUTE8CURSCRIPT:: ; d601
	ds 1
W_ROUTE24CURSCRIPT:: ; d602
	ds 1
W_ROUTE25CURSCRIPT:: ; d603
	ds 1
W_ROUTE9CURSCRIPT:: ; d604
	ds 1
W_ROUTE10CURSCRIPT:: ; d605
	ds 1
W_MTMOON1CURSCRIPT:: ; d606
	ds 1
W_MTMOON3CURSCRIPT:: ; d607
	ds 1
W_SSANNE8CURSCRIPT:: ; d608
	ds 1
W_SSANNE9CURSCRIPT:: ; d609
	ds 1
W_ROUTE22CURSCRIPT:: ; d60a
	ds 1
W_REDSHOUSE2CURSCRIPT:: ; d60c
	ds 1
W_VIRIDIANMARKETCURSCRIPT:: ; d60d
	ds 1
W_ROUTE22GATECURSCRIPT:: ; d60e
	ds 1
W_CERULEANCITYCURSCRIPT:: ; d60f
	ds 1
W_SSANNE5CURSCRIPT:: ; d617
	ds 1
W_VIRIDIANFORESTCURSCRIPT:: ; d618
	ds 1
W_MUSEUM1FCURSCRIPT:: ; d619
	ds 1
W_ROUTE13CURSCRIPT:: ; d61a
	ds 1
W_ROUTE14CURSCRIPT:: ; d61b
	ds 1
W_ROUTE17CURSCRIPT:: ; d61c
	ds 1
W_ROUTE19CURSCRIPT:: ; d61d
	ds 1
W_ROUTE21CURSCRIPT:: ; d61e
	ds 1
W_SAFARIZONEENTRANCECURSCRIPT:: ; d61f
	ds 1
W_ROCKTUNNEL2CURSCRIPT:: ; d620
	ds 1
W_ROCKTUNNEL1CURSCRIPT:: ; d621
	ds 1
W_ROUTE11CURSCRIPT:: ; d623
	ds 1
W_ROUTE12CURSCRIPT:: ; d624
	ds 1
W_ROUTE15CURSCRIPT:: ; d625
	ds 1
W_ROUTE16CURSCRIPT:: ; d626
	ds 1
W_ROUTE18CURSCRIPT:: ; d627
	ds 1
W_ROUTE20CURSCRIPT:: ; d628
	ds 1
W_SSANNE10CURSCRIPT:: ; d629
	ds 1
W_VERMILIONCITYCURSCRIPT:: ; d62a
	ds 1
W_POKEMONTOWER2CURSCRIPT:: ; d62b
	ds 1
W_POKEMONTOWER3CURSCRIPT:: ; d62c
	ds 1
W_POKEMONTOWER4CURSCRIPT:: ; d62d
	ds 1
W_POKEMONTOWER5CURSCRIPT:: ; d62e
	ds 1
W_POKEMONTOWER6CURSCRIPT:: ; d62f
	ds 1
W_POKEMONTOWER7CURSCRIPT:: ; d630
	ds 1
W_ROCKETHIDEOUT1CURSCRIPT:: ; d631
	ds 1
W_ROCKETHIDEOUT2CURSCRIPT:: ; d632
	ds 1
W_ROCKETHIDEOUT3CURSCRIPT:: ; d633
	ds 1
W_ROCKETHIDEOUT4CURSCRIPT:: ; d634
	ds 1
W_ROUTE6GATECURSCRIPT:: ; d636
	ds 1
W_ROUTE8GATECURSCRIPT:: ; d637
	ds 1
W_CINNABARISLANDCURSCRIPT:: ; d639
	ds 1
W_MANSION1CURSCRIPT:: ; d63a
	ds 1
W_MANSION2CURSCRIPT:: ; d63c
	ds 1
W_MANSION3CURSCRIPT:: ; d63d
	ds 1
W_MANSION4CURSCRIPT:: ; d63e
	ds 1
W_VICTORYROAD2CURSCRIPT:: ; d63f
	ds 1
W_VICTORYROAD3CURSCRIPT:: ; d640
	ds 1
W_FIGHTINGDOJOCURSCRIPT:: ; d642
	ds 1
W_SILPHCO2CURSCRIPT:: ; d643
	ds 1
W_SILPHCO3CURSCRIPT:: ; d644
	ds 1
W_SILPHCO4CURSCRIPT:: ; d645
	ds 1
W_SILPHCO5CURSCRIPT:: ; d646
	ds 1
W_SILPHCO6CURSCRIPT:: ; d647
	ds 1
W_SILPHCO7CURSCRIPT:: ; d648
	ds 1
W_SILPHCO8CURSCRIPT:: ; d649
	ds 1
W_SILPHCO9CURSCRIPT:: ; d64a
	ds 1
W_HALLOFFAMEROOMCURSCRIPT:: ; d64b
	ds 1
W_GARYCURSCRIPT:: ; d64c
	ds 1
W_LORELEICURSCRIPT:: ; d64d
	ds 1
W_BRUNOCURSCRIPT:: ; d64e
	ds 1
W_AGATHACURSCRIPT:: ; d64f
	ds 1
W_UNKNOWNDUNGEON3CURSCRIPT:: ; d650
	ds 1
W_VICTORYROAD1CURSCRIPT:: ; d651
	ds 1
W_LANCECURSCRIPT:: ; d653
	ds 1
W_SILPHCO10CURSCRIPT:: ; d658
	ds 1
W_SILPHCO11CURSCRIPT:: ; d659
	ds 1
W_FUCHSIAGYMCURSCRIPT:: ; d65b
	ds 1
W_SAFFRONGYMCURSCRIPT:: ; d65c
	ds 1
W_CINNABARGYMCURSCRIPT:: ; d65e
	ds 1
W_CELADONGAMECORNERCURSCRIPT:: ; d65f
	ds 1
W_ROUTE16GATECURSCRIPT:: ; d660
	ds 1
W_BILLSHOUSECURSCRIPT:: ; d661
	ds 1
W_ROUTE5GATECURSCRIPT:: ; d662
	ds 1
W_POWERPLANTCURSCRIPT:: ; d663
	ds 1
W_ROUTE7GATECURSCRIPT:: ; d664
	ds 1
W_SSANNE2CURSCRIPT:: ; d665
	ds 1
W_SEAFOAMISLANDS4CURSCRIPT:: ; d666
	ds 1
W_ROUTE23CURSCRIPT:: ; d667
	ds 1
W_SEAFOAMISLANDS5CURSCRIPT:: ; d668
	ds 1
W_ROUTE18GATECURSCRIPT:: ; d669
	ds 1
wGameProgressFlagsEnd::

wChainFishingStreak::
	ds 1

; unused bytes originally allocated with game progress flags
	ds 99




; Battle Tower's Trainer Class points here for team data
; Only has room for 1 trainer entry, but it is randomized
; Structure will be loaded by Battle Tower scripts
; Trainer name is loaded in wCurTrainerName manually
; IterateTrainer routine will skip reading a name if it is the battle tower trainer
wBattleTowerTrainer::
wBattleTowerTrainerType::
; always $FD - "Special Pic" Trainer type
	ds 1
wBattleTowerTrainerPic::
; db Random trainer pic ID
	ds 1
wBattleTowerTrainerLevel::
; level for all Pokemon on the team
	ds 1
wBattleTowerTrainerParty::
; Entry will not always be 6 Pokemon depending on the round
;
; db Random Pokemon ID #1
; db Random Pokemon ID #2
; db Random Pokemon ID #3
; db Random Pokemon ID #4
; db Random Pokemon ID #5
; db Random Pokemon ID #6
; db 0 - End of entry
	ds 7

wBattleTowerCup::
; Holds which Cup the player has chosen
; 0 = Little Cup
; 1 = Pika Cup
; 2 = Poke Cup
; 3 = Master Cup
	ds 1

wBattleTowerCurLevelsCleared::
; Stores how many trainers the player has beaten so far
	ds 1
	
wBattleTowerBP::
; Stores how many BP or Battle Points the player has earned
	ds 2


; variable sprites can be changed with scripts
; useful in the same way it was in Gen 2
; sprites don't update until the map is reloaded
; see "data/default_var_sprites.asm"
wVarSprites::
wVarSprite1::
	ds 1
wVarSprite2::
	ds 1
wVarSprite3::
	ds 1
wVarSprite4::
	ds 1
wVarSprite5::
	ds 1
wVarSprite6::
	ds 1

wCurTrainerName::
; used to store individual trainer names
; TODO: Same as wLinkEnemyTrainerName
	ds 13

wPlayerGender::
; $00 = male
; $01 = female
	ds 1

wExtraFlags::
; TODO: Move these in with Event Flags and an EngineFlags array
; bit 0 = Set means next Wildmon or Giftmon will be Shiny (Reset afterwards)
; bit 1 = unused
; bit 2 = Set means traded mons obey like normal mons
; bit 3 = Set means you've received Eon Ticket in Celadon Mansion
; bit 4 = Set means you've received Mystic Ticket in Cinnabar Lab
	ds 1

wObtainedHiddenItemsFlags::
	ds 14
	
wObtainedHiddenCoinsFlags::
	ds 2

wWalkBikeSurfState:: ; d700
; $00 = walking
; $01 = biking
; $02 = surfing
	ds 1

; unused?
	ds 10

wKantoTownVisitedFlag:: ; d70b
	ds 2

;wJohtoTownVisitedFlag::
;	ds 2

wSafariSteps:: ; d70d
; starts at 502
	ds 2

wFossilItem:: ; d70f
; item given to cinnabar lab
	ds 1

wFossilMon:: ; d710
; mon that will result from the item
	ds 1

; unused, wKurtApricorn?
	ds 1

; unused, wKurtBall?
	ds 1

; unused, originally wEnemyMonOrTrainerClass
	ds 1

wPlayerJumpingYScreenCoordsIndex:: ; d714
	ds 1

wRivalStarter:: ; d715
	ds 1

; unused?
	ds 1

wPlayerStarter:: ; d717
	ds 1

wBoulderSpriteIndex:: ; d718
; sprite index of the boulder the player is trying to push
	ds 1

wLastBlackoutMap:: ; d719
	ds 1

wDestinationMap:: ; d71a
; destination map (for certain types of special warps, not ordinary walking)
	ds 1

wd71b:: ds 1 ; written to but doesn't seem to be read

wTileInFrontOfBoulderAndBoulderCollisionResult:: ; d71c
; used to store the tile in front of the boulder when trying to push a boulder
; also used to store the result of the collision check ($ff for a collision and $00 for no collision)
	ds 1

wDungeonWarpDestinationMap:: ; d71d
; destination map for dungeon warps
	ds 1

wWhichDungeonWarp:: ; d71e
; which dungeon warp within the source map was used
	ds 1

wd71f:: ; used with card key
	ds 1

; unused
	ds 8

wd728::
; bit 0: using Strength outside of battle
; bit 1: set by IsSurfingAllowed when surfing's allowed, but the caller resets it after checking the result
; bit 3: received Old Rod
; bit 4: received Good Rod
; bit 5: received Super Rod
; bit 6: gave one of the Saffron guards a drink
; bit 7: set by ItemUseCardKey, which is leftover code from a previous implementation of the Card Key
; TODO: Move some of these into normal event flags, and others into like an EngineFlags array
	ds 1

; unused?
	ds 1

; unused
	ds 1

; unused
	ds 1

wd72c:: ; d72c
; bit 0: if not set, the 3 minimum steps between random battles have passed
; bit 1: prevent audio fade out
	ds 1

wd72d:: 
; This variable is used for temporary flags and as the destination map when
; warping to the Trade Center or Colosseum.
; bit 0: sprite facing directions have been initialised in the Trade Center
; bit 3: do scripted warp (used to warp back to Lavender Town from the top of the pokemon tower)
; bit 4: on a dungeon warp
; bit 5: don't make NPCs face the player when spoken to
; Bits 6 and 7 are set by scripts when starting major battles in the storyline,
; but they do not appear to affect anything. Bit 6 is reset after all battles
; and bit 7 is reset after trainer battles (but it's only set before trainer
; battles anyway).
	ds 1

wd72e::
; bit 0: the player has received Lapras in the Silph Co. building
; bit 1: set in various places, but doesn't appear to have an effect
; bit 2: the player has healed pokemon at a pokemon center at least once
; bit 3: the player has a received a pokemon from Prof. Oak
; bit 4: disable battles
; bit 5: set when a battle ends and when the player blacks out in the overworld due to poison
; bit 6: using the link feature
; bit 7: set if scripted NPC movement has been initialised
; TODO: Move some of this into event flags, others into an EngineFlags array
	ds 1

; unused? 
	ds 1

wd730::
; bit 0: NPC sprite being moved by script
; bit 5: ignore joypad input
; bit 6: print text with no delay between each letter
; bit 7: set if joypad states are being simulated in the overworld or an NPC's movement is being scripted
	ds 1

; unused?
	ds 1

wd732:: ; d732
; bit 0: play time being counted
; bit 1: remnant of debug mode? not set by the game code.
; if it is set
; 1. skips most of Prof. Oak's speech, and uses NINTEN as the player's name and SONY as the rival's name
; 2. does not have the player start in floor two of the playyer's house (instead sending them to [wLastMap])
; 3. allows wild battles to be avoided by holding down B
; bit 2: the target warp is a fly warp (bit 3 set or blacked out) or a dungeon warp (bit 4 set)
; bit 3: used warp pad, escape rope, dig, teleport, or fly, so the target warp is a "fly warp"
; bit 4: jumped into hole (Pokemon Mansion, Seafoam Islands, Victory Road) or went down waterfall (Seafoam Islands), so the target warp is a "dungeon warp"
; bit 5: currently being forced to ride bike (cycling road)
; bit 6: map destination is [wLastBlackoutMap] (usually the last used pokemon center, but could be the player's house)
	ds 1

wFlags_D733:: ; d733
; bit 0: running a test battle
; bit 1: prevent music from changing when entering new map
; bit 2: skip the joypad check in CheckWarpsNoCollision (used for the forced warp down the waterfall in the Seafoam Islands)
; bit 3: trainer wants to battle
; bit 4: use variable [wCurMapScript] instead of the provided index for next frame's map script (used to start battle when talking to trainers)
; bit 7: used fly out of battle
	ds 1

wBeatLorelei::
; bit 1: set when you beat Lorelei and reset in Indigo Plateau lobby
; the game uses this to tell when Elite 4 events need to be reset
	ds 1

; unused
	ds 1

wd736:: ; d736
; bit 0: check if the player is standing on a door and make him walk down a step if so
; bit 1: the player is currently stepping down from a door
; bit 2: standing on a warp
; bit 6: jumping down a ledge / fishing animation
; bit 7: player sprite spinning due to spin tiles (Rocket hidehout / Viridian Gym)
	ds 1

wCompletedInGameTradeFlags::
; space for up to 32 in-game traders
; more than plenty for 2 regions
	ds 4

wWarpedFromWhichWarp:: 
	ds 1

wWarpedFromWhichMap:: 
	ds 1

; unused?
	ds 2

wCardKeyDoorY:: ; d73f
	ds 1

wCardKeyDoorX:: ; d740
	ds 1

; unused?
	ds 2

wFirstLockTrashCanIndex::
	ds 1

wSecondLockTrashCanIndex::
	ds 1

; unused?
	ds 2


; TODO: Replace this with:
; wEventFlags::
;	flag_array NUM_EVENT_FLAGS
;
; use in scripts by doing:
;
; ld de, FLAG_TO_CHECK
; ld b, CHECK_FLAG
; predef EventFlagAction
; etc
; 
; add constants/event_constants.asm to store these entries
; add engine/event_flag_actions.asm to store the predefs
; later, rewrite event hide/show to use these flags as well, like Gen 2
; probably add the flag at the end of the person data, stored in yet another table like trainer/item ids
; 
; rewrite map trainer code to store a flag id where it used to store the address
;
wFlags1:: 
; bit 0 - Followed Oak into Lab
; bit 3 - Hall of Fame Dex Rating
; bit 6 - Pallet Town after getting Pokeballs
	ds 3

wBluesHouseFlags:: 
; bit 0 - Got Town Map
; bit 1 - Entered Blue's House
; bit 2 - Daisy walking in kitchen
	ds 1

wOaksLabFlags:: 
; bit 0 - Followed Oak Into Lab 2
; bit 1 - Asked to choose mon
; bit 2 - Got Starter
; bit 3 - Battled Rival in Lab
; bit 4 - Got Pokeballs From Oak
; bit 5 - Got Pokedex
; bit 6 - Pallet After Pokeballs 2
; bit 7 - Oak Appeared in Pallet
	ds 1

wViridianCityFlags:: 
; bit 0 - Viridian Gym Open
; bit 1 - Got TM42
	ds 1

wOaksParcelFlags:: 
; bit 0 - Oak Got Parcel
; bit 1 - Got Oak's Parcel
	ds 1

wViridianGymFlags:: 
; bit 0 - Got TM27
; bit 1 - Beat Giovanni (Gym)
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wViridianGymFlags2:: 
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
	ds 1

wPewterMuseumFlags:: 
; bit 0 - Bought museum ticket
; bit 1 - Got Old Amber
	ds 1

wPewterGymFlags:: 
; bit 2 - Trainer Flag
; bit 6 - Got TM34
; bit 7 - Beat Brock
	ds 1

wCeruleanCityFlags:: 
; bit 0 - Beat Rival in Cerulean City
	ds 1

wCeruleanCityFlags2:: 
; bit 7 - Beat Rocket Grunt in Cerulean City
	ds 1

wCeruleanGymFlags:: 
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 6 - Got TM11
; bit 7 - Beat Misty
	ds 1

wBikeShopFlags:: 
; bit 0 - Got Bicycle
	ds 1

wPokemonTower2Flags:: 
; bit 6 - Pokemon Tower Rival On Left
; bit 7 - Beat Rival in Pokemon Tower
	ds 1

wPokemonTower3Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
	ds 1

wPokemonTower4Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
	ds 1

wPokemonTower5Flags:: 
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 7 - In Purified Protected Zone
	ds 1

wPokemonTower6Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 7 - Ghost Marowak
	ds 1

wPokemonTower7Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 7 - Rescued Mr Fuji 2
	ds 1

wLavenderHouse1Flags:: 
; bit 0 - Got Pokeflute
	ds 1

wFanClubFlags:: 
; bit 1 - Got Bike Voucher
; bit 6 - Brag About Seel
; bit 7 - Brag About Pikachu
	ds 1

wVermilionGymFlags:: 
; bit 0 - 2nd Lock Opened
; bit 1 - 1st Lock Opened
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 6 - Got TM24
; bit 7 - Beat Lt. Surge
	ds 1

wCeladonCityFlags:: 
; bit 0 - Got TM41
	ds 1

wCeladonMartFlags:: 
; bit 4 - Got TM13
; bit 5 - Got TM48
; bit 6 - Got TM49
; bit 7 - Got TM18
	ds 1

wCeladonGymFlags:: 
; bit 0 - Got TM21
; bit 1 - Beat Erika
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wCeladonGymFlags2:: 
; bit 0 - Trainer Flag
	ds 1

wCeladonGameCornerFlags:: 
; bit 1 - Found Rocket Hideout
; bit 2 - Got 10 Coins
; bit 3 - Got 20 Coins
; bit 4 - Got 20 Coins 2
	ds 1

wCeladonDinerFlags:: 
; bit 0 - Got Coin Case
	ds 1

wFuchsiaHouse2Flags:: 
; bit 0 - Got HM04
; bit 1 - Gave Gold Teeth
	ds 1

wSafariZoneFlags:: 
; bit 6 - Safari Game Over
; bit 7 - In Safari Zone
	ds 1

wFuchsiaGymFlags:: 
; bit 0 - Got TM06
; bit 1 - Beat Koga
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wCinnabarMansionFlags:: 
; bit 0 - Mansion Switch On
	ds 1

wCinnabarMansionTrainerFlags:: 
; bit 1 - Trainer Flag
	ds 1

wCinnabarGymFlags:: 
; bit 0 - Got TM38
; bit 1 - Beat Blaine
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wCinnabarGymFlags2:: 
; bit 0 - Trainer Flag
	ds 1

wCinnabarGymGateFlags:: 
; bit 0 - (Nonexistant) Gate Flag
; bit 1 - Gate Flag
; bit 2 - Gate Flag
; bit 3 - Gate Flag
; bit 4 - Gate Flag
; bit 5 - Gate Flag
; bit 6 - Gate Flag
	ds 1

wCinnabarLabItemFlags:: 
; bit 7 - Got TM35
	ds 1

wCinnabarLabFossilFlags:: 
; bit 0 - Gave Fossil To Lab
; bit 1 - Lab Still Reviving Fossil
; bit 2 - Lab Handing Over Fossil Now
	ds 1

wCopyCatFlags:: 
; bit 0 - Got TM31
	ds 1

wFightingDojoFlags:: 
; bit 0 - Defeated Fighting Dojo
; bit 1 - Beat karate Master
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Got Hitmonlee
; bit 7 - Got Hitmonchan
	ds 1

wSaffronGymFlags:: 
; bit 0 - Got TM46
; bit 1 - Beat Sabrina
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wSaffronGymFlags2:: 
; bit 0 - Trainer Flag
	ds 1

wSilphCo1Flags:: 
; bit 7 - Silph Co Receptionist At Desk
	ds 1

wSaffronHouse2Flags:: 
; bit 0 - Got TM29
	ds 1

wRoute1Flags:: 
; bit 0 - Got Potion Sample
	ds 1

wRoute2GateFlags:: 
; bit 0 - Got HM05
	ds 1

wRoute3Flags:: ; actually 2 bytes this time
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
	ds 1

wRoute4Flags:: 
; bit 2 - Trainer Flag
	ds 1

wMtMoonPokecenterFlags:: 
; bit 7 - Bought Magikarp
	ds 1

wRoute6Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
	ds 1

wRoute8Flags:: ; actually 2 bytes
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
	ds 2

wRoute9Flags:: ; actually 2 bytes
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
	ds 2

wRoute10Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
	ds 1

wRockTunnel1Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wPowerPlantFlags:: ; actually 2 bytes
; bit 1 - Voltorb Flag
; bit 2 - Voltorb Flag
; bit 3 - Voltorb Flag
; bit 4 - Voltorb Flag
; bit 5 - Voltorb Flag
; bit 6 - Voltorb Flag
; bit 7 - Voltorb Flag
; bit 0 - Voltorb Flag
; bit 1 - Beat Zapdos
	ds 2

wRoute11Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wRoute11Flags2:: 
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 7 - Got Itemfinder
	ds 1

wRoute12Flags:: 
; bit 0 - Got TM39
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
	ds 1

wRoute12Flags2:: 
; bit 0 - Trainer Flag
; bit 6 - Fight Route 12 Snorlax
; bit 7 - Beat Route 12 Snorlax
	ds 1

wRoute13Flags:: ; actually 2 bytes
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
	ds 2

wRoute14Flags:: ; actually 2 bytes
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
	ds 2

wRoute15Flags:: ; actually 2 bytes
; bit 0 - Received EXP Share
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
; bit 7 - Trainer Flag
; bit 0 - Trainer Flag
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
	ds 2

wRoute16Flags:: 
; bit 1 - Trainer Flag
; bit 2 - Trainer Flag
; bit 3 - Trainer Flag
; bit 4 - Trainer Flag
; bit 5 - Trainer Flag
; bit 6 - Trainer Flag
	ds 1

wRoute16Flags2:: 
; bit 0 - Fight Route 16 Snorlax
; bit 1 - Beat Route 16 Snorlax
; bit 6 - Got HM02
; bit 7 - Rescued Mr. Fuji
	ds 1

wd7e1:: ds 2
wd7e3:: ds 1
wd7e5:: ds 2
wd7e7:: ds 1
wd7e8:: ds 1
wd7e9:: ds 2
wd7eb:: ds 1
wd7ed:: ds 1
wd7ee:: ds 1
wd7ef:: ds 1
wd7f0:: ds 1
wd7f1:: ds 1
wd7f2:: ds 1
wd7f3:: ds 1
wd7f5:: ds 1
wd7f6:: ds 1
wd7ff:: ds 1
wd803:: ds 1
wd805:: ds 1
wd807:: ds 1
wd809:: ds 1
wd813:: ds 1
wd815:: ds 1
wd816:: ds 1
wd817:: ds 1
wd819:: ds 1
wd81b:: ds 1
wd825:: ds 1
wd826:: ds 1
wd827:: ds 1
wd828:: ds 1
wd829:: ds 1
wd82a:: ds 1
wd82b:: ds 1
wd82c:: ds 1
wd82d:: ds 1
wd82e:: ds 1
wd82f:: ds 1
wd830:: ds 1
wd831:: ds 1
wd832:: ds 1
wd833:: ds 1
wd834:: ds 1
wd835:: ds 1
wd836:: ds 1
wd837:: ds 1
wd838:: ds 1
wd847:: ds 1
wd849:: ds 1
wd84b:: ds 1
wd857:: ds 1
wd85f:: ds 1
wd863:: ds 1
wd864:: ds 1
wd865:: ds 1
wd866:: ds 1
wd867:: ds 1
wd869:: ds 1
wd87d:: ds 2
wd87f:: ds 1
wd880:: ds 1
wd881:: ds 1
wd882:: ds 1

wLinkEnemyTrainerName:: ; d887
; linked game's trainer name
; TODO: Make this the same as wCurTrainerName
wGrassRate:: ; d887
; TODO: Don't load the whole table to RAM, just figure one out and load it like Headbutt does
	ds 1

wGrassMons:: ; d888
	;ds 20
	ds 11
; overload grassmons
wSerialEnemyDataBlock::
	ds 9

wEnemyPartyCount:: ds 1     ; d89c
wEnemyPartyMons::  ds PARTY_LENGTH + 1 ; d89d

wWaterRate:: db
wWaterMons:: db

; overload water rate
	ds wWaterRate - @

wEnemyMons:: ; d8a4
wEnemyMon1:: party_struct wEnemyMon1
wEnemyMon2:: party_struct wEnemyMon2
wEnemyMon3:: party_struct wEnemyMon3
wEnemyMon4:: party_struct wEnemyMon4
wEnemyMon5:: party_struct wEnemyMon5
wEnemyMon6:: party_struct wEnemyMon6

wEnemyMonOT::    ds 11 * PARTY_LENGTH
wEnemyMonNicks:: ds 11 * PARTY_LENGTH
wEnemyMonsEnd::

wTrainerHeaderPtr:: ; da30
	ds 2

; unused?
	ds 6

wOpponentAfterWrongAnswer::
	ds 1

wCurMapScript:: ; da39
; index of current map script, mostly used as index for function pointer array
; mostly copied from map-specific map script pointer and wirtten back later
	ds 1

; unused?
	ds 7

wPlayTimeHours:: ; da40
	ds 1
wPlayTimeMaxed::
	ds 1
wPlayTimeMinutes:: ; da42
	ds 1
wPlayTimeSeconds:: ; da44
	ds 1
wPlayTimeFrames:: ; da45
	ds 1

wSafariZoneGameOver:: ; da46
	ds 1

wNumSafariBalls:: ; da47
	ds 1

wBerryTreeFlags::
	ds 2
wBerryStepCounter:: ; deee
	ds 2

wDayCareInUse:: ; da48
; bit 0 - Mon with Day Care Lady
; bit 1 - Mon with Day Care Man
; bit 2 - Egg waiting at Day Care
	ds 1

wDayCareMonName:: ds 11 ; Lady
wDayCareMonOT::   ds 11 ; Lady

wDayCareMon:: box_struct wDayCareMon ; Lady

wDayCareMon2Name:: ds 11 ; Man
wDayCareMon2OT::   ds 11 ; Man

wDayCareMon2:: box_struct wDayCareMon2 ; Man

wMainDataEnd::


wBoxDataStart::

wNumInBox::  ds 1 ; da80
wBoxSpecies:: ds MONS_PER_BOX + 1

wBoxMons::
wBoxMon1:: box_struct wBoxMon1 ; da96
wBoxMon2:: ds box_struct_length * (MONS_PER_BOX + -1) ; dab7

wBoxMonOT::    ds 11 * MONS_PER_BOX ; dd2a
wBoxMonNicks:: ds 11 * MONS_PER_BOX ; de06
wBoxMonNicksEnd:: ; dee2

wBoxDataEnd::

wEXPBarPixelLength:: ds 1
wEXPBarBaseEXP:: ds 3
wEXPBarCurEXP:: ds 3
wEXPBarNeededEXP:: ds 3
wEXPBarKeepFullFlag:: ds 1
	
SECTION "Stack", WRAMX[$dfff], BANK[1]
wStack:: ; dfff
	ds -$100


INCLUDE "sram.asm"
