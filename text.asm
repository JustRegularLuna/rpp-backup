
TEXT_1  EQU $20
TEXT_2  EQU $21
TEXT_3  EQU $22
TEXT_4  EQU $23
TEXT_5  EQU $24
TEXT_6  EQU $25
TEXT_7  EQU $26
TEXT_8  EQU $27
TEXT_9  EQU $28
TEXT_10 EQU $29
TEXT_11 EQU $2a

POKEDEX_TEXT   EQU $2b
POKEDEX_TEXT_2 EQU $32
MOVE_NAMES     EQU $2c

INCLUDE "macros.asm"



SECTION "Text 1", ROMX, BANK[TEXT_1]

_CardKeySuccessText1:: ; 80000 (20:4000)
	text "Bingo!@@"

_CardKeySuccessText2:: ; 80009 (20:4009)
	db $0
	line "The Card Key"
	cont "opened the door!"
	done

_CardKeyFailText:: ; 80029 (20:4029)
	text "Darn! It needs a"
	line "Card Key!"
	done

_TrainerNameText:: ; 80045 (20:4045)
	TX_RAM W_TRAINERNAME
	text ": @@"

_NoNibbleText:: ; 8004d (20:404d)
	text "Not even a nibble!"
	prompt

_NothingHereText:: ; 80061 (20:4061)
	text "Looks like there's"
	line "nothing here."
	prompt

_ItsABiteText:: ; 80082 (20:4082)
	text "Oh!"
	line "It's a bite!"
	prompt

_ExclamationText:: ; 80093 (20:4093)
	text "!"
	done

_GroundRoseText:: ; 80096 (20:4096)
	text "Ground rose up"
	line "somewhere!"
	done

_BoulderText:: ; 800b1 (20:40b1)
	text "This requires"
	line "Strength to move!"
	done

_MartSignText:: ; 800d2 (20:40d2)
	text "All your item"
	line "needs fulfilled!"
	cont "#mon Mart"
	done

_PokeCenterSignText:: ; 800fc (20:40fc)
	text "Heal your #mon!"
	line "#mon Center"
	done

_FoundItemText:: ; 80119 (20:4119)
	text "[PLAYER] found"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_NoMoreRoomForItemText:: ; 8012a (20:412a)
	text "No more room for"
	line "items!"
	done

_OaksAideHiText:: ; 80143 (20:4143)
	text "Hi! Remember me?"
	line "I'm Prof.Oak's"
	cont "Aide!"

	para "If you caught @"
	TX_NUM $ffdb, 1, 3
	db $0
	line "kinds of #mon,"
	cont "I'm supposed to"
	cont "give you this"
	cont "@"
	TX_RAM wcc5b
	text "!"

	para "So, [PLAYER]! Have"
	line "you caught at"
	cont "least @"
	TX_NUM $ffdb, 1, 3
	text " kinds of"
	cont "#mon?"
	done

_OaksAideUhOhText:: ; 801e4 (20:41e4)
	text "Let's see..."
	line "Uh-oh! You have"
	cont "caught only @"
	TX_NUM $ffdd, 1, 3
	db $0
	cont "kinds of #mon!"

	para "You need @"
	TX_NUM $ffdb, 1, 3
	text " kinds"
	line "if you want the"
	cont "@"
	TX_RAM wcc5b
	text "."
	done

_OaksAideComeBackText:: ; 80250 (20:4250)
	text "Oh. I see."

	para "When you get @"
	TX_NUM $ffdb, 1, 3
	db $0
	line "kinds, come back"
	cont "for @"
	TX_RAM wcc5b
	text "."
	done

_OaksAideHereYouGoText:: ; 8028c (20:428c)
	text "Great! You have"
	line "caught @"
	TX_NUM $ffdd, 1, 3
	text " kinds "
	cont "of #mon!"
	cont "Congratulations!"

	para "Here you go!"
	prompt

_OaksAideGotItemText:: ; 802d9 (20:42d9)
	text "[PLAYER] got the"
	line "@"
	TX_RAM wcc5b
	text "!@@"

_OaksAideNoRoomText:: ; 802ec (20:42ec)
	text "Oh! I see you"
	line "don't have any"
	cont "room for the"
	cont "@"
	TX_RAM wcc5b
	text "."
	done

INCLUDE "text/maps/viridian_forest.asm"
INCLUDE "text/maps/mt_moon_1f.asm"
INCLUDE "text/maps/mt_moon_b1f.asm"
INCLUDE "text/maps/mt_moon_b2f.asm"
INCLUDE "text/maps/ss_anne_1.asm"
INCLUDE "text/maps/ss_anne_2.asm"
INCLUDE "text/maps/ss_anne_3.asm"
INCLUDE "text/maps/ss_anne_4.asm"
INCLUDE "text/maps/ss_anne_5.asm"
INCLUDE "text/maps/ss_anne_6.asm"
INCLUDE "text/maps/ss_anne_7.asm"
INCLUDE "text/maps/ss_anne_8.asm"
INCLUDE "text/maps/ss_anne_9.asm"
INCLUDE "text/maps/ss_anne_10.asm"
INCLUDE "text/maps/victory_road_3f.asm"
INCLUDE "text/maps/rocket_hideout_b1f.asm"
INCLUDE "text/maps/rocket_hideout_b2f.asm"
INCLUDE "text/maps/rocket_hideout_b3f.asm"
INCLUDE "text/maps/rocket_hideout_b4f.asm"
INCLUDE "text/maps/rocket_hideout_elevator.asm"
INCLUDE "text/maps/silph_co_2f.asm"
INCLUDE "text/maps/silph_co_3f.asm"
INCLUDE "text/maps/silph_co_4f.asm"
INCLUDE "text/maps/silph_co_5f_1.asm"


SECTION "Text 2", ROMX, BANK[TEXT_2]

INCLUDE "text/maps/silph_co_5f_2.asm"
INCLUDE "text/maps/silph_co_6f.asm"
INCLUDE "text/maps/silph_co_7f.asm"
INCLUDE "text/maps/silph_co_8f.asm"
INCLUDE "text/maps/silph_co_9f.asm"
INCLUDE "text/maps/silph_co_10f.asm"
INCLUDE "text/maps/silph_co_11f.asm"
INCLUDE "text/maps/mansion_2f.asm"
INCLUDE "text/maps/mansion_3f.asm"
INCLUDE "text/maps/mansion_b1f.asm"
INCLUDE "text/maps/safari_zone_east.asm"
INCLUDE "text/maps/safari_zone_north.asm"
INCLUDE "text/maps/safari_zone_west.asm"
INCLUDE "text/maps/safari_zone_center.asm"
INCLUDE "text/maps/safari_zone_rest_house_1.asm"
INCLUDE "text/maps/safari_zone_secret_house.asm"
INCLUDE "text/maps/safari_zone_rest_house_2.asm"
INCLUDE "text/maps/safari_zone_rest_house_3.asm"
INCLUDE "text/maps/safari_zone_rest_house_4.asm"
INCLUDE "text/maps/unknown_dungeon_1f.asm"
INCLUDE "text/maps/unknown_dungeon_2f.asm"
INCLUDE "text/maps/unknown_dungeon_b1f.asm"
INCLUDE "text/maps/victory_road_1f.asm"
INCLUDE "text/maps/lance.asm"
INCLUDE "text/maps/hall_of_fame.asm"
INCLUDE "text/maps/champion.asm"
INCLUDE "text/maps/lorelei.asm"
INCLUDE "text/maps/bruno.asm"
INCLUDE "text/maps/agatha.asm"
INCLUDE "text/maps/rock_tunnel_b2f_1.asm"


SECTION "Text 3", ROMX, BANK[TEXT_3]

INCLUDE "text/maps/rock_tunnel_b2f_2.asm"
INCLUDE "text/maps/seafoam_islands_1f.asm"
INCLUDE "text/maps/seafoam_islands_b1f.asm"
INCLUDE "text/maps/seafoam_islands_b2f.asm"
INCLUDE "text/maps/seafoam_islands_b3f.asm"
INCLUDE "text/maps/seafoam_islands_b4f.asm"
INCLUDE "text/maps/move_relearner.asm"
INCLUDE "text/maps/move_deleter.asm"
INCLUDE "text/maps/move_tutor.asm"

_AIBattleWithdrawText:: ; 880be (22:40be)
	TX_RAM W_TRAINERNAME
	text " @"
	TX_RAM wCurTrainerName
	db $0
	line "withdrew"
	cont "@"
	TX_RAM wEnemyMonNick
	text "!"
	prompt

_AIBattleUseItemText:: ; 880d5 (22:40d5)
	TX_RAM W_TRAINERNAME
	text " @"
	TX_RAM wCurTrainerName
	db $0
	line "used @"
	TX_RAM wcd6d
	db $0
	cont "on @"
	TX_RAM wEnemyMonNick
	text "!"
	prompt

_TradeWentToText:: ; 880ef (22:40ef)
	TX_RAM wcf4b
	text " went"
	line "to @"
	TX_RAM W_GRASSRATE
	text "."
	done

_TradeForText:: ; 88103 (22:4103)
	text "For [PLAYER]'s"
	line "@"
	TX_RAM wcf4b
	text ","
	done

_TradeSendsText:: ; 88112 (22:4112)
	TX_RAM W_GRASSRATE
	text " sends"
	line "@"
	TX_RAM wcd6d
	text "."
	done

_TradeWavesFarewellText:: ; 88124 (22:4124)
	TX_RAM W_GRASSRATE
	text " waves"
	line "farewell as"
	done

_TradeTransferredText:: ; 8813b (22:413b)
	TX_RAM wcd6d
	text " is"
	line "transferred."
	done

_TradeTakeCareText:: ; 88150 (22:4150)
	text "Take good care of"
	line "@"
	TX_RAM wcd6d
	text "."
	done

_TradeWillTradeText:: ; 8816a (22:416a)
	TX_RAM W_GRASSRATE
	text " will"
	line "trade @"
	TX_RAM wcd6d
	db $0
	done

_TradeforText:: ; 88180 (22:4180)
	text "for [PLAYER]'s"
	line "@"
	TX_RAM wcf4b
	text "."
	done

_PlaySlotMachineText:: ; 8818f (22:418f)
	text "A slot machine!"
	line "Want to play?"
	done

_OutOfCoinsSlotMachineText:: ; 881ae (22:41ae)
	text "Darn!"
	line "Ran out of coins!"
	done

_BetHowManySlotMachineText:: ; 881c7 (22:41c7)
	text "Bet how many"
	line "coins?"
	done

_StartSlotMachineText:: ; 881dc (22:41dc)
	text "Start!"
	done

_NotEnoughCoinsSlotMachineText:: ; 881e4 (22:41e4)
	text "Not enough"
	line "coins!"
	prompt

_OneMoreGoSlotMachineText:: ; 881f7 (22:41f7)
	text "One more "
	line "go?"
	done

_LinedUpText:: ; 88206 (22:4206)
	text " lined up!"
	line "Scored @"
	TX_RAM wcf4b
	text " coins!"
	done

_NotThisTimeText:: ; 88226 (22:4226)
	text "Not this time!"
	prompt

_YeahText:: ; 88236 (22:4236)
	text "Yeah!@@"

_DexSeenOwnedText:: ; 8823e (22:423e)
	text "#dex   Seen:@"
	TX_NUM wcc5b, 1, 3
	db $0
	line "         Owned:@"
	TX_NUM wcc5c, 1, 3
	db "@"

_DexRatingText:: ; 88267 (22:4267)
	text "#dex Rating", $6d
	done

_GymStatueText1:: ; 88275 (22:4275)
	TX_RAM wGymCityName
	db $0
	line "#mon Gym"
	cont "Leader: @"
	TX_RAM wGymLeaderName
	db $0

	para "Winning trainers:"
	line "[RIVAL]"
	done

_GymStatueText2:: ; 882a5 (22:42a5)
	TX_RAM wGymCityName
	db $0
	line "#mon Gym"
	cont "Leader: @"
	TX_RAM wGymLeaderName
	db $0

	para "Winning trainers:"
	line "[RIVAL]"
	cont "[PLAYER]"
	done

_ViridianCityPokecenterGuyText:: ; 882d7 (22:42d7)
	text "#mon Centers"
	line "heal your tired,"
	cont "hurt or fainted"
	cont "#mon!"
	done

_PewterCityPokecenterGuyText:: ; 8830c (22:430c)
	text "Yawn!"

	para "When Jigglypuff"
	line "sings, #mon"
	cont "get drowsy..."

	para "...Me too..."
	line "Snore..."
	done

_CeruleanPokecenterGuyText:: ; 88353 (22:4353)
	text "Bill has lots of"
	line "#mon!"

	para "He collects rare"
	line "ones too!"
	done

_LavenderPokecenterGuyText:: ; 88386 (22:4386)
	text "Cubones wear"
	line "skulls, right?"

	para "People will pay a"
	line "lot for one!"
	done

_MtMoonPokecenterBenchGuyText:: ; 883c2 (22:43c2)
	text "If you have too"
	line "many #mon, you"
	cont "should store them"
	cont "via PC!"
	done

_RockTunnelPokecenterGuyText:: ; 883fc (22:43fc)
	text "I heard that"
	line "Ghosts haunt"
	cont "Lavender Town!"
	done

_UnusedBenchGuyText1:: ; 88426 (22:4426)
	text "I wish I could"
	line "catch #mon."
	done

_UnusedBenchGuyText2:: ; 88442 (22:4442)
	text "I'm tired from"
	line "all the fun..."
	done

_UnusedBenchGuyText3:: ; 88460 (22:4460)
	text "Silph's manager"
	line "is hiding in the"
	cont "Safari Zone."
	done

_VermilionPokecenterGuyText:: ; 8848e (22:448e)
	text "It is true that a"
	line "higher level"
	cont "#mon will be"
	cont "more powerful..."

	para "But, all #mon"
	line "will have weak"
	cont "points against"
	cont "specific types."

	para "So, there is no"
	line "universally"
	cont "strong #mon."
	done

_CeladonCityPokecenterGuyText:: ; 88531 (22:4531)
	text "If I had a Bike,"
	line "I would go to"
	cont "Cycling Road!"
	done

_FuchsiaCityPokecenterGuyText:: ; 8855f (22:455f)
	text "If you're studying "
	line "#mon, visit"
	cont "the Safari Zone."

	para "It has all sorts"
	line "of rare #mon."
	done

_CinnabarPokecenterGuyText:: ; 885af (22:45af)
	text "#mon can still"
	line "learn techniques"
	cont "after canceling"
	cont "evolution."

	para "Evolution can wait"
	line "until new moves"
	cont "have been learned."
	done

_SaffronCityPokecenterGuyText1:: ; 88621 (22:4621)
	text "It would be great"
	line "if the Elite Four"
	cont "came and stomped"
	cont "Team Rocket!"
	done

_SaffronCityPokecenterGuyText2:: ; 88664 (22:4664)
	text "Team Rocket took"
	line "off! We can go"
	cont "out safely again!"
	cont "That's great!"
	done

_CeladonCityHotelText:: ; 886a4 (22:46a4)
	text "My sis brought me"
	line "on this vacation!"
	done

_BookcaseText:: ; 886c9 (22:46c9)
	text "Crammed full of"
	line "#mon books!"
	done

_NewBicycleText:: ; 886e6 (22:46e6)
	text "A shiny new"
	line "Bicycle!"
	done

_PushStartText:: ; 886fc (22:46fc)
	text "Push Start to"
	line "open the Menu!"
	done

_SaveOptionText:: ; 8871a (22:471a)
	text "The Save option is"
	line "on the Menu"
	cont "screen."
	done

_StrengthsAndWeaknessesText:: ; 88742 (22:4742)
	text "All #mon types"
	line "have strong and"
	cont "weak points"
	cont "against others."
	done

_TimesUpText:: ; 8877e (22:477e)
	text "PA: Ding-dong!"

	para "Time's up!"
	prompt

_GameOverText:: ; 88798 (22:4798)
	text "PA: Your Safari"
	line "Game is over!"
	done

INCLUDE "text/quizzes.asm"

_MagazinesText:: ; 889a1 (22:49a1)
	text "#mon magazines!"

	para "#mon notebooks!"

	para "#mon graphs!"
	done

_BillsHouseMonitorText:: ; 889cf (22:49cf)
	text "Teleporter is"
	line "displayed on the"
	cont "PC monitor."
	done

_BillsHouseInitiatedText:: ; 889fb (22:49fb)
	text "[PLAYER] initiated"
	line "Teleporter's Cell"
	cont "Separator!@@"

_BillsHousePokemonListText1:: ; 88a25 (22:4a25)
	text "Bill's favorite"
	line "#mon list!"
	prompt

_BillsHousePokemonListText2:: ; 88a40 (22:4a40)
	text "Which #mon do"
	line "you want to see?"
	done

_OakLabEmailText:: ; 88a60 (22:4a60)
	text "There's an e-mail"
	line "message here!"

	para "..."

	para "Calling all"
	line "#mon trainers!"

	para "The elite trainers"
	line "of #mon League"
	cont "are ready to take"
	cont "on all comers!"

	para "Bring your best"
	line "#mon and see"
	cont "how you rate as a"
	cont "trainer!"

	para "#mon League HQ"
	line "Indigo Plateau"

	para "PS: Prof.Oak,"
	line "please visit us!"
	cont "..."
	done

_GameCornerCoinCaseText:: ; 88b5b (22:4b5b)
	text "A Coin Case is"
	line "required!"
	done

_GameCornerNoCoinsText:: ; 88b75 (22:4b75)
	text "You don't have"
	line "any coins!"
	done

_GameCornerOutOfOrderText:: ; 88b8f (22:4b8f)
	text "OUT OF ORDER"
	line "This is broken."
	done

_GameCornerOutToLunchText:: ; 88bad (22:4bad)
	text "OUT TO LUNCH"
	line "This is reserved."
	done

_GameCornerSomeonesKeysText:: ; 88bcd (22:4bcd)
	text "Someone's keys!"
	line "They'll be back."
	done

_JustAMomentText:: ; 88bed (22:4bed)
	text "Just a moment."
	done

TMNotebookText:: ; 88bfd (22:4bfd)
	text "It's a pamphlet"
	line "on TMs."

	para "..."

	para "There are 50 TMs"
	line "in all."

	para "There are also 5"
	line "HMs that can be"
	cont "used repeatedly."

	para "Silph Co.@@"

_TurnPageText:: ; 88c6f (22:4c6f)
	text "Turn the page?"
	done

_ViridianSchoolNotebookText5:: ; 88c7f (22:4c7f)
	text "Girl: Hey! Don't"
	line "look at my notes!@@"

_ViridianSchoolNotebookText1:: ; 88ca3 (22:4ca3)
	text "Looked at the"
	line "notebook!"

	para "First page..."

	para "# Balls are"
	line "used to catch"
	cont "#mon."

	para "Up to 6 #mon"
	line "can be carried."

	para "People who raise"
	line "and make #mon"
	cont "fight are called"
	cont "#mon trainers."
	prompt

_ViridianSchoolNotebookText2:: ; 88d46 (22:4d46)
	text "Second page..."

	para "A healthy #mon"
	line "may be hard to"
	cont "catch, so weaken"
	cont "it first!"

	para "Poison, burns and"
	line "other damage are"
	cont "effective!"
	prompt

_ViridianSchoolNotebookText3:: ; 88dbd (22:4dbd)
	text "Third page..."

	para "#mon trainers"
	line "seek others to"
	cont "engage in #mon"
	cont "fights."

	para "Battles are"
	line "constantly fought"
	cont "at #mon Gyms."
	prompt

_ViridianSchoolNotebookText4:: ; 88e2c (22:4e2c)
	text "Fourth page..."

	para "The goal for"
	line "#mon trainers"
	cont "is to beat the "
	cont "top 8 #mon"
	cont "Gym Leaders."

	para "Do so to earn the"
	line "right to face..."

	para "The Elite Four of"
	line "#mon League!"
	prompt

_FightingDojoText_52a10:: ; 88ec1 (22:4ec1)
	text "Enemies on every"
	line "side!"
	done

_FightingDojoText_52a1d:: ; 88ed9 (22:4ed9)
	text "What goes around"
	line "comes around!"
	done

_FightingDojoText:: ; 88ef9 (22:4ef9)
	text "Fighting Dojo"
	done

_IndigoPlateauHQText:: ; 88f08 (22:4f08)
	text "Indigo Plateau"
	line "#mon League HQ"
	done

_RedBedroomSNESText:: ; 88f27 (22:4f27)
	text "[PLAYER] is"
	line "playing the SNES!"
	cont "...Okay!"
	cont "It's time to go!"
	done

_Route15UpstairsBinocularsText:: ; 88f58 (22:4f58)
	text "Looked into the"
	line "binoculars..."

	para "A large, shining"
	line "bird is flying"
	cont "toward the sea."
	done

_AerodactylFossilText:: ; 88fa7 (22:4fa7)
	text "Aerodactyl Fossil"
	line "A primitive and"
	cont "rare #mon."
	done

_KabutopsFossilText:: ; 88fd5 (22:4fd5)
	text "Kabutops Fossil"
	line "A primitive and"
	cont "rare #mon."
	done

_LinkCableHelpText1:: ; 89001 (22:5001)
	text "Trainer Tips"

	para "Using a Game Link"
	line "Cable"
	prompt

_LinkCableHelpText2:: ; 89027 (22:5027)
	text "Which heading do"
	line "you want to read?"
	done

_LinkCableInfoText1:: ; 8904b (22:504b)
	text "When you have"
	line "linked your Game"
	cont "Boy with another"
	cont "Game Boy, talk to"
	cont "the attendant on"
	cont "the right in any"
	cont "#mon Center."
	prompt

_LinkCableInfoText2:: ; 890bd (22:50bd)
	text "Colosseum lets"
	line "you play against"
	cont "a friend."
	prompt

_LinkCableInfoText3:: ; 890e8 (22:50e8)
	text "Trade Center is"
	line "used for trading"
	cont "#mon."
	prompt

_ViridianSchoolBlackboardText1:: ; 89110 (22:5110)
	text "The blackboard"
	line "describes #mon"
	cont "Status changes"
	cont "during battles."
	prompt

_ViridianSchoolBlackboardText2:: ; 8914e (22:514e)
	text "Which heading do"
	line "you want to read?"
	done

_ViridianBlackboardSleepText:: ; 89172 (22:5172)
	text "A #mon can't"
	line "attack if it's"
	cont "asleep!"

	para "#mon will stay"
	line "asleep even after"
	cont "battles."

	para "Use Awakening to"
	line "wake them up!"
	prompt

_ViridianBlackboardPoisonText:: ; 891de (22:51de)
	text "When poisoned, a"
	line "#mon's health"
	cont "steadily drops."

	para "Poison lingers"
	line "after battles."

	para "Use an Antidote"
	line "to cure poison!"
	prompt

_ViridianBlackbaordPrlzText:: ; 8924b (22:524b)
	text "Paralysis could"
	line "make #mon"
	cont "moves misfire!"

	para "Paralysis remains"
	line "after battles."

	para "Use ParalyzeHeal"
	line "for treatment!"
	prompt

_ViridianBlackboardBurnText:: ; 892b5 (22:52b5)
	text "A burn reduces"
	line "power and speed."
	cont "It also causes"
	cont "ongoing damage."

	para "Burns remain"
	line "after battles."

	para "Use Burn Heal to"
	line "cure a burn!"
	prompt

_ViridianBlackboardFrozenText:: ; 8932f (22:532f)
	text "If frozen, a"
	line "#mon becomes"
	cont "totally immobile!"

	para "It stays frozen"
	line "even after the"
	cont "battle ends."

	para "Use Ice Heal to"
	line "thaw out #mon!"
	prompt

_VermilionGymTrashText:: ; 893a7 (22:53a7)
	text "Nope, there's"
	line "only trash here."
	done

_VermilionGymTrashSuccesText1:: ; 893c6 (22:53c6)
	text "Hey! There's a"
	line "switch under the"
	cont "trash!"
	cont "Turn it on!"

	para "The 1st electric"
	line "lock opened!@@"

_VermilionGymTrashSuccesText2:: ; 89418 (22:5418)
	text "Hey! There's"
	line "another switch"
	cont "under the trash!"
	cont "Turn it on!"
	prompt

_VermilionGymTrashSuccesText3:: ; 89451 (22:5451)
	text "The 2nd electric"
	line "lock opened!"

	para "The motorized door"
	line "opened!@@"

_VermilionGymTrashFailText:: ; 8948c (22:548c)
	text "Nope! There's"
	line "only trash here."
	cont "Hey! The electric"
	cont "locks were reset!@@"

_FoundHiddenItemText:: ; 894d0 (22:54d0)
	text "[PLAYER] found"
	line "@"
	TX_RAM wcd6d
	text "!@@"

_HiddenItemBagFullText:: ; 894e1 (22:54e1)
	text "But, [PLAYER] has"
	line "no more room for"
	cont "other items!"
	done

_FoundHiddenCoinsText:: ; 8950b (22:550b)
	text "[PLAYER] found"
	line "@"
	TX_BCD $ffa0, $c2
	text " coins!@@"

_FoundHiddenCoins2Text:: ; 89523 (22:5523)
	text "[PLAYER] found"
	line "@"
	TX_BCD $ffa0, $c2
	text " coins!@@"

_DroppedHiddenCoinsText:: ; 8953b (22:553b)
	db $0
	para "Oops! Dropped"
	line "some coins!"
	done

_IndigoPlateauStatuesText1:: ; 89557 (22:5557)
	text "Indigo Plateau"
	prompt

_IndigoPlateauStatuesText2:: ; 89567 (22:5567)
	text "The ultimate goal"
	line "of trainers!"
	cont "#mon League HQ"
	done

_IndigoPlateauStatuesText3:: ; 89596 (22:5596)
	text "The highest"
	line "#mon authority"
	cont "#mon League HQ"
	done

_PokemonBooksText:: ; 895c1 (22:55c1)
	text "Crammed full of"
	line "#mon books!"
	done

_DiglettSculptureText:: ; 895de (22:55de)
	text "It's a sculpture"
	line "of Diglett."
	done

_ElevatorText:: ; 895fb (22:55fb)
	text "This is an"
	line "elevator."
	done

_TownMapText:: ; 89611 (22:5611)
	text "A Kanto map.@@"

_PokemonStuffText:: ; 8961f (22:561f)
	text "Wow! Tons of"
	line "#mon stuff!"
	done

_OutOfSafariBallsText:: ; 89639 (22:5639)
	text "PA: Ding-dong!"

	para "You are out of"
	line "Safari Balls!"
	prompt

_WildRanText:: ; 89666 (22:5666)
	text "Wild @"
	TX_RAM wEnemyMonNick
	db $0
	line "ran!"
	prompt

_EnemyRanText:: ; 89677 (22:5677)
	text "Enemy @"
	TX_RAM wEnemyMonNick
	db $0
	line "ran!"
	prompt

_HurtByPoisonText:: ; 89689 (22:5689)
	text $5a, "'s"
	line "hurt by poison!"
	prompt

_HurtByBurnText:: ; 8969d (22:569d)
	text $5a, "'s"
	line "hurt by the burn!"
	prompt

_HurtByLeechSeedText:: ; 896b3 (22:56b3)
	text "Leech Seed saps"
	line $5a, "!"
	prompt

_EnemyMonFaintedText:: ; 0x896c7
	text "Enemy @"
	TX_RAM wEnemyMonNick
	db $0
	line "fainted!"
	prompt

_MoneyForWinningText:: ; 896dd (22:56dd)
	text "[PLAYER] got ¥@"
	TX_BCD wd079, $c3
	db $0
	line "for winning!"
	prompt

_TrainerDefeatedText:: ; 896f9 (22:56f9)
	TX_RAM W_TRAINERNAME ; 0x89706
	text " @"
	TX_RAM wCurTrainerName
	db $0
	line "was defeated!"
	prompt

_PlayerMonFaintedText:: ; 8970c (22:570c)
	TX_RAM wBattleMonNick
	db $0
	line "fainted!"
	prompt

_UseNextMonText:: ; 8971a (22:571a)
	text "Use next #mon?"
	done

_Sony1WinText:: ; 8972a (22:572a)
	text "[RIVAL]: Yeah! Am"
	line "I great or what?"
	prompt

_PlayerBlackedOutText2:: ; 89748 (22:5748)
	text "[PLAYER] is out of"
	line "useable #mon!"

	para "[PLAYER] blacked"
	line "out!"
	prompt

_LinkBattleLostText:: ; 89772 (22:5772)
	text "[PLAYER] lost to"
	line "@"
	TX_RAM W_TRAINERNAME ; 0x8977e
	text "!"
	prompt

_TrainerAboutToUseText:: ; 89784 (22:5784)
	TX_RAM W_TRAINERNAME
	text " @"
	TX_RAM wCurTrainerName
	db $0
	line "is about to use"
	cont"@"
	TX_RAM wEnemyMonNick
	text "!"

	para "Will [PLAYER]"
	line "change #mon?"
	done

_TrainerSentOutText:: ; 897b4 (22:57b4)
	TX_RAM W_TRAINERNAME
	text " @"
	TX_RAM wCurTrainerName
	db $0
	line "sent out"
	cont "@"
	TX_RAM wEnemyMonNick
	text "!"
	done

_NoWillText:: ; 897c9 (22:57c9)
	text "There's no will"
	line "to fight!"
	prompt

_CantEscapeText:: ; 897e3 (22:57e3)
	text "Can't escape!"
	prompt

_NoRunningText:: ; 897f1 (22:57f1)
	text "No! There's no"
	line "running from a"
	cont "trainer battle!"
	prompt

_GotAwayText:: ; 8981f (22:581f)
	text "Got away safely!"
	prompt

_ItemsCantBeUsedHereText:: ; 89831 (22:5831)
	text "Items can't be"
	line "used here."
	prompt

_AlreadyOutText:: ; 8984b (22:584b)
	TX_RAM wBattleMonNick
	text " is"
	line "already out!"
	prompt

_MoveNoPPText:: ; 89860 (22:5860)
	text "No PP left for"
	line "this move!"
	prompt

_MoveDisabledText:: ; 8987b (22:587b)
	text "The move is"
	line "disabled!"
	prompt

_NoMovesLeftText:: ; 89892 (22:5892)
	TX_RAM wBattleMonNick
	text " has no"
	line "moves left!"
	done

_MultiHitText:: ; 898aa (22:58aa)
	text "Hit the enemy"
	line "@"
	TX_NUM wPlayerNumHits,1,1
	text " times!"
	prompt

_ScaredText:: ; 898c7 (22:58c7)
	TX_RAM wBattleMonNick
	text " is too"
	line "scared to move!"
	prompt

_GetOutText:: ; 898e3 (22:58e3)
	text "Ghost: Get out..."
	line "Get out..."
	prompt

_FastAsleepText:: ; 89901 (22:5901)
	text $5A
	line "is fast asleep!"
	prompt

_WokeUpText:: ; 89914 (22:5914)
	text $5A
	line "woke up!"
	prompt

_IsFrozenText:: ; 89920 (22:5920)
	text $5A
	line "is frozen solid!"
	prompt

_FullyParalyzedText:: ; 89934 (22:5934)
	text $5A,"'s"
	line "fully paralyzed!"
	prompt

_FlinchedText:: ; 89949 (22:5949)
	text $5A
	line "flinched!"
	prompt

_MustRechargeText:: ; 89956 (22:5956)
	text $5A
	line "must recharge!"
	prompt

_DisabledNoMoreText:: ; 89968 (22:5968)
	text $5A,"'s"
	line "disabled no more!"
	prompt

_IsConfusedText:: ; 8997e (22:597e)
	text $5A
	line "is confused!"
	prompt

_HurtItselfText:: ; 8998e (22:598e)
	text "It hurt itself in"
	line "its confusion!"
	prompt

_ConfusedNoMoreText:: ; 899b0 (22:59b0)
	text $5A,"'s"
	line "confused no more!"
	prompt

_SavingEnergyText:: ; 899c6 (22:59c6)
	text $5A
	line "is saving energy!"
	prompt

_UnleashedEnergyText:: ; 899db (22:59db)
	text $5A
	line "unleashed energy!"
	prompt

_ThrashingAboutText:: ; 899f0 (22:59f0)
	text $5A,"'s"
	line "thrashing about!"
	done

_AttackContinuesText:: ; 89a05 (22:5a05)
	text $5A,"'s"
	line "attack continues!"
	done

_CantMoveText:: ; 89a1b (22:5a1b)
	text $5A
	line "can't move!"
	prompt

_MoveIsDisabledText:: ; 89a29 (22:5a29)
	text $5a, "'s"
	line "@"
	TX_RAM wcd6d
	text " is"
	cont "disabled!"
	prompt

_MonName1Text:: ; 89a40 (22:5a40)
	text $5a, "@@"

_UsedText:: ; 89a44 (22:5a44)
	db $0
	line "used @@"

_InsteadText:: ; 89a56 (22:5a56)
	text "instead,"
	cont "@@"

_CF4BText:: ; 89a62 (22:5a62)
	TX_RAM wcf4b
	text "!"
	done

_AttackMissedText:: ; 89a76 (22:5a76)
	text $5a, "'s"
	line "attack missed!"
	prompt

_KeptGoingAndCrashedText:: ; 89a89 (22:5a89)
	text $5a
	line "kept going and"
	cont "crashed!"
	prompt

_UnaffectedText:: ; 89aa4 (22:5aa4)
	text $59, "'s"
	line "unaffected!"
	prompt

_DoesntAffectMonText:: ; 89ab4 (22:5ab4)
	text "It doesn't affect"
	line $59, "!"
	prompt

_CriticalHitText:: ; 89ac9 (22:5ac9)
	text "Critical hit!"
	prompt

_OHKOText:: ; 89ad8 (22:5ad8)
	text "One-hit KO!"
	prompt

_LoafingAroundText:: ; 89ae5 (22:5ae5)
	TX_RAM wBattleMonNick
	text " is"
	line "loafing around."
	prompt

_BeganToNapText:: ; 89afd (22:5afd)
	TX_RAM wBattleMonNick
	text " began"
	line "to nap!"
	prompt

_WontObeyText:: ; 89b10 (22:5b10)
	TX_RAM wBattleMonNick
	text " won't"
	line "obey!"
	prompt

_TurnedAwayText:: ; 89b20 (22:5b20)
	TX_RAM wBattleMonNick
	text " turned"
	line "away!"
	prompt

_IgnoredOrdersText:: ; 89b32 (22:5b32)
	TX_RAM wBattleMonNick
	db $0
	line "ignored orders!"
	prompt

_SubstituteTookDamageText:: ; 89b47 (22:5b47)
	text "The Substitute"
	line "took damage for"
	cont $59, "!"
	prompt

_SubstituteBrokeText:: ; 89b6a (22:5b6a)
	text $59, "'s"
	line "Substitute broke!"
	prompt

_BuildingRageText:: ; 89b80 (22:5b80)
	text $5a, "'s"
	line "Rage is building!"
	prompt

_MirrorMoveFailedText:: ; 89b96 (22:5b96)
	text "The Mirror Move"
	next "failed!"
	prompt

_HitXTimesText:: ; 89baf (22:5baf)
	text "Hit @"
	TX_NUM wEnemyNumHits, 1, 1
	text " times!"
	prompt

_GainedText:: ; 89bc2 (22:5bc2)
	TX_RAM wcd6d
	text " gained"
	line "@@"

_WithExpAllText:: ; 89bd0 (22:5bd0)
	text "[PLAYER]'s other"
        line "#mon gained"
        cont "Exp. Points from@"
	db $7
        text "the Exp. Share!"
        prompt

_BoostedText:: ; 89be1 (22:5be1)
	text "a boosted"
	cont "@@"
_ExpPointsText:: ; 89bee (22:5bee)
	TX_NUM wcf4b, 2, 4
	text " Exp. Points!"
	prompt

_GrewLevelText:: ; 89c01 (22:5c01)
	TX_RAM wcd6d
	text " grew"
	line "to level @"
	TX_NUM W_CURENEMYLVL, 1, 3
	text "!@@"

_WildMonAppearedText:: ; 89c1d (22:5c1d)
	text "Wild @"
	TX_RAM wEnemyMonNick
	db $0
	line "appeared!"
	prompt

_HookedMonAttackedText:: ; 89c33 (22:5c33)
	text "The hooked"
	line "@"
	TX_RAM wEnemyMonNick
	db $0
	cont "attacked!"
	prompt

_EnemyAppearedText:: ; 89c4f (22:5c4f)
	TX_RAM wEnemyMonNick
	db $0
	line "appeared!"
	prompt

_TrainerWantsToFightText:: ; 89c5e (22:5c5e)
	TX_RAM W_TRAINERNAME
	text " @"
	TX_RAM wCurTrainerName
	db $0
	line "wants to battle!"
	prompt

_UnveiledGhostText:: ; 89c73 (22:5c73)
	text "Silph Scope"
	line "unveiled the"
	cont "Ghost's identity!"
	prompt

_GhostCantBeIDdText:: ; 89c9e (22:5c9e)
	text "Darn! The Ghost"
	line "can't be ID'd!"
	prompt

_GoText:: ; 89cbc (22:5cbc)
	text "Go! @@"

_DoItText:: ; 89cc3 (22:5cc3)
	text "Do it! @@"

_GetmText:: ; 89ccd (22:5ccd)
	text "Get'm! @@"

_EnemysWeakText:: ; 89cd6 (22:5cd6)
	text "The enemy's weak!"
	line "Get'm! @@"

_PlayerMon1Text:: ; 89cf0 (22:5cf0)
	TX_RAM wBattleMonNick
	text "!"
	done

_PlayerMon2Text:: ; 89cf6 (22:5cf6)
	TX_RAM wBattleMonNick
	text " @@"

_EnoughText:: ; 89cfd (22:5cfd)
	text "enough!@@"

_OKExclamationText:: ; 89d07 (22:5d07)
	text "OK!@@"

_GoodText:: ; 89d0d (22:5d0d)
	text "good!@@"

_ComeBackText:: ; 89d15 (22:5d15)
	db $0
	line "Come back!"
	done

_SuperEffectiveText:: ; 89d22 (22:5d22)
	text "It's super"
	line "effective!"
	prompt

_NotVeryEffectiveText:: ; 89d38 (22:5d38)
	text "It's not very"
	line "effective..."
	prompt

_SafariZoneEatingText:: ; 89d53 (22:5d53)
	text "Wild @"
	TX_RAM wEnemyMonNick
	db $0
	line "is eating!"
	prompt

_SafariZoneAngryText:: ; 89d6a (22:5d6a)
	text "Wild @"
	TX_RAM wEnemyMonNick
	db $0
	line "is angry!"
	prompt

; money related
_PickUpPayDayMoneyText:: ; 89d80 (22:5d80)
	text "[PLAYER] picked up"
	line "¥@"
	TX_BCD wTotalPayDayMoney, $c3
	text "!"
	prompt

_ClearSaveDataText:: ; 89d96 (22:5d96)
	text "Clear all saved"
	line "data?"
	done

_WhichFloorText:: ; 89dad (22:5dad)
	text "Which floor do"
	line "you want? "
	done

_PartyMenuNormalText:: ; 89dc8 (22:5dc8)
	text "Choose a #mon."
	done

_PartyMenuItemUseText:: ; 89dd8 (22:5dd8)
	text "Use item on which"
	line "#mon?"
	done

_PartyMenuBattleText:: ; 89df1 (22:5df1)
	text "Bring out which"
	line "#mon?"
	done

_PartyMenuUseTMText:: ; 89e08 (22:5e08)
	text "Teach to which"
	line "#mon?"
	done

_PartyMenuSwapMonText:: ; 89e1f (22:5e1f)
	text "Move #mon"
	line "where?"
	done

_PotionText:: ; 89e31 (22:5e31)
	TX_RAM wcd6d
	db $0
	line "recovered by @"
	TX_NUM wHPBarHPDifference, 2, 3
	text "!"
	done

_AntidoteText:: ; 89e4b (22:5e4b)
	TX_RAM wcd6d
	text " was"
	line "cured of poison!"
	done

_ParlyzHealText:: ; 89e65 (22:5e65)
	TX_RAM wcd6d
	text "'s"
	line "rid of paralysis!"
	done

_BurnHealText:: ; 89e7d (22:5e7d)
	TX_RAM wcd6d
	text "'s"
	line "burn was healed!"
	done

_IceHealText:: ; 89e94 (22:5e94)
	TX_RAM wcd6d
	text " was"
	line "defrosted!"
	done

_AwakeningText:: ; 89ea8 (22:5ea8)
	TX_RAM wcd6d
	db $0
	line "woke up!"
	done

_FullHealText:: ; 89eb6 (22:5eb6)
	TX_RAM wcd6d
	text "'s"
	line "health returned!"
	done

_ReviveText:: ; 89ecd (22:5ecd)
	TX_RAM wcd6d
	db $0
	line "is revitalized!"
	done

_RareCandyText:: ; 89ee2 (22:5ee2)
	TX_RAM wcd6d
	text " grew"
	line "to level @"
	TX_NUM W_CURENEMYLVL, $1,$3
	text "!@@"

_TurnedOnPC1Text:: ; 89efe (22:5efe)
	text "[PLAYER] turned on"
	line "the PC."
	prompt

_AccessedBillsPCText:: ; 89f13 (22:5f13)
	text "Accessed Bill's"
	line "PC."

	para "Accessed #mon"
	line "Storage System."
	prompt

_AccessedSomeonesPCText:: ; 89f45 (22:5f45)
	text "Accessed someone's"
	line "PC."

	para "Accessed #mon"
	line "Storage System."
	prompt

_AccessedMyPCText:: ; 89f7a (22:5f7a)
	text "Accessed my PC."

	para "Accessed Item"
	line "Storage System."
	prompt

_TurnedOnPC2Text:: ; 89fa9 (22:5fa9)
	text "[PLAYER] turned on"
	line "the PC."
	prompt

_WhatDoYouWantText:: ; 89fbe (22:5fbe)
	text "What do you want"
	line "to do?"
	done

_WhatToDepositText:: ; 89fd7 (22:5fd7)
	text "What do you want"
	line "to deposit?"
	done

_DepositHowManyText:: ; 89ff5 (22:5ff5)
	text "How many?"
	done

_ItemWasStoredText:: ; 8a000 (22:6000)
	TX_RAM wcd6d
	text " was"
	line "stored via PC."
	prompt

_NothingToDepositText:: ; 8a018 (22:6018)
	text "You have nothing"
	line "to deposit."
	prompt

_NoRoomToStoreText:: ; 8a036 (22:6036)
	text "No room left to"
	line "store items."
	prompt

_WhatToWithdrawText:: ; 8a054 (22:6054)
	text "What do you want"
	line "to withdraw?"
	done

_WithdrawHowManyText:: ; 8a073 (22:6073)
	text "How many?"
	done

_WithdrewItemText:: ; 8a07e (22:607e)
	text "Withdrew"
	line "@"
	TX_RAM wcd6d
	text "."
	prompt

_NothingStoredText:: ; 8a08f (22:608f)
	text "There is nothing"
	line "stored."
	prompt

_CantCarryMoreText:: ; 8a0a9 (22:60a9)
	text "You can't carry"
	line "any more items."
	prompt

_WhatToTossText:: ; 8a0c9 (22:60c9)
	text "What do you want"
	line "to toss away?"
	done

_TossHowManyText:: ; 8a0e9 (22:60e9)
	text "How many?"
	done

_AccessedHoFPCText:: ; 8a0f4 (22:60f4)
	text "Accessed #mon"
	line "League's site."

	para "Accessed the Hall"
	line "of Fame List."
	prompt

_SwitchOnText:: ; 0x8a131
	text "Switch on!"
	prompt

_WhatText:: ; 0x8a13d
	text "What?"
	done

_DepositWhichMonText:: ; 0x8a144
	text "Deposit which"
	line "#mon?"
	done

_MonWasStoredText:: ; 0x8a159
	TX_RAM wcf4b
	text " was"
	line "stored in Box @"
	TX_RAM wWhichTrade
	text "."
	prompt

_CantDepositLastMonText:: ; 0x8a177
	text "You can't deposit"
	line "the last #mon!"
	prompt

_BoxFullText:: ; 0x8a198
	text "Oops! This Box is"
	line "full of #mon."
	prompt

_MonIsTakenOutText:: ; 0x8a1b9
	TX_RAM wcf4b
	text " is"
	line "taken out."
	cont "Got @"
	TX_RAM wcf4b
	text "."
	prompt

_NoMonText:: ; 0x8a1d7
	text "What? There are"
	line "no #mon here!"
	prompt

_CantTakeMonText:: ; 0x8a1f6
	text "You can't take"
	line "any more #mon."

	para "Deposit #mon"
	line "first."
	prompt

_ReleaseWhichMonText:: ; 0x8a228
	text "Release which"
	line "#mon?"
	done

_OnceReleasedText:: ; 0x8a23d
	text "Once released,"
	line "@"
	TX_RAM wcf4b
	text " is"
	cont "gone forever. OK?"
	done

_MonWasReleasedText:: ; 0x8a268
	TX_RAM wcf4b
	text " was"
	line "released outside."
	cont "Bye @"

_CF4BExclamationText:: ; 8a288 (22:6288)
	TX_RAM wcf4b
	text "!"
	prompt

_RequireCoinCaseText:: ; 8a28e (22:628e)
	text "A Coin Case is"
	line "required!@@"

_ExchangeCoinsForPrizesText:: ; 8a2a9 (22:62a9)
	text "We exchange your"
	line "coins for prizes."
	prompt

_WhichPrizeText:: ; 8a2cd (22:62cd)
	text "Which prize do"
	line "you want?"
	done

_HereYouGoText:: ; 8a2e7 (22:62e7)
	text "Here you go!@@"

_SoYouWantPrizeText:: ; 8a2f6 (22:62f6)
	text "So, you want"
	line "@"
	TX_RAM wcd6d
	text "?"
	done

_SorryNeedMoreCoinsText:: ; 8a30b (22:630b)
	text "Sorry, you need"
	line "more coins.@@"

_OopsYouDontHaveEnoughRoomText:: ; 8a329 (22:6329)
	text "Oops! You don't"
	line "have enough room.@@"

_OhFineThenText:: ; 8a34c (22:634c)
	text "Oh, fine then.@@"

_GetDexRatedText:: ; 8a35d (22:635d)
	text "Want to get your"
	line "#dex rated?"
	done

_ClosedOaksPCText:: ; 8a37b (22:637b)
	text "Closed link to"
	line "Prof.Oak's PC.@@"

_AccessedOaksPCText:: ; 8a39a (22:639a)
	text "Accessed Prof."
	line "Oak's PC."

	para "Accessed #dex"
	line "Rating System."
	prompt

_WhereWouldYouLikeText:: ; 8a3d0 (22:63d0)
	text "Where would you"
	line "like to go?"
	done

_PleaseWaitText:: ; 8a3ed (22:63ed)
	text "OK, please wait"
	line "just a moment."
	done

_LinkCanceledText:: ; 8a40d (22:640d)
	text "The link was"
	line "canceled."
	done

INCLUDE "text/oakspeech.asm"

_DoYouWantToNicknameText:: ; 0x8a605
	text "Do you want to"
	line "give a nickname"
	cont "to @"
	TX_RAM wcd6d
	text "?"
	done

_YourNameIsText:: ; 8a62f (22:662f)
	text "Right! So your"
	line "name is [PLAYER]!"
	prompt

_HisNameIsText:: ; 8a64a (22:664a)
	text "That's right! I"
	line "remember now! His"
	cont "name is [RIVAL]!"
	prompt

_WillBeTradedText:: ; 8a677 (22:6677)
	TX_RAM wNameOfPlayerMonToBeTraded
	text " and"
	line "@"
	TX_RAM wcd6d
	text " will"
	cont "be traded."
	done

_Char00Text:: ; 8a696 (22:6696)
	TX_NUM $FF8C,1,2
	text " ERROR."
	done

_Char55Text:: ; 8a6a3 (22:66a3)
	text $4B,"@@"

INCLUDE "text/maps/digletts_cave_route_2_entrance.asm"
INCLUDE "text/maps/viridian_forest_exit.asm"
INCLUDE "text/maps/route_2_house.asm"
INCLUDE "text/maps/route_2_gate.asm"
INCLUDE "text/maps/viridian_forest_entrance.asm"
INCLUDE "text/maps/mt_moon_pokecenter.asm"
INCLUDE "text/maps/saffron_gates.asm"
INCLUDE "text/maps/daycare_1.asm"
INCLUDE "text/maps/beach_house.asm"


SECTION "Text 4", ROMX, BANK[TEXT_4]

INCLUDE "text/maps/daycare_2.asm"
INCLUDE "text/maps/underground_path_route_5_entrance.asm"
INCLUDE "text/maps/underground_path_route_6_entrance.asm"
INCLUDE "text/maps/underground_path_route_7_entrance.asm"
INCLUDE "text/maps/underground_path_route_7_entrance_unused.asm"
INCLUDE "text/maps/underground_path_route_8_entrance.asm"
INCLUDE "text/maps/rock_tunnel_pokecenter.asm"
INCLUDE "text/maps/rock_tunnel_b1f.asm"
INCLUDE "text/maps/power_plant.asm"
INCLUDE "text/maps/route_11_gate.asm"
INCLUDE "text/maps/route_11_gate_upstairs.asm"
INCLUDE "text/maps/digletts_cave_route_11_entrance.asm"
INCLUDE "text/maps/route_12_gate.asm"
INCLUDE "text/maps/route_12_gate_upstairs.asm"
INCLUDE "text/maps/route_12_house.asm"
INCLUDE "text/maps/route_15_gate.asm"
INCLUDE "text/maps/route_15_gate_upstairs.asm"
INCLUDE "text/maps/route_16_gate.asm"
INCLUDE "text/maps/route_16_gate_upstairs.asm"
INCLUDE "text/maps/route_16_house.asm"
INCLUDE "text/maps/route_18_gate.asm"
INCLUDE "text/maps/route_18_gate_upstairs.asm"
INCLUDE "text/maps/pokemon_league_gate.asm"
INCLUDE "text/maps/victory_road_2f.asm"
INCLUDE "text/maps/bills_house.asm"
INCLUDE "text/maps/route_1.asm"
INCLUDE "text/maps/route_2.asm"
INCLUDE "text/maps/route_3.asm"
INCLUDE "text/maps/route_4.asm"
INCLUDE "text/maps/route_5.asm"
INCLUDE "text/maps/route_6.asm"
INCLUDE "text/maps/route_7.asm"
INCLUDE "text/maps/route_8.asm"
INCLUDE "text/maps/route_9.asm"
INCLUDE "text/maps/route_10.asm"
INCLUDE "text/maps/route_11_1.asm"


SECTION "Text 5", ROMX, BANK[TEXT_5]

INCLUDE "text/maps/route_11_2.asm"
INCLUDE "text/maps/route_12.asm"
INCLUDE "text/maps/route_13.asm"
INCLUDE "text/maps/route_14.asm"
INCLUDE "text/maps/route_15.asm"
INCLUDE "text/maps/route_16.asm"
INCLUDE "text/maps/route_17.asm"
INCLUDE "text/maps/route_18.asm"
INCLUDE "text/maps/route_19.asm"
INCLUDE "text/maps/route_20.asm"
INCLUDE "text/maps/route_21.asm"
INCLUDE "text/maps/route_22.asm"
INCLUDE "text/maps/route_23.asm"
INCLUDE "text/maps/route_24_1.asm"


SECTION "Text 6", ROMX, BANK[TEXT_6]

INCLUDE "text/maps/route_24_2.asm"
INCLUDE "text/maps/route_25.asm"

_FileDataDestroyedText:: ; 945f1 (25:45f1)
	text "The file data is"
	line "destroyed!"
	prompt

_WouldYouLikeToSaveText:: ; 9460e (25:460e)
	text "Would you like to"
	line "save the game?"
	done

_GameSavedText:: ; 94630 (25:4630)
	text "[PLAYER] saved"
	line "the game!"
	done

_OlderFileWillBeErasedText:: ; 94643 (25:4643)
	text "The older file"
	line "will be erased to"
	cont "save. Okay?"
	done

_WhenYouChangeBoxText:: ; 94671 (25:4671)
	text "When you change a"
	line "#mon Box, data"
	cont "will be saved."

	para "Is that okay?"
	done

_ChooseABoxText:: ; 946b0 (25:46b0)
	text "Choose a"
	line $4a, " Box.@@"

_EvolvedText:: ; 946c2 (25:46c2)
	TX_RAM wcf4b
	text " evolved"
	done

_IntoText:: ; 946cf (25:46cf)
	db $0
	line "into @"
	TX_RAM wcd6d
	text "!"
	done

_StoppedEvolvingText:: ; 946dd (25:46dd)
	text "Huh? @"
	TX_RAM wcf4b
	db $0
	line "stopped evolving!"
	prompt

_IsEvolvingText:: ; 946fb (25:46fb)
	text "What? @"
	TX_RAM wcf4b
	db $0
	line "is evolving!"
	done

_FellAsleepText:: ; 94715 (25:4715)
	text $59
	line "fell asleep!"
	prompt

_AlreadyAsleepText:: ; 94725 (25:4725)
	text $59, "'s"
	line "already asleep!"
	prompt

_PoisonedText:: ; 94739 (25:4739)
	text $59
	line "was poisoned!"
	prompt

_BadlyPoisonedText:: ; 9474a (25:474a)
	text $59, "'s"
	line "badly poisoned!"
	prompt

_BurnedText:: ; 9475e (25:475e)
	text $59
	line "was burned!"
	prompt

_FrozenText:: ; 9476d (25:476d)
	text $59
	line "was frozen solid!"
	prompt

_FireDefrostedText:: ; 94782 (25:4782)
	text $59
	line "was defrosted!"
	prompt

_MonsStatsRoseText:: ; 94795 (25:4795)
	text $5a, "'s"
	line "@"
	TX_RAM wcf4b
	text "@@"

_GreatlyRoseText:: ; 947a0 (25:47a0)
	text $4c, "sharply@@"

_RoseText:: ; 947ab (25:47ab)
	text " rose!"
	prompt

_WontRiseAnymoreText::
	text $5A, "'s"
	line "@"
	TX_RAM wcf4b
	text " won't"
	cont "go any higher!"
	prompt

_MonsStatsFellText:: ; 947b3 (25:47b3)
	text $59, "'s"
	line "@"
	TX_RAM wcf4b
	text "@@"

_GreatlyFellText:: ; 947be (25:47be)
	text $4c, "harshly@@"

_FellText:: ; 947c9 (25:47c9)
	text " fell!"
	prompt

_WontFallAnymoreText::
	text $59, "'s"
	line "@"
	TX_RAM wcf4b
	text " won't"
	cont "go any lower!"
	prompt

_RanFromBattleText:: ; 947d1 (25:47d1)
	text $5a
	line "ran from battle!"
	prompt

_RanAwayScaredText:: ; 947e5 (25:47e5)
	text $59
	line "ran away scared!"
	prompt

_WasBlownAwayText:: ; 947f9 (25:47f9)
	text $59
	line "was blown away!"
	prompt

_ChargeMoveEffectText:: ; 9480c (25:480c)
	text $5a, "@@"

_MadeWhirlwindText:: ; 94810 (25:4810)
	db $0
	line "made a whirlwind!"
	prompt

_TookInSunlightText:: ; 94824 (25:4824)
	db $0
	line "took in sunlight!"
	prompt

_LoweredItsHeadText:: ; 94838 (25:4838)
	db $0
	line "lowered its head!"
	prompt

_SkyAttackGlowingText:: ; 9484c (25:484c)
	db $0
	line "is glowing!"
	prompt

_FlewUpHighText:: ; 9485a (25:485a)
	db $0
	line "flew up high!"
	prompt

_DugAHoleText:: ; 9486a (25:486a)
	db $0
	line "dug a hole!"
	prompt

_BecameConfusedText:: ; 94878 (25:4878)
	text $59
	line "became confused!"
	prompt

_MimicLearnedMoveText:: ; 9488c (25:488c)
	text $5a
	line "learned"
	cont "@"
	TX_RAM wcd6d
	text "!"
	prompt

_MoveWasDisabledText:: ; 9489e (25:489e)
	text $59, "'s"
	line "@"
	TX_RAM wcd6d
	text " was"
	cont "disabled!"
	prompt

_NothingHappenedText:: ; 948b6 (25:48b6)
	text "Nothing happened!"
	prompt

_NoEffectText:: ; 948c9 (25:48c9)
	text "No effect!"
	prompt

_ButItFailedText:: ; 948d5 (25:48d5)
	text "But, it failed! "
	prompt

_DidntAffectText:: ; 948e7 (25:48e7)
	text "It didn't affect"
	line $59, "!"
	prompt

_IsUnaffectedText:: ; 948fb (25:48fb)
	text $59
	line "is unaffected!"
	prompt

_ParalyzedMayNotAttackText:: ; 9490d (25:490d)
	text $59, "'s"
	line "paralyzed! It may"
	cont "not attack!"
	prompt

_SubstituteText:: ; 9492f (25:492f)
	text "It created a"
	line "Substitute!"
	prompt

_HasSubstituteText:: ; 94949 (25:4949)
	text $5a
	line "has a Substitute!"
	prompt

_TooWeakSubstituteText:: ; 9495e (25:495e)
	text "Too weak to make"
	line "a Substitute!"
	prompt

_CoinsScatteredText:: ; 9497e (25:497e)
	text "Coins scattered"
	line "everywhere!"
	prompt

_GettingPumpedText:: ; 9499b (25:499b)
	text $5a, "'s"
	line "getting pumped!"
	prompt

_WasSeededText:: ; 949af (25:49af)
	text $59
	line "was seeded!"
	prompt

_EvadedAttackText:: ; 949be (25:49be)
	text $59
	line "evaded attack!"
	prompt

_HitWithRecoilText:: ; 949d0 (25:49d0)
	text $5a, "'s"
	line "hit with recoil!"
	prompt

_ConvertedTypeText:: ; 949e5 (25:49e5)
	text "Converted type to"
	line $59, "'s!"
	prompt

_StatusChangesEliminatedText:: ; 949fc (25:49fc)
	text "All Status changes"
	line "are eliminated!"
	prompt

_StartedSleepingEffect:: ; 94a20 (25:4a20)
	text $5a
	line "started sleeping!"
	done

_FellAsleepBecameHealthyText:: ; 94a35 (25:4a35)
	text $5a
	line "fell asleep and"
	cont "became healthy!"
	done

_RegainedHealthText:: ; 94a58 (25:4a58)
	text $5a
	line "regained health!"
	prompt

_TransformedText:: ; 94a6c (25:4a6c)
	text $5a
	line "transformed into"
	cont "@"
	TX_RAM wcd6d
	text "!"
	prompt

_LightScreenProtectedText:: ; 94a87 (25:4a87)
	text $5a, "'s"
	line "protected against"
	cont "special attacks!"
	prompt

_ReflectGainedArmorText:: ; 94aae (25:4aae)
	text $5a
	line "gained armor!"
	prompt

_ShroudedInMistText:: ; 94abf (25:4abf)
	text $5a, "'s"
	line "shrouded in mist!"
	prompt

_SuckedHealthText:: ; 94ad5 (25:4ad5)
	text "Sucked health from"
	line $59, "!"
	prompt

_DreamWasEatenText:: ; 94aec (25:4aec)
	text $59, "'s"
	line "dream was eaten!"
	prompt

_BattleCenterMText1:: ; 94b01 (25:4b01)
	text "!"
	done

_TradeCenterMText1:: ; 94b04 (25:4b04)
	text "!"
	done

INCLUDE "text/maps/reds_house_1f.asm"
INCLUDE "text/maps/blues_house.asm"
INCLUDE "text/maps/oaks_lab.asm"
INCLUDE "text/maps/viridian_mart.asm"
INCLUDE "text/maps/school.asm"
INCLUDE "text/maps/viridian_house.asm"
INCLUDE "text/maps/viridian_gym.asm"
INCLUDE "text/maps/museum_1f.asm"
INCLUDE "text/maps/museum_2f.asm"
INCLUDE "text/maps/pewter_gym_1.asm"


SECTION "Text 7", ROMX, BANK[TEXT_7]

INCLUDE "text/maps/pewter_gym_2.asm"
INCLUDE "text/maps/pewter_house_1.asm"
INCLUDE "text/maps/pewter_mart.asm"
INCLUDE "text/maps/pewter_house_2.asm"
INCLUDE "text/maps/pewter_pokecenter.asm"
INCLUDE "text/maps/cerulean_trashed_house.asm"
INCLUDE "text/maps/cerulean_trade_house.asm"
INCLUDE "text/maps/cerulean_pokecenter.asm"
INCLUDE "text/maps/cerulean_gym.asm"
INCLUDE "text/maps/bike_shop.asm"
INCLUDE "text/maps/cerulean_mart.asm"
INCLUDE "text/maps/cerulean_badge_house.asm"
INCLUDE "text/maps/lavender_pokecenter.asm"
INCLUDE "text/maps/pokemon_tower_1f.asm"
INCLUDE "text/maps/pokemon_tower_2f.asm"
INCLUDE "text/maps/pokemon_tower_3f.asm"
INCLUDE "text/maps/pokemon_tower_4f.asm"
INCLUDE "text/maps/pokemon_tower_5f.asm"
INCLUDE "text/maps/pokemon_tower_6f.asm"
INCLUDE "text/maps/pokemon_tower_7f.asm"
INCLUDE "text/maps/fujis_house.asm"
INCLUDE "text/maps/lavender_mart.asm"
INCLUDE "text/maps/lavender_house.asm"
INCLUDE "text/maps/name_rater.asm"
INCLUDE "text/maps/vermilion_pokecenter.asm"
INCLUDE "text/maps/fan_club.asm"
INCLUDE "text/maps/vermilion_mart.asm"
INCLUDE "text/maps/vermilion_gym_1.asm"


SECTION "Text 8", ROMX, BANK[TEXT_8]

INCLUDE "text/maps/vermilion_gym_2.asm"
INCLUDE "text/maps/vermilion_house.asm"
INCLUDE "text/maps/vermilion_dock.asm"
INCLUDE "text/maps/vermilion_fishing_house.asm"
INCLUDE "text/maps/celadon_dept_store_1f.asm"
INCLUDE "text/maps/celadon_dept_store_2f.asm"
INCLUDE "text/maps/celadon_dept_store_3f.asm"
INCLUDE "text/maps/celadon_dept_store_4f.asm"
INCLUDE "text/maps/celadon_dept_store_roof.asm"
INCLUDE "text/maps/celadon_mansion_1f.asm"
INCLUDE "text/maps/celadon_mansion_2f.asm"
INCLUDE "text/maps/celadon_mansion_3f.asm"
INCLUDE "text/maps/celadon_mansion_4f_outside.asm"
INCLUDE "text/maps/celadon_mansion_4f_inside.asm"
INCLUDE "text/maps/celadon_pokecenter.asm"
INCLUDE "text/maps/celadon_gym.asm"
INCLUDE "text/maps/celadon_game_corner.asm"
INCLUDE "text/maps/celadon_dept_store_5f.asm"
INCLUDE "text/maps/celadon_prize_room.asm"
INCLUDE "text/maps/celadon_diner.asm"
INCLUDE "text/maps/celadon_house.asm"
INCLUDE "text/maps/celadon_hotel.asm"
INCLUDE "text/maps/fuchsia_mart.asm"
INCLUDE "text/maps/fuchsia_house.asm"
INCLUDE "text/maps/fuchsia_pokecenter.asm"
INCLUDE "text/maps/wardens_house.asm"
INCLUDE "text/maps/safari_zone_entrance.asm"
INCLUDE "text/maps/fuchsia_gym_1.asm"


SECTION "Text 9", ROMX, BANK[TEXT_9]

INCLUDE "text/maps/fuchsia_gym_2.asm"
INCLUDE "text/maps/fuchsia_meeting_room.asm"
INCLUDE "text/maps/fuchsia_fishing_house.asm"
INCLUDE "text/maps/mansion_1f.asm"
INCLUDE "text/maps/cinnabar_gym.asm"
INCLUDE "text/maps/cinnabar_lab.asm"
INCLUDE "text/maps/cinnabar_lab_trade_room.asm"
INCLUDE "text/maps/cinnabar_lab_metronome_room.asm"
INCLUDE "text/maps/cinnabar_lab_fossil_room.asm"
INCLUDE "text/maps/cinnabar_pokecenter.asm"
INCLUDE "text/maps/cinnabar_mart.asm"
INCLUDE "text/maps/indigo_plateau_lobby.asm"
INCLUDE "text/maps/copycats_house_1f.asm"
INCLUDE "text/maps/copycats_house_2f.asm"
INCLUDE "text/maps/fighting_dojo.asm"
INCLUDE "text/maps/saffron_gym.asm"
INCLUDE "text/maps/saffron_house.asm"
INCLUDE "text/maps/saffron_mart.asm"
INCLUDE "text/maps/silph_co_1f.asm"
INCLUDE "text/maps/saffron_pokecenter.asm"
INCLUDE "text/maps/mr_psychics_house.asm"

_PokemartGreetingText:: ; a259c (28:659c)
	text "Hi there!"
	next "May I help you?"
	done

_PokemonFaintedText:: ; a25b7 (28:65b7)
	TX_RAM wcd6d
	db $0
	line "fainted!"
	done

_PlayerBlackedOutText:: ; a25c5 (28:65c5)
	text "[PLAYER] is out of"
	line "useable #mon!"

	para "[PLAYER] blacked"
	line "out!"
	prompt

_RepelWoreOffText:: ; a25ef (28:65ef)
	text "Repel's effect"
	line "wore off."
	prompt

_PokemartBuyingGreetingText:: ; a2608 (28:6608)
	text "Take your time."
	done

_PokemartTellBuyPriceText:: ; a2619 (28:6619)
	TX_RAM wcf4b
	text "?"
	line "That will be"
	cont "¥@"
	TX_BCD $ff9f, $c3
	text ". OK?"
	done

_PokemartBoughtItemText:: ; a2639 (28:6639)
	text "Here you are!"
	line "Thank you!"
	prompt

_PokemartNotEnoughMoneyText:: ; a2653 (28:6653)
	text "You don't have"
	line "enough money."
	prompt

_PokemartItemBagFullText:: ; a2670 (28:6670)
	text "You can't carry"
	line "any more items."
	prompt

_PokemonSellingGreetingText:: ; a2690 (28:6690)
	text "What would you"
	line "like to sell?"
	done

_PokemartTellSellPriceText:: ; a26ae (28:66ae)
	text "I can pay you"
	line "¥@"
	TX_BCD $ff9f, $c3
	text " for that."
	done

_PokemartItemBagEmptyText:: ; a26cf (28:66cf)
	text "You don't have"
	line "anything to sell."
	prompt

_PokemartUnsellableItemText:: ; a26f0 (28:66f0)
	text "I can't put a"
	line "price on that."
	prompt

_PokemartThankYouText:: ; a270d (28:670d)
	text "Thank you!"
	done

_PokemartAnythingElseText:: ; a2719 (28:6719)
	text "Is there anything"
	line "else I can do?"
	done

_LearnedMove1Text:: ; a273b (28:673b)
	TX_RAM wd036
	text " learned"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_WhichMoveToForgetText:: ; a2750 (28:6750)
	text "Which move should"
	next "be forgotten?"
	done

_AbandonLearningText:: ; a2771 (28:6771)
	text "Abandon learning"
	line "@"
	TX_RAM wcf4b
	text "?"
	done

_DidNotLearnText:: ; a278a (28:678a)
	TX_RAM wd036
	db $0
	line "did not learn"
	cont "@"
	TX_RAM wcf4b
	text "!"
	prompt

_TryingToLearnText:: ; a27a4 (28:67a4)
	TX_RAM wd036
	text " is"
	line "trying to learn"
	cont "@"
	TX_RAM wcf4b
	text "!"

	para "But, @"
	TX_RAM wd036
	db $0
	line "can't learn more"
	cont "than 4 moves!"

	para "Delete an older"
	line "move to make room"
	cont "for @"
	TX_RAM wcf4b
	text "?"
	done

_OneTwoAndText:: ; a2819 (28:6819)
	text "1, 2 and...@@"

_PoofText:: ; a2827 (28:6827)
	text " Poof!@@"

_ForgotAndText:: ; a2830 (28:6830)
	db $0
	para "@"
	TX_RAM wd036
	text " forgot"
	line "@"
	TX_RAM wcd6d
	text "!"

	para "And..."
	prompt

_HMCantDeleteText:: ; a284d (28:684d)
	text "HM techniques"
	line "can't be deleted!"
	prompt

_PokemonCenterWelcomeText:: ; a286d (28:686d)
	text "Welcome to our"
	line "#mon Center!"

	para "We heal your"
	line "#mon back to"
	cont "perfect health!"
	prompt

_ShallWeHealYourPokemonText:: ; a28b4 (28:68b4)
	text "Shall we heal your"
	line "#mon?"
	done

_NeedYourPokemonText:: ; a28ce (28:68ce)
	text "OK. We'll need"
	line "your #mon."
	done

_PokemonFightingFitText:: ; a28e8 (28:68e8)
	text "Thank you!"
	line "Your #mon are"
	cont "fighting fit!"
	prompt

_PokemonCenterFarewellText:: ; a2910 (28:6910)
	text "We hope to see"
	line "you again!"
	done

_CableClubNPCAreaReservedFor2FriendsLinkedByCableText:: ; a292b (28:692b)
	text "This area is"
	line "reserved for 2"
	cont "friends who are"
	cont "linked by cable."
	done

_CableClubNPCWelcomeText:: ; a2969 (28:6969)
	text "Welcome to the"
	line "Cable Club!"
	done

_CableClubNPCPleaseApplyHereHaveToSaveText:: ; a2985 (28:6985)
	text "Please apply here."

	para "Before opening"
	line "the link, we have"
	cont "to save the game."
	done

_CableClubNPCPleaseWaitText:: ; a29cc (28:69cc)
	text "Please wait.@@"

_CableClubNPCLinkClosedBecauseOfInactivityText:: ; a29db (28:69db)
	text "The link has been"
	line "closed because of"
	cont "inactivity."

	para "Please contact"
	line "your friend and"
	cont "come again!"
	done


SECTION "Text 10", ROMX, BANK[TEXT_10]

_CableClubNPCPleaseComeAgainText:: ; a4000 (29:4000)
	text "Please come again!"
	done

_CableClubNPCMakingPreparationsText:: ; a4014 (29:4014)
	text "We're making"
	line "preparations."
	cont "Please wait."
	done

_UsedStrengthText:: ; a403c (29:403c)
	TX_RAM wcd6d
	text " used"
	line "Strength.@@"

_CanMoveBouldersText:: ; a4051 (29:4051)
	TX_RAM wcd6d
	text " can"
	line "move boulders."
	prompt

_CurrentTooFastText:: ; a4069 (29:4069)
	text "The current is"
	line "much too fast!"
	prompt

_CyclingIsFunText:: ; a4088 (29:4088)
	text "Cycling is fun!"
	line "Forget Surfing!"
	prompt

_FlashLightsAreaText:: ; a40a9 (29:40a9)
	text "A blinding Flash"
	line "lights the area!"
	prompt

_WarpToLastPokemonCenterText:: ; a40cc (29:40cc)
	text "Warp to the last"
	line "#mon Center."
	done

_CannotUseTeleportNowText:: ; a40eb (29:40eb)
	TX_RAM wcd6d
	text " can't"
	line "use Telepor now."
	prompt

_CannotFlyHereText:: ; a4107 (29:4107)
	TX_RAM wcd6d
	text " can't"
	line "Fly here."
	prompt

_NotHealthyEnoughText:: ; a411b (29:411b)
	text "Not healthy"
	line "enough."
	prompt

_NewBadgeRequiredText:: ; a4130 (29:4130)
	text "No! A new Badge"
	line "is required."
	prompt

_CannotUseItemsHereText:: ; a414e (29:414e)
	text "You can't use items"
	line "here."
	prompt

_CannotGetOffHereText:: ; a4168 (29:4168)
	text "You can't get off"
	line "here."
	prompt

_GotMonText:: ; a4180 (29:4180)
	text "[PLAYER] got"
	line "@"
	TX_RAM wcd6d
	text "!@@"

_SetToBoxText:: ; a418f (29:418f)
	text "There's no more"
	line "room for #mon!"
	cont "@"
	TX_RAM wBoxMonNicks
	text " was"
	cont "sent to #mon"
	cont "Box @"
	TX_RAM wcf4b
	text " on PC!"
	done

_BoxIsFullText:: ; a41d6 (29:41d6)
	text "There's no more"
	line "room for #mon!"

	para "The #mon Box"
	line "is full and can't"
	cont "accept any more!"

	para "Change the Box at"
	line "a #mon Center!"
	done

INCLUDE "text/maps/pallet_town.asm"
INCLUDE "text/maps/viridian_city.asm"
INCLUDE "text/maps/pewter_city.asm"
INCLUDE "text/maps/cerulean_city.asm"
INCLUDE "text/maps/lavender_town.asm"
INCLUDE "text/maps/vermilion_city.asm"
INCLUDE "text/maps/celadon_city.asm"
INCLUDE "text/maps/fuchsia_city.asm"
INCLUDE "text/maps/cinnabar_island.asm"
INCLUDE "text/maps/saffron_city.asm"

_ItemUseBallText00:: ; a6729 (29:6729)
	text "It dodged the"
	line "thrown Ball!"

	para "This #mon"
	line "can't be caught!"
	prompt

_ItemUseBallText01:: ; a675f (29:675f)
	text "You missed the"
	line "#mon!"
	prompt

_ItemUseBallText02:: ; a6775 (29:6775)
	text "Darn! The #mon"
	line "broke free!"
	prompt

_ItemUseBallText03:: ; a6791 (29:6791)
	text "Aww! It appeared"
	line "to be caught! "
	prompt

_ItemUseBallText04:: ; a67b2 (29:67b2)
	text "Shoot! It was so"
	line "close too!"
	prompt

_ItemUseBallText05:: ; a67cf (29:67cf)
	text "All right!"
	line "@"
	TX_RAM wEnemyMonNick
	text " was"
	cont "caught!@@"

_ItemUseBallText07:: ; a67ee (29:67ee)
	TX_RAM wBoxMonNicks
	text " was"
	line "transferred to"
	cont "Bill's PC!"
	prompt

_ItemUseBallText08:: ; a6810 (29:6810)
	TX_RAM wBoxMonNicks
	text " was"
	line "transferred to"
	cont "someone's PC!"
	prompt

_ItemUseBallText06:: ; a6835 (29:6835)
	text "New #dex data"
	line "will be added for"
	cont "@"
	TX_RAM wEnemyMonNick
	text "!@@"

_SurfingGotOnText:: ; a685e (29:685e)
	text "[PLAYER] got on"
	line "@"
	TX_RAM wcd6d
	text "!"
	prompt

_SurfingNoPlaceToGetOffText:: ; a686f (29:686f)
	text "There's no place"
	line "to get off!"
	prompt

_VitaminStatRoseText:: ; a688c (29:688c)
	TX_RAM wcd6d
	text "'s"
	line "@"
	TX_RAM wcf4b
	text " rose."
	prompt

_VitaminNoEffectText:: ; a689e (29:689e)
	text "It won't have any"
	line "effect."
	prompt

_ThrewBaitText:: ; a68b8 (29:68b8)
	text "[PLAYER] threw"
	line "some Bait."
	done

_ThrewRockText:: ; a68cc (29:68cc)
	text "[PLAYER] threw a"
	line "Rock."
	done

_PlayedFluteNoEffectText:: ; a68dd (29:68dd)
	text "Played the #"
	line "Flute."

	para "Now, that's a"
	line "catchy tune!"
	prompt

_FluteWokeUpText:: ; a690c (29:690c)
	text "All sleeping"
	line "#mon woke up."
	prompt

_PlayedFluteHadEffectText:: ; a6928 (29:6928)
	text "[PLAYER] played the"
	line "# Flute.@@"

_CoinCaseNumCoinsText:: ; a6940 (29:6940)
	text "Coins"
	line "@"
	TX_BCD wPlayerCoins, $c2
	text " "
	prompt

_ItemfinderFoundItemText:: ; a694f (29:694f)
	text "Yes! Item Finder"
	line "indicates there's"
	cont "an item nearby."
	prompt

_ItemfinderFoundNothingText:: ; a6981 (29:6981)
	text "Nope! Item Finder"
	line "isn't responding."
	prompt

_RaisePPWhichTechniqueText:: ; a69a4 (29:69a4)
	text "Raise PP of which"
	line "technique?"
	done

_RestorePPWhichTechniqueText:: ; a69c2 (29:69c2)
	text "Restore PP of"
	line "which technique?"
	done

_PPMaxedOutText:: ; a69e2 (29:69e2)
	TX_RAM wcf4b
	text "'s PP"
	line "is maxed out."
	prompt

_PPIncreasedText:: ; a69f9 (29:69f9)
	TX_RAM wcf4b
	text "'s PP"
	line "increased."
	prompt

_PPRestoredText:: ; a6a0d (29:6a0d)
	text "PP was restored."
	prompt

_BootedUpTMText:: ; a6a1f (29:6a1f)
	text "Booted up a TM!"
	prompt

_BootedUpHMText:: ; a6a30 (29:6a30)
	text "Booted up an HM!"
	prompt

_TeachMachineMoveText:: ; a6a42 (29:6a42)
	text "It contained"
	line "@"
	TX_RAM wcf4b
	text "!"

	para "Teach @"
	TX_RAM wcf4b
	db $0
	line "to a #mon?"
	done

_MonCannotLearnMachineMoveText:: ; a6a6e (29:6a6e)
	TX_RAM wcd6d
	text " is not"
	line "compatible with"
	cont "@"
	TX_RAM wcf4b
	text "."

	para "It can't learn"
	line "@"
	TX_RAM wcf4b
	text "."
	prompt

_ItemUseNotTimeText:: ; a6aa6 (29:6aa6)
	text "Oak: [PLAYER]!"
	line "This isn't the"
	cont "time to use that! "
	prompt

_ItemUseNotYoursToUseText:: ; a6ad0 (29:6ad0)
	text "This isn't yours"
	line "to use!"
	prompt

_ItemUseNoEffectText:: ; a6ae9 (29:6ae9)
	text "It won't have any"
	line "effect."
	prompt

_ThrowBallAtTrainerMonText1:: ; a6b03 (29:6b03)
	text "The trainer"
	line "blocked the Ball!"
	prompt

_ThrowBallAtTrainerMonText2:: ; a6b22 (29:6b22)
	text "Don't be a thief!"
	prompt

_NoCyclingAllowedHereText:: ; a6b34 (29:6b34)
	text "No cycling"
	next "allowed here."
	prompt

_NoSurfingHereText:: ; a6b4e (29:6b4e)
	text "No Surfing on"
	line "@"
	TX_RAM wcd6d
	text " here!"
	prompt

_BoxFullCannotThrowBallText:: ; a6b69 (29:6b69)
	text "The #mon Box"
	line "is full! Can't"
	cont "use that item!"
	prompt


SECTION "Text 11", ROMX, BANK[TEXT_11]

_ItemUseText001:: ; a8000 (2a:4000)
	text "[PLAYER] used@@"

_ItemUseText002:: ; a8009 (2a:4009)
	TX_RAM wcf4b
	text "!"
	done

_GotOnBicycleText1:: ; a800f (2a:400f)
	text "[PLAYER] got on the@@"

_GotOnBicycleText2:: ; a801e (2a:401e)
	TX_RAM wcf4b
	text "!"
	prompt

_GotOffBicycleText1:: ; a8024 (2a:4024)
	text "[PLAYER] got off@@"

_GotOffBicycleText2:: ; a8030 (2a:4030)
	text "the @"
	TX_RAM wcf4b
	text "."
	prompt

_ThrewAwayItemText:: ; a803c (2a:403c)
	text "Threw away"
	line "@"
	TX_RAM wcd6d
	text "."
	prompt

_IsItOKToTossItemText:: ; a804f (2a:404f)
	text "Is it OK to toss"
	line "@"
	TX_RAM wcf4b
	text "?"
	prompt

_TooImportantToTossText:: ; a8068 (2a:4068)
	text "That's too impor-"
	line "tant to toss!"
	prompt

_AlreadyKnowsText:: ; a8088 (2a:4088)
	TX_RAM wcd6d
	text " knows"
	line "@"
	TX_RAM wcf4b
	text "!"
	prompt

_ConnectCableText:: ; a809a (2a:409a)
	text "Okay, connect the"
	line "cable like so!"
	prompt

_TradedForText:: ; a80bc (2a:40bc)
	text "[PLAYER] traded"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text " for"
	cont "@"
	TX_RAM wInGameTradeReceiveMonName
	text "!@@"

_WannaTrade1Text:: ; a80d8 (2a:40d8)
	text "I'm looking for"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "! Wanna"

	para "trade one for"
	line "@"
	TX_RAM wInGameTradeReceiveMonName
	text "? "
	done

_NoTrade1Text:: ; a810b (2a:410b)
	text "Awww!"
	line "Oh well..."
	done

_WrongMon1Text:: ; a811d (2a:411d)
	text "What? That's not"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "!"

	para "If you get one,"
	line "come back here!"
	done

_Thanks1Text:: ; a8155 (2a:4155)
	text "Hey thanks!"
	done

_AfterTrade1Text:: ; a8162 (2a:4162)
	text "Isn't my old"
	line "@"
	TX_RAM wInGameTradeReceiveMonName
	text " great?"
	done

_WannaTrade2Text:: ; a817c (2a:417c)
	text "Hello there! Do"
	line "you want to trade"

	para "your @"
	TX_RAM wInGameTradeGiveMonName
	db $0
	line "for @"
	TX_RAM wInGameTradeReceiveMonName
	text "?"
	done

_NoTrade2Text:: ; a81b5 (2a:41b5)
	text "Well, if you"
	line "don't want to..."
	done

_WrongMon2Text:: ; a81d3 (2a:41d3)
	text "Hmmm? This isn't"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "."

	para "Think of me when"
	line "you get one."
	done

_Thanks2Text:: ; a8209 (2a:4209)
	text "Thanks!"
	done

_AfterTrade2Text:: ; a8212 (2a:4212)
	text "Hello there! Your"
    line "old @"
	TX_RAM wInGameTradeGiveMonName
	text " is"
	cont "magnificent!"
	done

_WannaTrade3Text:: ; a8240 (2a:4240)
	text "Hi! Do you have"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "?"

	para "Want to trade it"
	line "for @"
	TX_RAM wInGameTradeReceiveMonName
	text "?"
	done

_NoTrade3Text:: ; a8274 (2a:4274)
	text "That's too bad."
	done

_WrongMon3Text:: ; a8284 (2a:4284)
	text "...This is no"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "."

	para "If you get one,"
	line "trade it with me!"
	done

_Thanks3Text:: ; a82bc (2a:42bc)
	text "Thanks, pal!"
	done

_AfterTrade3Text:: ; a82c9 (2a:42c9)
	text "How is my old"
	line "@"
	TX_RAM wInGameTradeReceiveMonName
	text "?"

	para "My @"
	TX_RAM wInGameTradeGiveMonName
	text " is"
	line "doing great!"
	done

_NothingToCutText:: ; a82f8 (2a:42f8)
	text "There isn't"
	line "anything to Cut!"
	prompt

_UsedCutText:: ; a8315 (2a:4315)
	TX_RAM wcd6d
	text " hacked"
	line "away with Cut!"
	prompt

_NothingToHeadbuttText::
	text "There's nothing"
	line "to Headbutt!"
	prompt

_UsedHeadbuttText::
	TX_RAM wcd6d
	text " did a"
	line "Headbutt!"
	prompt

_NoHeadbuttMonText::
	text "Nope, nothing."
	prompt

_FellOutOfTreeText::
	text "Wild @"
	TX_RAM wEnemyMonNick
	db $0
	line "fell out of the"
	cont "tree!"
	prompt


SECTION "Pokedex Text", ROMX, BANK[POKEDEX_TEXT]

INCLUDE "text/pokedex.asm"

SECTION "Pokedex Text 2", ROMX, BANK[POKEDEX_TEXT_2]

INCLUDE "text/pokedex2.asm"

INCLUDE "text/item_descriptions.asm"


SECTION "Move Names", ROMX, BANK[MOVE_NAMES]

INCLUDE "text/move_names.asm"

