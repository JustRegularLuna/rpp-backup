INCLUDE "charmap.asm"
INCLUDE "constants/text_constants.asm"
TEXT_1  EQU $20
TEXT_2  EQU TEXT_1 + 1
TEXT_3  EQU TEXT_2 + 1
TEXT_4  EQU TEXT_3 + 1
TEXT_5  EQU TEXT_4 + 1
TEXT_6  EQU TEXT_5 + 1
TEXT_7  EQU TEXT_6 + 1
TEXT_8  EQU TEXT_7 + 1
TEXT_9  EQU TEXT_8 + 1
TEXT_10 EQU TEXT_9 + 1
TEXT_11 EQU TEXT_10 + 1

POKEDEX_TEXT   EQU TEXT_11 + 1
POKEDEX_TEXT_2 EQU $32
MOVE_NAMES     EQU POKEDEX_TEXT + 1

INCLUDE "macros.asm"
INCLUDE "hram.asm"


SECTION "Text 1", ROMX, BANK[TEXT_1]

_CardKeySuccessText1::
	text "Bingo!@@"

_CardKeySuccessText2::
	text ""
	line "The Card Key"
	cont "opened the door!"
	done

_CardKeyFailText::
	text "Darn! It needs a"
	line "Card Key!"
	done

_TrainerNameText::
	TX_RAM wTrainerName
	text ": @@"

_NoNibbleText::
	text "Not even a nibble!"
	prompt

_NothingHereText::
	text "Looks like there's"
	line "nothing here."
	prompt

_ItsABiteText::
	text "Oh!"
	line "It's a bite!"
	prompt

_ExclamationText::
	text "!"
	done

_GroundRoseText::
	text "Ground rose up"
	line "somewhere!"
	done

_BoulderText::
	text "This requires"
	line "Strength to move!"
	done

_MartSignText::
	text "All your item"
	line "needs fulfilled!"
	cont "#mon Mart"
	done

_PokeCenterSignText::
	text "Heal your #mon!"
	line "#mon Center"
	done

_FoundItemText::
	text "[PLAYER] found"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_NoMoreRoomForItemText::
	text "No more room for"
	line "items!"
	done

_OaksAideHiText::
	text "Hi! Remember me?"
	line "I'm Prof.Oak's"
	cont "Aide!"

	para "If you caught @"
	TX_NUM hOaksAideRequirement, 1, 3
	text ""
	line "kinds of #mon,"
	cont "I'm supposed to"
	cont "give you this"
	cont "@"
	TX_RAM wOaksAideRewardItemName
	text "!"

	para "So, [PLAYER]! Have"
	line "you caught at"
	cont "least @"
	TX_NUM hOaksAideRequirement, 1, 3
	text " kinds of"
	cont "#mon?"
	done

_OaksAideUhOhText::
	text "Let's see..."
	line "Uh-oh! You have"
	cont "caught only @"
	TX_NUM hOaksAideNumMonsOwned, 1, 3
	text ""
	cont "kinds of #mon!"

	para "You need @"
	TX_NUM hOaksAideRequirement, 1, 3
	text " kinds"
	line "if you want the"
	cont "@"
	TX_RAM wOaksAideRewardItemName
	text "."
	done

_OaksAideComeBackText::
	text "Oh. I see."

	para "When you get @"
	TX_NUM hOaksAideRequirement, 1, 3
	text ""
	line "kinds, come back"
	cont "for @"
	TX_RAM wOaksAideRewardItemName
	text "."
	done

_OaksAideHereYouGoText::
	text "Great! You have"
	line "caught @"
	TX_NUM hOaksAideNumMonsOwned, 1, 3
	text " kinds "
	cont "of #mon!"
	cont "Congratulations!"

	para "Here you go!"
	prompt

_OaksAideGotItemText::
	text "[PLAYER] got the"
	line "@"
	TX_RAM wOaksAideRewardItemName
	text "!@@"

_OaksAideNoRoomText::
	text "Oh! I see you"
	line "don't have any"
	cont "room for the"
	cont "@"
	TX_RAM wOaksAideRewardItemName
	text "."
	done

INCLUDE "text/maps/ViridianForest.asm"
INCLUDE "text/maps/MtMoon1.asm"
INCLUDE "text/maps/MtMoon2.asm"
INCLUDE "text/maps/MtMoon3.asm"
INCLUDE "text/maps/SSAnne1.asm"
INCLUDE "text/maps/SSAnne2.asm"
INCLUDE "text/maps/SSAnne3.asm"
INCLUDE "text/maps/SSAnne5.asm"
INCLUDE "text/maps/SSAnne6.asm"
INCLUDE "text/maps/SSAnne7.asm"
INCLUDE "text/maps/SSAnne8.asm"
INCLUDE "text/maps/SSAnne9.asm"
INCLUDE "text/maps/SSAnne10.asm"
INCLUDE "text/maps/VictoryRoad3.asm"
INCLUDE "text/maps/RocketHideout1.asm"
INCLUDE "text/maps/RocketHideout2.asm"
INCLUDE "text/maps/RocketHideout3.asm"
INCLUDE "text/maps/RocketHideout4.asm"
INCLUDE "text/maps/RocketHideoutElevator.asm"
INCLUDE "text/maps/SilphCo2F.asm"
INCLUDE "text/maps/SilphCo3F.asm"
INCLUDE "text/maps/SilphCo4F.asm"
INCLUDE "text/maps/SilphCo5F_1.asm"


SECTION "Text 2", ROMX, BANK[TEXT_2]

INCLUDE "text/maps/SilphCo5F_2.asm"
INCLUDE "text/maps/SilphCo6F.asm"
INCLUDE "text/maps/SilphCo7F.asm"
INCLUDE "text/maps/SilphCo8F.asm"
INCLUDE "text/maps/SilphCo9F.asm"
INCLUDE "text/maps/SilphCo10F.asm"
INCLUDE "text/maps/SilphCo11F.asm"
INCLUDE "text/maps/Mansion2.asm"
INCLUDE "text/maps/Mansion3.asm"
INCLUDE "text/maps/Mansion4.asm"
INCLUDE "text/maps/SafariZoneEast.asm"
INCLUDE "text/maps/SafariZoneNorth.asm"
INCLUDE "text/maps/SafariZoneWest.asm"
INCLUDE "text/maps/SafariZoneCenter.asm"
INCLUDE "text/maps/SafariZoneRestHouse1.asm"
INCLUDE "text/maps/SafariZoneSecretHouse.asm"
INCLUDE "text/maps/SafariZoneRestHouse2.asm"
INCLUDE "text/maps/SafariZoneRestHouse3.asm"
INCLUDE "text/maps/SafariZoneRestHouse4.asm"
INCLUDE "text/maps/UnknownDungeon3.asm"
INCLUDE "text/maps/VictoryRoad1.asm"
INCLUDE "text/maps/LancesRoom.asm"
INCLUDE "text/maps/HallOfFame.asm"
INCLUDE "text/maps/ChampionsRoom.asm"
INCLUDE "text/maps/LoreleisRoom.asm"
INCLUDE "text/maps/BrunosRoom.asm"
INCLUDE "text/maps/AgathasRoom.asm"
INCLUDE "text/maps/RockTunnel2_1.asm"


SECTION "Text 3", ROMX, BANK[TEXT_3]

INCLUDE "text/maps/RockTunnel2_2.asm"
INCLUDE "text/maps/SeafoamIslands5.asm"
INCLUDE "text/maps/move_relearner.asm"
INCLUDE "text/maps/move_deleter.asm"
INCLUDE "text/maps/move_tutor.asm"

_AIBattleWithdrawText::
	TX_RAM wTrainerName
	text " @"
	TX_RAM wCurTrainerName
	text ""
	line "withdrew"
	cont "@"
	TX_RAM wEnemyMonNick
	text "!"
	prompt

_AIBattleUseItemText::
	TX_RAM wTrainerName
	text " @"
	TX_RAM wCurTrainerName
	text ""
	line "used @"
	TX_RAM wcd6d
	text ""
	cont "on @"
	TX_RAM wEnemyMonNick
	text "!"
	prompt

_TradeWentToText::
	TX_RAM wcf4b
	text " went"
	line "to @"
	TX_RAM wLinkEnemyTrainerName
	text "."
	done

_TradeForText::
	text "For [PLAYER]'s"
	line "@"
	TX_RAM wcf4b
	text ","
	done

_TradeSendsText::
	TX_RAM wLinkEnemyTrainerName
	text " sends"
	line "@"
	TX_RAM wcd6d
	text "."
	done

_TradeWavesFarewellText::
	TX_RAM wLinkEnemyTrainerName
	text " waves"
	line "farewell as"
	done

_TradeTransferredText::
	TX_RAM wcd6d
	text " is"
	line "transferred."
	done

_TradeTakeCareText::
	text "Take good care of"
	line "@"
	TX_RAM wcd6d
	text "."
	done

_TradeWillTradeText::
	TX_RAM wLinkEnemyTrainerName
	text " will"
	line "trade @"
	TX_RAM wcd6d
	text ""
	done

_TradeforText::
	text "for [PLAYER]'s"
	line "@"
	TX_RAM wcf4b
	text "."
	done

_PlaySlotMachineText::
	text "A slot machine!"
	line "Want to play?"
	done

_OutOfCoinsSlotMachineText::
	text "Darn!"
	line "Ran out of coins!"
	done

_BetHowManySlotMachineText::
	text "Bet how many"
	line "coins?"
	done

_StartSlotMachineText::
	text "Start!"
	done

_NotEnoughCoinsSlotMachineText::
	text "Not enough"
	line "coins!"
	prompt

_OneMoreGoSlotMachineText::
	text "One more "
	line "go?"
	done

_LinedUpText::
	text " lined up!"
	line "Scored @"
	TX_RAM wcf4b
	text " coins!"
	done

_NotThisTimeText::
	text "Not this time!"
	prompt

_YeahText::
	text "Yeah!@@"

_DexSeenOwnedText::
	text "#dex   Seen:@"
	TX_NUM wDexRatingNumMonsSeen, 1, 3
	text ""
	line "         Owned:@"
	TX_NUM wDexRatingNumMonsOwned, 1, 3
	db "@"

_DexRatingText::
	text "#dex Rating", $6d
	done

_GymStatueText1::
	TX_RAM wGymCityName
	text ""
	line "#mon Gym"
	cont "Leader: @"
	TX_RAM wGymLeaderName
	text ""

	para "Winning trainers:"
	line "[RIVAL]"
	done

_GymStatueText2::
	TX_RAM wGymCityName
	text ""
	line "#mon Gym"
	cont "Leader: @"
	TX_RAM wGymLeaderName
	text ""

	para "Winning trainers:"
	line "[RIVAL]"
	cont "[PLAYER]"
	done

_ViridianCityPokecenterGuyText::
	text "#mon Centers"
	line "heal your tired,"
	cont "hurt or fainted"
	cont "#mon!"
	done

_PewterCityPokecenterGuyText::
	text "Yawn!"

	para "When Jigglypuff"
	line "sings, #mon"
	cont "get drowsy..."

	para "...Me too..."
	line "Snore..."
	done

_CeruleanPokecenterGuyText::
	text "Bill has lots of"
	line "#mon!"

	para "He collects rare"
	line "ones too!"
	done

_LavenderPokecenterGuyText::
	text "Cubones wear"
	line "skulls, right?"

	para "People will pay a"
	line "lot for one!"
	done

_MtMoonPokecenterBenchGuyText::
	text "If you have too"
	line "many #mon, you"
	cont "should store them"
	cont "via PC!"
	done

_RockTunnelPokecenterGuyText::
	text "I heard that"
	line "Ghosts haunt"
	cont "Lavender Town!"
	done

_UnusedBenchGuyText1::
	text "I wish I could"
	line "catch #mon."
	done

_UnusedBenchGuyText2::
	text "I'm tired from"
	line "all the fun..."
	done

_UnusedBenchGuyText3::
	text "Silph's manager"
	line "is hiding in the"
	cont "Safari Zone."
	done

_VermilionPokecenterGuyText::
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

_CeladonCityPokecenterGuyText::
	text "If I had a Bike,"
	line "I would go to"
	cont "Cycling Road!"
	done

_FuchsiaCityPokecenterGuyText::
	text "If you're studying "
	line "#mon, visit"
	cont "the Safari Zone."

	para "It has all sorts"
	line "of rare #mon."
	done

_CinnabarPokecenterGuyText::
	text "#mon can still"
	line "learn techniques"
	cont "after canceling"
	cont "evolution."

	para "Evolution can wait"
	line "until new moves"
	cont "have been learned."
	done

_SaffronCityPokecenterGuyText1::
	text "It would be great"
	line "if the Elite Four"
	cont "came and stomped"
	cont "Team Rocket!"
	done

_SaffronCityPokecenterGuyText2::
	text "Team Rocket took"
	line "off! We can go"
	cont "out safely again!"
	cont "That's great!"
	done

_CeladonCityHotelText::
	text "My sis brought me"
	line "on this vacation!"
	done

_BookcaseText::
	text "Crammed full of"
	line "#mon books!"
	done

_NewBicycleText::
	text "A shiny new"
	line "Bicycle!"
	done

_PushStartText::
	text "Push Start to"
	line "open the Menu!"
	done

_SaveOptionText::
	text "The Save option is"
	line "on the Menu"
	cont "screen."
	done

_StrengthsAndWeaknessesText::
	text "All #mon types"
	line "have strong and"
	cont "weak points"
	cont "against others."
	done

_TimesUpText::
	text "PA: Ding-dong!"

	para "Time's up!"
	prompt

_GameOverText::
	text "PA: Your Safari"
	line "Game is over!"
	done

INCLUDE "text/quizzes.asm"

_MagazinesText::
	text "#mon magazines!"

	para "#mon notebooks!"

	para "#mon graphs!"
	done

_BillsHouseMonitorText::
	text "Teleporter is"
	line "displayed on the"
	cont "PC monitor."
	done

_BillsHouseInitiatedText::
	text "[PLAYER] initiated"
	line "Teleporter's Cell"
	cont "Separator!@@"

_BillsHousePokemonListText1::
	text "Bill's favorite"
	line "#mon list!"
	prompt

_BillsHousePokemonListText2::
	text "Which #mon do"
	line "you want to see?"
	done

_OakLabEmailText::
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

_GameCornerCoinCaseText::
	text "A Coin Case is"
	line "required!"
	done

_GameCornerNoCoinsText::
	text "You don't have"
	line "any coins!"
	done

_GameCornerOutOfOrderText::
	text "OUT OF ORDER"
	line "This is broken."
	done

_GameCornerOutToLunchText::
	text "OUT TO LUNCH"
	line "This is reserved."
	done

_GameCornerSomeonesKeysText::
	text "Someone's keys!"
	line "They'll be back."
	done

_JustAMomentText::
	text "Just a moment."
	done

TMNotebookText::
	text "It's a pamphlet"
	line "on TMs."

	para "..."

	para "There are 50 TMs"
	line "in all."

	para "There are also 5"
	line "HMs that can be"
	cont "used repeatedly."

	para "Silph Co.@@"

_TurnPageText::
	text "Turn the page?"
	done

_ViridianSchoolNotebookText5::
	text "Girl: Hey! Don't"
	line "look at my notes!@@"

_ViridianSchoolNotebookText1::
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

_ViridianSchoolNotebookText2::
	text "Second page..."

	para "A healthy #mon"
	line "may be hard to"
	cont "catch, so weaken"
	cont "it first!"

	para "Poison, burns and"
	line "other damage are"
	cont "effective!"
	prompt

_ViridianSchoolNotebookText3::
	text "Third page..."

	para "#mon trainers"
	line "seek others to"
	cont "engage in #mon"
	cont "fights."

	para "Battles are"
	line "constantly fought"
	cont "at #mon Gyms."
	prompt

_ViridianSchoolNotebookText4::
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

_EnemiesOnEverySideText::
	text "Enemies on every"
	line "side!"
	done

_WhatGoesAroundComesAroundText::
	text "What goes around"
	line "comes around!"
	done

_FightingDojoText::
	text "Fighting Dojo"
	done

_IndigoPlateauHQText::
	text "Indigo Plateau"
	line "#mon League HQ"
	done

_RedBedroomSNESText::
	text "[PLAYER] is"
	line "playing the SNES!"
	cont "...Okay!"
	cont "It's time to go!"
	done

_Route15UpstairsBinocularsText::
	text "Looked into the"
	line "binoculars..."

	para "A large, shining"
	line "bird is flying"
	cont "toward the sea."
	done

_AerodactylFossilText::
	text "Aerodactyl Fossil"
	line "A primitive and"
	cont "rare #mon."
	done

_KabutopsFossilText::
	text "Kabutops Fossil"
	line "A primitive and"
	cont "rare #mon."
	done

_LinkCableHelpText1::
	text "Trainer Tips"

	para "Using a Game Link"
	line "Cable"
	prompt

_LinkCableHelpText2::
	text "Which heading do"
	line "you want to read?"
	done

_LinkCableInfoText1::
	text "When you have"
	line "linked your Game"
	cont "Boy with another"
	cont "Game Boy, talk to"
	cont "the attendant on"
	cont "the right in any"
	cont "#mon Center."
	prompt

_LinkCableInfoText2::
	text "Colosseum lets"
	line "you play against"
	cont "a friend."
	prompt

_LinkCableInfoText3::
	text "Trade Center is"
	line "used for trading"
	cont "#mon."
	prompt

_ViridianSchoolBlackboardText1::
	text "The blackboard"
	line "describes #mon"
	cont "Status changes"
	cont "during battles."
	prompt

_ViridianSchoolBlackboardText2::
	text "Which heading do"
	line "you want to read?"
	done

_ViridianBlackboardSleepText::
	text "A #mon can't"
	line "attack if it's"
	cont "asleep!"

	para "#mon will stay"
	line "asleep even after"
	cont "battles."

	para "Use Awakening to"
	line "wake them up!"
	prompt

_ViridianBlackboardPoisonText::
	text "When poisoned, a"
	line "#mon's health"
	cont "steadily drops."

	para "Poison lingers"
	line "after battles."

	para "Use an Antidote"
	line "to cure poison!"
	prompt

_ViridianBlackboardPrlzText::
	text "Paralysis could"
	line "make #mon"
	cont "moves misfire!"

	para "Paralysis remains"
	line "after battles."

	para "Use ParalyzeHeal"
	line "for treatment!"
	prompt

_ViridianBlackboardBurnText::
	text "A burn reduces"
	line "power and speed."
	cont "It also causes"
	cont "ongoing damage."

	para "Burns remain"
	line "after battles."

	para "Use Burn Heal to"
	line "cure a burn!"
	prompt

_ViridianBlackboardFrozenText::
	text "If frozen, a"
	line "#mon becomes"
	cont "totally immobile!"

	para "It stays frozen"
	line "even after the"
	cont "battle ends."

	para "Use Ice Heal to"
	line "thaw out #mon!"
	prompt

_VermilionGymTrashText::
	text "Nope, there's"
	line "only trash here."
	done

_VermilionGymTrashSuccessText1::
	text "Hey! There's a"
	line "switch under the"
	cont "trash!"
	cont "Turn it on!"

	para "The 1st electric"
	line "lock opened!@@"

_VermilionGymTrashSuccessText2::
	text "Hey! There's"
	line "another switch"
	cont "under the trash!"
	cont "Turn it on!"
	prompt

_VermilionGymTrashSuccessText3::
	text "The 2nd electric"
	line "lock opened!"

	para "The motorized door"
	line "opened!@@"

_VermilionGymTrashFailText::
	text "Nope! There's"
	line "only trash here."
	cont "Hey! The electric"
	cont "locks were reset!@@"

_FoundHiddenItemText::
	text "[PLAYER] found"
	line "@"
	TX_RAM wcd6d
	text "!@@"

_HiddenItemBagFullText::
	text "But, [PLAYER] has"
	line "no more room for"
	cont "other items!"
	done

_FoundHiddenCoinsText::
	text "[PLAYER] found"
	line "@"
	TX_BCD hCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " coins!@@"

_FoundHiddenCoins2Text::
	text "[PLAYER] found"
	line "@"
	TX_BCD hCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " coins!@@"

_DroppedHiddenCoinsText::
	text ""
	para "Oops! Dropped"
	line "some coins!"
	done

_IndigoPlateauStatuesText1::
	text "Indigo Plateau"
	prompt

_IndigoPlateauStatuesText2::
	text "The ultimate goal"
	line "of trainers!"
	cont "#mon League HQ"
	done

_IndigoPlateauStatuesText3::
	text "The highest"
	line "#mon authority"
	cont "#mon League HQ"
	done

_PokemonBooksText::
	text "Crammed full of"
	line "#mon books!"
	done

_DiglettSculptureText::
	text "It's a sculpture"
	line "of Diglett."
	done

_ElevatorText::
	text "This is an"
	line "elevator."
	done

_TownMapText::
	text "A Kanto map.@@"

_PokemonStuffText::
	text "Wow! Tons of"
	line "#mon stuff!"
	done

_OutOfSafariBallsText::
	text "PA: Ding-dong!"

	para "You are out of"
	line "Safari Balls!"
	prompt

_WildRanText::
	text "Wild @"
	TX_RAM wEnemyMonNick
	text ""
	line "ran!"
	prompt

_EnemyRanText::
	text "Enemy @"
	TX_RAM wEnemyMonNick
	text ""
	line "ran!"
	prompt

_HurtByPoisonText::
	text "[USER]'s"
	line "hurt by poison!"
	prompt

_HurtByBurnText::
	text "[USER]'s"
	line "hurt by the burn!"
	prompt

_HurtByLeechSeedText::
	text "Leech Seed saps"
	line "[USER]!"
	prompt

_EnemyMonFaintedText::
	text "Enemy @"
	TX_RAM wEnemyMonNick
	text ""
	line "fainted!"
	prompt

_MoneyForWinningText::
	text "[PLAYER] got ¥@"
	TX_BCD wAmountMoneyWon, 3 | LEADING_ZEROES | LEFT_ALIGN
	text ""
	line "for winning!"
	prompt

_TrainerDefeatedText::
	TX_RAM wTrainerName
	text " @"
	TX_RAM wCurTrainerName
	text ""
	line "was defeated!"
	prompt

_PlayerMonFaintedText::
	TX_RAM wBattleMonNick
	text ""
	line "fainted!"
	prompt

_UseNextMonText::
	text "Use next #mon?"
	done

_Sony1WinText::
	text "[RIVAL]: Yeah! Am"
	line "I great or what?"
	prompt

_PlayerBlackedOutText2::
	text "[PLAYER] is out of"
	line "useable #mon!"

	para "[PLAYER] blacked"
	line "out!"
	prompt

_LinkBattleLostText::
	text "[PLAYER] lost to"
	line "@"
	TX_RAM wTrainerName
	text "!"
	prompt

_TrainerAboutToUseText::
	TX_RAM wTrainerName
	text " @"
	TX_RAM wCurTrainerName
	text ""
	line "is about to use"
	cont"@"
	TX_RAM wEnemyMonNick
	text "!"

	para "Will [PLAYER]"
	line "change #mon?"
	done

_TrainerSentOutText::
	TX_RAM wTrainerName
	text " @"
	TX_RAM wCurTrainerName
	text ""
	line "sent out"
	cont "@"
	TX_RAM wEnemyMonNick
	text "!"
	done

_NoWillText::
	text "There's no will"
	line "to fight!"
	prompt

_CantEscapeText::
	text "Can't escape!"
	prompt

_NoRunningText::
	text "No! There's no"
	line "running from a"
	cont "trainer battle!"
	prompt

_GotAwayText::
	text "Got away safely!"
	prompt

_ItemsCantBeUsedHereText::
	text "Items can't be"
	line "used here."
	prompt

_AlreadyOutText::
	TX_RAM wBattleMonNick
	text " is"
	line "already out!"
	prompt

_MoveNoPPText::
	text "No PP left for"
	line "this move!"
	prompt

_MoveDisabledText::
	text "The move is"
	line "disabled!"
	prompt

_NoMovesLeftText::
	TX_RAM wBattleMonNick
	text " has no"
	line "moves left!"
	done

_MultiHitText::
	text "Hit the enemy"
	line "@"
	TX_NUM wPlayerNumHits,1,1
	text " times!"
	prompt

_ScaredText::
	TX_RAM wBattleMonNick
	text " is too"
	line "scared to move!"
	prompt

_GetOutText::
	text "Ghost: Get out..."
	line "Get out..."
	prompt

_FastAsleepText::
	text "[USER]"
	line "is fast asleep!"
	prompt

_WokeUpText::
	text "[USER]"
	line "woke up!"
	prompt

_IsFrozenText::
	text "[USER]"
	line "is frozen solid!"
	prompt

_FullyParalyzedText::
	text "[USER]'s"
	line "fully paralyzed!"
	prompt

_FlinchedText::
	text "[USER]"
	line "flinched!"
	prompt

_MustRechargeText::
	text "[USER]"
	line "must recharge!"
	prompt

_DisabledNoMoreText::
	text "[USER]'s"
	line "disabled no more!"
	prompt

_IsConfusedText::
	text "[USER]"
	line "is confused!"
	prompt

_HurtItselfText::
	text "It hurt itself in"
	line "its confusion!"
	prompt

_ConfusedNoMoreText::
	text "[USER]'s"
	line "confused no more!"
	prompt

_SavingEnergyText::
	text "[USER]"
	line "is saving energy!"
	prompt

_UnleashedEnergyText::
	text "[USER]"
	line "unleashed energy!"
	prompt

_ThrashingAboutText::
	text "[USER]'s"
	line "thrashing about!"
	done

_AttackContinuesText::
	text "[USER]'s"
	line "attack continues!"
	done

_CantMoveText::
	text "[USER]"
	line "can't move!"
	prompt

_MoveIsDisabledText::
	text "[USER]'s"
	line "@"
	TX_RAM wcd6d
	text " is"
	cont "disabled!"
	prompt

_MonName1Text::
	text "[USER]@@"

_UsedText::
	text ""
	line "used @@"

_InsteadText::
	text "instead,"
	cont "@@"

_CF4BText::
	TX_RAM wcf4b
	text "!"
	done

_AttackMissedText::
	text "[USER]'s"
	line "attack missed!"
	prompt

_KeptGoingAndCrashedText::
	text "[USER]"
	line "kept going and"
	cont "crashed!"
	prompt

_UnaffectedText::
	text "[TARGET]'s"
	line "unaffected!"
	prompt

_DoesntAffectMonText::
	text "It doesn't affect"
	line "[TARGET]!"
	prompt

_CriticalHitText::
	text "Critical hit!"
	prompt

_OHKOText::
	text "One-hit KO!"
	prompt

_LoafingAroundText::
	TX_RAM wBattleMonNick
	text " is"
	line "loafing around."
	prompt

_BeganToNapText::
	TX_RAM wBattleMonNick
	text " began"
	line "to nap!"
	prompt

_WontObeyText::
	TX_RAM wBattleMonNick
	text " won't"
	line "obey!"
	prompt

_TurnedAwayText::
	TX_RAM wBattleMonNick
	text " turned"
	line "away!"
	prompt

_IgnoredOrdersText::
	TX_RAM wBattleMonNick
	text ""
	line "ignored orders!"
	prompt

_SubstituteTookDamageText::
	text "The Substitute"
	line "took damage for"
	cont "[TARGET]!"
	prompt

_SubstituteBrokeText::
	text "[TARGET]'s"
	line "Substitute broke!"
	prompt

_BuildingRageText::
	text "[USER]'s"
	line "Rage is building!"
	prompt

_MirrorMoveFailedText::
	text "The Mirror Move"
	next "failed!"
	prompt

_HitXTimesText::
	text "Hit @"
	TX_NUM wEnemyNumHits, 1, 1
	text " times!"
	prompt

_GainedText::
	TX_RAM wcd6d
	text " gained"
	line "@@"

_WithExpAllText::
	text "[PLAYER]'s other"
	line "#mon gained"
	cont "Exp. Points from@"
	db $7
	text "the Exp. Share!"
	prompt

_BoostedText::
	text "a boosted"
	cont "@@"

_ExpPointsText::
	TX_NUM wExpAmountGained, 2, 4
	text " Exp. Points!"
	prompt

_GrewLevelText::
	TX_RAM wcd6d
	text " grew"
	line "to level @"
	TX_NUM wCurEnemyLVL, 1, 3
	text "!@@"

_WildMonAppearedText::
	text "Wild @"
	TX_RAM wEnemyMonNick
	text ""
	line "appeared!"
	prompt

_HookedMonAttackedText::
	text "The hooked"
	line "@"
	TX_RAM wEnemyMonNick
	text ""
	cont "attacked!"
	prompt

_EnemyAppearedText::
	TX_RAM wEnemyMonNick
	text ""
	line "appeared!"
	prompt

_TrainerWantsToFightText::
	TX_RAM wTrainerName
	text " @"
	TX_RAM wCurTrainerName
	text ""
	line "wants to battle!"
	prompt

_UnveiledGhostText::
	text "Silph Scope"
	line "unveiled the"
	cont "Ghost's identity!"
	prompt

_GhostCantBeIDdText::
	text "Darn! The Ghost"
	line "can't be ID'd!"
	prompt

_GoText::
	text "Go! @@"

_DoItText::
	text "Do it! @@"

_GetmText::
	text "Get'm! @@"

_EnemysWeakText::
	text "The enemy's weak!"
	line "Get'm! @@"

_PlayerMon1Text::
	TX_RAM wBattleMonNick
	text "!"
	done

_PlayerMon2Text::
	TX_RAM wBattleMonNick
	text " @@"

_EnoughText::
	text "enough!@@"

_OKExclamationText::
	text "OK!@@"

_GoodText::
	text "good!@@"

_ComeBackText::
	text ""
	line "Come back!"
	done

_SuperEffectiveText::
	text "It's super"
	line "effective!"
	prompt

_NotVeryEffectiveText::
	text "It's not very"
	line "effective..."
	prompt

_SafariZoneEatingText::
	text "Wild @"
	TX_RAM wEnemyMonNick
	text ""
	line "is eating!"
	prompt

_SafariZoneAngryText::
	text "Wild @"
	TX_RAM wEnemyMonNick
	text ""
	line "is angry!"
	prompt

; money related
_PickUpPayDayMoneyText::
	text "[PLAYER] picked up"
	line "¥@"
	TX_BCD wTotalPayDayMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text "!"
	prompt

_ClearSaveDataText::
	text "Clear all saved"
	line "data?"
	done

_WhichFloorText::
	text "Which floor do"
	line "you want? "
	done

_PartyMenuNormalText::
	text "Choose a #mon."
	done

_PartyMenuItemUseText::
	text "Use item on which"
	line "#mon?"
	done

_PartyMenuBattleText::
	text "Bring out which"
	line "#mon?"
	done

_PartyMenuUseTMText::
	text "Teach to which"
	line "#mon?"
	done

_PartyMenuSwapMonText::
	text "Move #mon"
	line "where?"
	done

_PotionText::
	TX_RAM wcd6d
	text ""
	line "recovered by @"
	TX_NUM wHPBarHPDifference, 2, 3
	text "!"
	done

_AntidoteText::
	TX_RAM wcd6d
	text " was"
	line "cured of poison!"
	done

_ParlyzHealText::
	TX_RAM wcd6d
	text "'s"
	line "rid of paralysis!"
	done

_BurnHealText::
	TX_RAM wcd6d
	text "'s"
	line "burn was healed!"
	done

_IceHealText::
	TX_RAM wcd6d
	text " was"
	line "defrosted!"
	done

_AwakeningText::
	TX_RAM wcd6d
	text ""
	line "woke up!"
	done

_FullHealText::
	TX_RAM wcd6d
	text "'s"
	line "health returned!"
	done

_ReviveText::
	TX_RAM wcd6d
	text ""
	line "is revitalized!"
	done

_RareCandyText::
	TX_RAM wcd6d
	text " grew"
	line "to level @"
	TX_NUM wCurEnemyLVL, 1, 3
	text "!@@"

_TurnedOnPC1Text::
	text "[PLAYER] turned on"
	line "the PC."
	prompt

_AccessedBillsPCText::
	text "Accessed Bill's"
	line "PC."

	para "Accessed #mon"
	line "Storage System."
	prompt

_AccessedSomeonesPCText::
	text "Accessed someone's"
	line "PC."

	para "Accessed #mon"
	line "Storage System."
	prompt

_AccessedMyPCText::
	text "Accessed my PC."

	para "Accessed Item"
	line "Storage System."
	prompt

_TurnedOnPC2Text::
	text "[PLAYER] turned on"
	line "the PC."
	prompt

_WhatDoYouWantText::
	text "What do you want"
	line "to do?"
	done

_WhatToDepositText::
	text "What do you want"
	line "to deposit?"
	done

_DepositHowManyText::
	text "How many?"
	done

_ItemWasStoredText::
	TX_RAM wcd6d
	text " was"
	line "stored via PC."
	prompt

_NothingToDepositText::
	text "You have nothing"
	line "to deposit."
	prompt

_NoRoomToStoreText::
	text "No room left to"
	line "store items."
	prompt

_WhatToWithdrawText::
	text "What do you want"
	line "to withdraw?"
	done

_WithdrawHowManyText::
	text "How many?"
	done

_WithdrewItemText::
	text "Withdrew"
	line "@"
	TX_RAM wcd6d
	text "."
	prompt

_NothingStoredText::
	text "There is nothing"
	line "stored."
	prompt

_CantCarryMoreText::
	text "You can't carry"
	line "any more items."
	prompt

_WhatToTossText::
	text "What do you want"
	line "to toss away?"
	done

_TossHowManyText::
	text "How many?"
	done

_AccessedHoFPCText::
	text "Accessed #mon"
	line "League's site."

	para "Accessed the Hall"
	line "of Fame List."
	prompt

_SwitchOnText::
	text "Switch on!"
	prompt

_WhatText::
	text "What?"
	done

_DepositWhichMonText::
	text "Deposit which"
	line "#mon?"
	done

_MonWasStoredText::
	TX_RAM wcf4b
	text " was"
	line "stored in Box @"
	TX_RAM wBoxNumString
	text "."
	prompt

_CantDepositLastMonText::
	text "You can't deposit"
	line "the last #mon!"
	prompt

_BoxFullText::
	text "Oops! This Box is"
	line "full of #mon."
	prompt

_MonIsTakenOutText::
	TX_RAM wcf4b
	text " is"
	line "taken out."
	cont "Got @"
	TX_RAM wcf4b
	text "."
	prompt

_NoMonText::
	text "What? There are"
	line "no #mon here!"
	prompt

_CantTakeMonText::
	text "You can't take"
	line "any more #mon."

	para "Deposit #mon"
	line "first."
	prompt

_ReleaseWhichMonText::
	text "Release which"
	line "#mon?"
	done

_OnceReleasedText::
	text "Once released,"
	line "@"
	TX_RAM wcf4b
	text " is"
	cont "gone forever. OK?"
	done

_MonWasReleasedText::
	TX_RAM wcf4b
	text " was"
	line "released outside."
	cont "Bye @"

_CF4BExclamationText::
	TX_RAM wcf4b
	text "!"
	prompt

_RequireCoinCaseText::
	text "A Coin Case is"
	line "required!@@"

_ExchangeCoinsForPrizesText::
	text "We exchange your"
	line "coins for prizes."
	prompt

_WhichPrizeText::
	text "Which prize do"
	line "you want?"
	done

_HereYouGoText::
	text "Here you go!@@"

_SoYouWantPrizeText::
	text "So, you want"
	line "@"
	TX_RAM wcd6d
	text "?"
	done

_SorryNeedMoreCoinsText::
	text "Sorry, you need"
	line "more coins.@@"

_OopsYouDontHaveEnoughRoomText::
	text "Oops! You don't"
	line "have enough room.@@"

_OhFineThenText::
	text "Oh, fine then.@@"

_GetDexRatedText::
	text "Want to get your"
	line "#dex rated?"
	done

_ClosedOaksPCText::
	text "Closed link to"
	line "Prof.Oak's PC.@@"

_AccessedOaksPCText::
	text "Accessed Prof."
	line "Oak's PC."

	para "Accessed #dex"
	line "Rating System."
	prompt

_WhereWouldYouLikeText::
	text "Where would you"
	line "like to go?"
	done

_PleaseWaitText::
	text "OK, please wait"
	line "just a moment."
	done

_LinkCanceledText::
	text "The link was"
	line "canceled."
	done

INCLUDE "text/oakspeech.asm"

_DoYouWantToNicknameText::
	text "Do you want to"
	line "give a nickname"
	cont "to @"
	TX_RAM wcd6d
	text "?"
	done

_YourNameIsText::
	text "Right! So your"
	line "name is [PLAYER]!"
	prompt

_HisNameIsText::
	text "That's right! I"
	line "remember now! His"
	cont "name is [RIVAL]!"
	prompt

_WillBeTradedText::
	TX_RAM wNameOfPlayerMonToBeTraded
	text " and"
	line "@"
	TX_RAM wcd6d
	text " will"
	cont "be traded."
	done

_Char00Text::
	TX_NUM hSpriteIndexOrTextID,1,2
	text " ERROR."
	done

_Char55Text::
	text $4B,"@@"

INCLUDE "text/maps/DiglettsCaveExit.asm"
INCLUDE "text/maps/ViridianForestExit.asm"
INCLUDE "text/maps/Route2House.asm"
INCLUDE "text/maps/Route2Gate.asm"
INCLUDE "text/maps/ViridianForestEntrance.asm"
INCLUDE "text/maps/MtMoonPokecenter.asm"
INCLUDE "text/maps/Route5Gate.asm"
INCLUDE "text/maps/Daycarem_1.asm"
INCLUDE "text/maps/BeachHouse.asm"


SECTION "Text 4", ROMX, BANK[TEXT_4]

INCLUDE "text/maps/Daycarem_2.asm"
INCLUDE "text/maps/PathEntranceRoute6.asm"
INCLUDE "text/maps/PathEntranceRoute7.asm"
INCLUDE "text/maps/PathEntranceRoute5Copy.asm"
INCLUDE "text/maps/PathEntranceRoute8.asm"
INCLUDE "text/maps/RockTunnelPokecenter.asm"
INCLUDE "text/maps/RockTunnel1.asm"
INCLUDE "text/maps/PowerPlant.asm"
INCLUDE "text/maps/Route11Gate1F.asm"
INCLUDE "text/maps/Route11Gate2F.asm"
INCLUDE "text/maps/DiglettsCaveRoute11.asm"
INCLUDE "text/maps/Route12Gate1F.asm"
INCLUDE "text/maps/Route12Gate2F.asm"
INCLUDE "text/maps/Route12House.asm"
INCLUDE "text/maps/Route15Gate1F.asm"
INCLUDE "text/maps/Route15Gate2F.asm"
INCLUDE "text/maps/Route16Gate1F.asm"
INCLUDE "text/maps/Route16Gate2F.asm"
INCLUDE "text/maps/Route16House.asm"
INCLUDE "text/maps/Route18Gate1F.asm"
INCLUDE "text/maps/Route18Gate2F.asm"
INCLUDE "text/maps/Route22Gate.asm"
INCLUDE "text/maps/VictoryRoad2.asm"
INCLUDE "text/maps/BillsHouse.asm"
INCLUDE "text/maps/Route1.asm"
INCLUDE "text/maps/Route2.asm"
INCLUDE "text/maps/Route3.asm"
INCLUDE "text/maps/Route4.asm"
INCLUDE "text/maps/Route5.asm"
INCLUDE "text/maps/Route6.asm"
INCLUDE "text/maps/Route7.asm"
INCLUDE "text/maps/Route8.asm"
INCLUDE "text/maps/Route9.asm"
INCLUDE "text/maps/Route10.asm"
INCLUDE "text/maps/Route11_1.asm"


SECTION "Text 5", ROMX, BANK[TEXT_5]

INCLUDE "text/maps/Route11_2.asm"
INCLUDE "text/maps/Route12.asm"
INCLUDE "text/maps/Route13.asm"
INCLUDE "text/maps/Route14.asm"
INCLUDE "text/maps/Route15.asm"
INCLUDE "text/maps/Route16.asm"
INCLUDE "text/maps/Route17.asm"
INCLUDE "text/maps/Route18.asm"
INCLUDE "text/maps/Route19.asm"
INCLUDE "text/maps/Route20.asm"
INCLUDE "text/maps/Route21.asm"
INCLUDE "text/maps/Route22.asm"
INCLUDE "text/maps/Route23.asm"
INCLUDE "text/maps/Route24_1.asm"


SECTION "Text 6", ROMX, BANK[TEXT_6]

INCLUDE "text/maps/Route24_2.asm"
INCLUDE "text/maps/Route25.asm"

_FileDataDestroyedText::
	text "The file data is"
	line "destroyed!"
	prompt

_WouldYouLikeToSaveText::
	text "Would you like to"
	line "save the game?"
	done

_GameSavedText::
	text "[PLAYER] saved"
	line "the game!"
	done

_OlderFileWillBeErasedText::
	text "The older file"
	line "will be erased to"
	cont "save. Okay?"
	done

_WhenYouChangeBoxText::
	text "When you change a"
	line "#mon Box, data"
	cont "will be saved."

	para "Is that okay?"
	done

_ChooseABoxText::
	text "Choose a"
	line "[pkmn] Box.@@"

_EvolvedText::
	TX_RAM wcf4b
	text " evolved"
	done

_IntoText::
	text ""
	line "into @"
	TX_RAM wcd6d
	text "!"
	done

_StoppedEvolvingText::
	text "Huh? @"
	TX_RAM wcf4b
	text ""
	line "stopped evolving!"
	prompt

_IsEvolvingText::
	text "What? @"
	TX_RAM wcf4b
	text ""
	line "is evolving!"
	done

_FellAsleepText::
	text "[TARGET]"
	line "fell asleep!"
	prompt

_AlreadyAsleepText::
	text "[TARGET]'s"
	line "already asleep!"
	prompt

_PoisonedText::
	text "[TARGET]"
	line "was poisoned!"
	prompt

_BadlyPoisonedText::
	text "[TARGET]'s"
	line "badly poisoned!"
	prompt

_BurnedText::
	text "[TARGET]"
	line "was burned!"
	prompt

_FrozenText::
	text "[TARGET]"
	line "was frozen solid!"
	prompt

_FireDefrostedText::
	text "[TARGET]"
	line "was defrosted!"
	prompt

_MonsStatsRoseText::
	text "[USER]'s"
	line "@"
	TX_RAM wcf4b
	text "@@"

_GreatlyRoseText::
	text $4c, "sharply@@"

_RoseText::
	text " rose!"
	prompt

_WontRiseAnymoreText::
	text "[USER]'s"
	line "@"
	TX_RAM wcf4b
	text " won't"
	cont "go any higher!"
	prompt

_MonsStatsFellText::
	text "[TARGET]'s"
	line "@"
	TX_RAM wcf4b
	text "@@"

_GreatlyFellText::
	text $4c, "harshly@@"

_FellText::
	text " fell!"
	prompt

_WontFallAnymoreText::
	text "[TARGET]'s"
	line "@"
	TX_RAM wcf4b
	text " won't"
	cont "go any lower!"
	prompt

_RanFromBattleText::
	text "[USER]"
	line "ran from battle!"
	prompt

_RanAwayScaredText::
	text "[TARGET]"
	line "ran away scared!"
	prompt

_WasBlownAwayText::
	text "[TARGET]"
	line "was blown away!"
	prompt

_ChargeMoveEffectText::
	text "[USER]@@"

_MadeWhirlwindText::
	text ""
	line "made a whirlwind!"
	prompt

_TookInSunlightText::
	text ""
	line "took in sunlight!"
	prompt

_LoweredItsHeadText::
	text ""
	line "lowered its head!"
	prompt

_SkyAttackGlowingText::
	text ""
	line "is glowing!"
	prompt

_FlewUpHighText::
	text ""
	line "flew up high!"
	prompt

_DugAHoleText::
	text ""
	line "dug a hole!"
	prompt

_BecameConfusedText::
	text "[TARGET]"
	line "became confused!"
	prompt

_MimicLearnedMoveText::
	text "[USER]"
	line "learned"
	cont "@"
	TX_RAM wcd6d
	text "!"
	prompt

_MoveWasDisabledText::
	text "[TARGET]'s"
	line "@"
	TX_RAM wcd6d
	text " was"
	cont "disabled!"
	prompt

_NothingHappenedText::
	text "Nothing happened!"
	prompt

_NoEffectText::
	text "No effect!"
	prompt

_ButItFailedText::
	text "But, it failed! "
	prompt

_DidntAffectText::
	text "It didn't affect"
	line "[TARGET]!"
	prompt

_IsUnaffectedText::
	text "[TARGET]"
	line "is unaffected!"
	prompt

_ParalyzedMayNotAttackText::
	text "[TARGET]'s"
	line "paralyzed! It may"
	cont "not attack!"
	prompt

_SubstituteText::
	text "It created a"
	line "Substitute!"
	prompt

_HasSubstituteText::
	text "[USER]"
	line "has a Substitute!"
	prompt

_TooWeakSubstituteText::
	text "Too weak to make"
	line "a Substitute!"
	prompt

_CoinsScatteredText::
	text "Coins scattered"
	line "everywhere!"
	prompt

_GettingPumpedText::
	text "[USER]'s"
	line "getting pumped!"
	prompt

_WasSeededText::
	text "[TARGET]"
	line "was seeded!"
	prompt

_EvadedAttackText::
	text "[TARGET]"
	line "evaded attack!"
	prompt

_HitWithRecoilText::
	text "[USER]'s"
	line "hit with recoil!"
	prompt

_ConvertedTypeText::
	text "Converted type to"
	line "[TARGET]'s!"
	prompt

_StatusChangesEliminatedText::
	text "All Status changes"
	line "are eliminated!"
	prompt

_StartedSleepingEffect::
	text "[USER]"
	line "started sleeping!"
	done

_FellAsleepBecameHealthyText::
	text "[USER]"
	line "fell asleep and"
	cont "became healthy!"
	done

_RegainedHealthText::
	text "[USER]"
	line "regained health!"
	prompt

_TransformedText::
	text "[USER]"
	line "transformed into"
	cont "@"
	TX_RAM wcd6d
	text "!"
	prompt

_LightScreenProtectedText::
	text "[USER]'s"
	line "protected against"
	cont "special attacks!"
	prompt

_ReflectGainedArmorText::
	text "[USER]"
	line "gained armor!"
	prompt

_ShroudedInMistText::
	text "[USER]'s"
	line "shrouded in mist!"
	prompt

_SuckedHealthText::
	text "Sucked health from"
	line "[TARGET]!"
	prompt

_DreamWasEatenText::
	text "[TARGET]'s"
	line "dream was eaten!"
	prompt

_TradeCenterText1::
	text "!"
	done

_ColosseumText1::
	text "!"
	done

INCLUDE "text/maps/RedsHouse1F.asm"
INCLUDE "text/maps/BluesHouse.asm"
INCLUDE "text/maps/OaksLab.asm"
INCLUDE "text/maps/ViridianPokecenter.asm"
INCLUDE "text/maps/ViridianMart.asm"
INCLUDE "text/maps/ViridianSchool.asm"
INCLUDE "text/maps/ViridianHouse.asm"
INCLUDE "text/maps/ViridianGym.asm"
INCLUDE "text/maps/Museum1F.asm"
INCLUDE "text/maps/Museum2F.asm"
INCLUDE "text/maps/PewterGym_1.asm"


SECTION "Text 7", ROMX, BANK[TEXT_7]

INCLUDE "text/maps/PewterGym_2.asm"
INCLUDE "text/maps/PewterHouse1.asm"
INCLUDE "text/maps/PewterMart.asm"
INCLUDE "text/maps/PewterHouse2.asm"
INCLUDE "text/maps/PewterPokecenter.asm"
INCLUDE "text/maps/TrashedHouse.asm"
INCLUDE "text/maps/CeruleanHouse1.asm"
INCLUDE "text/maps/CeruleanPokecenter.asm"
INCLUDE "text/maps/CeruleanGym.asm"
INCLUDE "text/maps/BikeShop.asm"
INCLUDE "text/maps/CeruleanMart.asm"
INCLUDE "text/maps/CeruleanHouse2.asm"
INCLUDE "text/maps/LavenderPokecenter.asm"
INCLUDE "text/maps/Pokemontower1.asm"
INCLUDE "text/maps/Pokemontower2.asm"
INCLUDE "text/maps/Pokemontower3.asm"
INCLUDE "text/maps/Pokemontower4.asm"
INCLUDE "text/maps/Pokemontower5.asm"
INCLUDE "text/maps/Pokemontower6.asm"
INCLUDE "text/maps/Pokemontower7.asm"
INCLUDE "text/maps/LavenderHouse1.asm"
INCLUDE "text/maps/LavenderMart.asm"
INCLUDE "text/maps/LavenderHouse2.asm"
INCLUDE "text/maps/NameRatersHouse.asm"
INCLUDE "text/maps/VermilionPokecenter.asm"
INCLUDE "text/maps/PokemonFanClub.asm"
INCLUDE "text/maps/VermilionMart.asm"
INCLUDE "text/maps/VermilionGym_1.asm"


SECTION "Text 8", ROMX, BANK[TEXT_8]

INCLUDE "text/maps/VermilionGym_2.asm"
INCLUDE "text/maps/VermilionHouse1.asm"
INCLUDE "text/maps/VermilionDock.asm"
INCLUDE "text/maps/VermilionHouse2.asm"
INCLUDE "text/maps/CeladonMart1.asm"
INCLUDE "text/maps/CeladonMart2.asm"
INCLUDE "text/maps/CeladonMart3.asm"
INCLUDE "text/maps/CeladonMart4.asm"
INCLUDE "text/maps/CeladonMartRoof.asm"
INCLUDE "text/maps/CeladonMansion1.asm"
INCLUDE "text/maps/CeladonMansion2.asm"
INCLUDE "text/maps/CeladonMansion3.asm"
INCLUDE "text/maps/CeladonMansion4.asm"
INCLUDE "text/maps/CeladonMansion5.asm"
INCLUDE "text/maps/CeladonPokecenter.asm"
INCLUDE "text/maps/CeladonGym.asm"
INCLUDE "text/maps/GameCorner.asm"
INCLUDE "text/maps/CeladonMart5.asm"
INCLUDE "text/maps/CeladonPrizeRoom.asm"
INCLUDE "text/maps/CeladonDiner.asm"
INCLUDE "text/maps/CeladonHouse.asm"
INCLUDE "text/maps/CeladonHotel.asm"
INCLUDE "text/maps/FuchsiaMart.asm"
INCLUDE "text/maps/FuchsiaHouse1.asm"
INCLUDE "text/maps/FuchsiaPokecenter.asm"
INCLUDE "text/maps/FuchsiaHouse2.asm"
INCLUDE "text/maps/SafariZoneEntrance.asm"
INCLUDE "text/maps/FuchsiaGym_1.asm"


SECTION "Text 9", ROMX, BANK[TEXT_9]

INCLUDE "text/maps/FuchsiaGym_2.asm"
INCLUDE "text/maps/FuchsiaMeetingRoom.asm"
INCLUDE "text/maps/FuchsiaHouse3.asm"
INCLUDE "text/maps/Mansion1.asm"
INCLUDE "text/maps/CinnabarGym.asm"
INCLUDE "text/maps/CinnabarLab1.asm"
INCLUDE "text/maps/CinnabarLab2.asm"
INCLUDE "text/maps/CinnabarLab3.asm"
INCLUDE "text/maps/CinnabarLab4.asm"
INCLUDE "text/maps/CinnabarPokecenter.asm"
INCLUDE "text/maps/CinnabarMart.asm"
INCLUDE "text/maps/IndigoPlateauLobby.asm"
INCLUDE "text/maps/CopycatsHouse1F.asm"
INCLUDE "text/maps/CopycatsHouse2F.asm"
INCLUDE "text/maps/FightingDojo.asm"
INCLUDE "text/maps/SaffronGym.asm"
INCLUDE "text/maps/SaffronHouse1.asm"
INCLUDE "text/maps/SaffronMart.asm"
INCLUDE "text/maps/SilphCo1F.asm"
INCLUDE "text/maps/SaffronPokecenter.asm"
INCLUDE "text/maps/SaffronHouse2.asm"

_PokemartGreetingText::
	text "Hi there!"
	next "May I help you?"
	done

_PokemonFaintedText::
	TX_RAM wcd6d
	text ""
	line "fainted!"
	done

_PlayerBlackedOutText::
	text "[PLAYER] is out of"
	line "useable #mon!"

	para "[PLAYER] blacked"
	line "out!"
	prompt

_RepelWoreOffText::
	text "Repel's effect"
	line "wore off."
	prompt

_PokemartBuyingGreetingText::
	text "Take your time."
	done

_PokemartTellBuyPriceText::
	TX_RAM wcf4b
	text "?"
	line "That will be"
	cont "¥@"
	TX_BCD hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text ". OK?"
	done

_PokemartBoughtItemText::
	text "Here you are!"
	line "Thank you!"
	prompt

_PokemartNotEnoughMoneyText::
	text "You don't have"
	line "enough money."
	prompt

_PokemartItemBagFullText::
	text "You can't carry"
	line "any more items."
	prompt

_PokemonSellingGreetingText::
	text "What would you"
	line "like to sell?"
	done

_PokemartTellSellPriceText::
	text "I can pay you"
	line "¥@"
	TX_BCD hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text " for that."
	done

_PokemartItemBagEmptyText::
	text "You don't have"
	line "anything to sell."
	prompt

_PokemartUnsellableItemText::
	text "I can't put a"
	line "price on that."
	prompt

_PokemartThankYouText::
	text "Thank you!"
	done

_PokemartAnythingElseText::
	text "Is there anything"
	line "else I can do?"
	done

_LearnedMove1Text::
	TX_RAM wLearnMoveMonName
	text " learned"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_WhichMoveToForgetText::
	text "Which move should"
	next "be forgotten?"
	done

_AbandonLearningText::
	text "Abandon learning"
	line "@"
	TX_RAM wcf4b
	text "?"
	done

_DidNotLearnText::
	TX_RAM wLearnMoveMonName
	text ""
	line "did not learn"
	cont "@"
	TX_RAM wcf4b
	text "!"
	prompt

_TryingToLearnText::
	TX_RAM wLearnMoveMonName
	text " is"
	line "trying to learn"
	cont "@"
	TX_RAM wcf4b
	text "!"

	para "But, @"
	TX_RAM wLearnMoveMonName
	text ""
	line "can't learn more"
	cont "than 4 moves!"

	para "Delete an older"
	line "move to make room"
	cont "for @"
	TX_RAM wcf4b
	text "?"
	done

_OneTwoAndText::
	text "1, 2 and...@@"

_PoofText::
	text " Poof!@@"

_ForgotAndText::
	text ""
	para "@"
	TX_RAM wLearnMoveMonName
	text " forgot"
	line "@"
	TX_RAM wcd6d
	text "!"

	para "And..."
	prompt

_HMCantDeleteText::
	text "HM techniques"
	line "can't be deleted!"
	prompt

_PokemonCenterWelcomeText::
	text "Welcome to our"
	line "#mon Center!"

	para "We heal your"
	line "#mon back to"
	cont "perfect health!"
	prompt

_ShallWeHealYourPokemonText::
	text "Shall we heal your"
	line "#mon?"
	done

_NeedYourPokemonText::
	text "OK. We'll need"
	line "your #mon."
	done

_PokemonFightingFitText::
	text "Thank you!"
	line "Your #mon are"
	cont "fighting fit!"
	prompt

_PokemonCenterFarewellText::
	text "We hope to see"
	line "you again!"
	done

_CableClubNPCAreaReservedFor2FriendsLinkedByCableText::
	text "This area is"
	line "reserved for 2"
	cont "friends who are"
	cont "linked by cable."
	done

_CableClubNPCWelcomeText::
	text "Welcome to the"
	line "Cable Club!"
	done

_CableClubNPCPleaseApplyHereHaveToSaveText::
	text "Please apply here."

	para "Before opening"
	line "the link, we have"
	cont "to save the game."
	done

_CableClubNPCPleaseWaitText::
	text "Please wait.@@"

_CableClubNPCLinkClosedBecauseOfInactivityText::
	text "The link has been"
	line "closed because of"
	cont "inactivity."

	para "Please contact"
	line "your friend and"
	cont "come again!"
	done


SECTION "Text 10", ROMX, BANK[TEXT_10]

_CableClubNPCPleaseComeAgainText::
	text "Please come again!"
	done

_CableClubNPCMakingPreparationsText::
	text "We're making"
	line "preparations."
	cont "Please wait."
	done

_UsedStrengthText::
	TX_RAM wcd6d
	text " used"
	line "Strength.@@"

_CanMoveBouldersText::
	TX_RAM wcd6d
	text " can"
	line "move boulders."
	prompt

_CurrentTooFastText::
	text "The current is"
	line "much too fast!"
	prompt

_CyclingIsFunText::
	text "Cycling is fun!"
	line "Forget Surfing!"
	prompt

_FlashLightsAreaText::
	text "A blinding Flash"
	line "lights the area!"
	prompt

_WarpToLastPokemonCenterText::
	text "Warp to the last"
	line "#mon Center."
	done

_CannotUseTeleportNowText::
	TX_RAM wcd6d
	text " can't"
	line "use Telepor now."
	prompt

_CannotFlyHereText::
	TX_RAM wcd6d
	text " can't"
	line "Fly here."
	prompt

_NotHealthyEnoughText::
	text "Not healthy"
	line "enough."
	prompt

_NewBadgeRequiredText::
	text "No! A new Badge"
	line "is required."
	prompt

_CannotUseItemsHereText::
	text "You can't use items"
	line "here."
	prompt

_CannotGetOffHereText::
	text "You can't get off"
	line "here."
	prompt

_GotMonText::
	text "[PLAYER] got"
	line "@"
	TX_RAM wcd6d
	text "!@@"

_SetToBoxText::
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

_BoxIsFullText::
	text "There's no more"
	line "room for #mon!"

	para "The #mon Box"
	line "is full and can't"
	cont "accept any more!"

	para "Change the Box at"
	line "a #mon Center!"
	done

INCLUDE "text/maps/PalletTown.asm"
INCLUDE "text/maps/ViridianCity.asm"
INCLUDE "text/maps/PewterCity.asm"
INCLUDE "text/maps/CeruleanCity.asm"
INCLUDE "text/maps/LavenderTown.asm"
INCLUDE "text/maps/VermilionCity.asm"
INCLUDE "text/maps/CeladonCity.asm"
INCLUDE "text/maps/FuchsiaCity.asm"
INCLUDE "text/maps/CinnabarIsland.asm"
INCLUDE "text/maps/SaffronCity.asm"

_ItemUseBallText00::
	text "It dodged the"
	line "thrown Ball!"

	para "This #mon"
	line "can't be caught!"
	prompt

_ItemUseBallText01::
	text "You missed the"
	line "#mon!"
	prompt

_ItemUseBallText02::
	text "Darn! The #mon"
	line "broke free!"
	prompt

_ItemUseBallText03::
	text "Aww! It appeared"
	line "to be caught! "
	prompt

_ItemUseBallText04::
	text "Shoot! It was so"
	line "close too!"
	prompt

_ItemUseBallText05::
	text "All right!"
	line "@"
	TX_RAM wEnemyMonNick
	text " was"
	cont "caught!@@"

_ItemUseBallText07::
	TX_RAM wBoxMonNicks
	text " was"
	line "transferred to"
	cont "Bill's PC!"
	prompt

_ItemUseBallText08::
	TX_RAM wBoxMonNicks
	text " was"
	line "transferred to"
	cont "someone's PC!"
	prompt

_ItemUseBallText06::
	text "New #dex data"
	line "will be added for"
	cont "@"
	TX_RAM wEnemyMonNick
	text "!@@"

_SurfingGotOnText::
	text "[PLAYER] got on"
	line "@"
	TX_RAM wcd6d
	text "!"
	prompt

_SurfingNoPlaceToGetOffText::
	text "There's no place"
	line "to get off!"
	prompt

_VitaminStatRoseText::
	TX_RAM wcd6d
	text "'s"
	line "@"
	TX_RAM wcf4b
	text " rose."
	prompt

_VitaminNoEffectText::
	text "It won't have any"
	line "effect."
	prompt

_ThrewBaitText::
	text "[PLAYER] threw"
	line "some Bait."
	done

_ThrewRockText::
	text "[PLAYER] threw a"
	line "Rock."
	done

_PlayedFluteNoEffectText::
	text "Played the #"
	line "Flute."

	para "Now, that's a"
	line "catchy tune!"
	prompt

_FluteWokeUpText::
	text "All sleeping"
	line "#mon woke up."
	prompt

_PlayedFluteHadEffectText::
	text "[PLAYER] played the"
	line "# Flute.@@"

_CoinCaseNumCoinsText::
	text "Coins"
	line "@"
	TX_BCD wPlayerCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " "
	prompt

_ItemfinderFoundItemText::
	text "Yes! Item Finder"
	line "indicates there's"
	cont "an item nearby."
	prompt

_ItemfinderFoundNothingText::
	text "Nope! Item Finder"
	line "isn't responding."
	prompt

_RaisePPWhichTechniqueText::
	text "Raise PP of which"
	line "technique?"
	done

_RestorePPWhichTechniqueText::
	text "Restore PP of"
	line "which technique?"
	done

_PPMaxedOutText::
	TX_RAM wcf4b
	text "'s PP"
	line "is maxed out."
	prompt

_PPIncreasedText::
	TX_RAM wcf4b
	text "'s PP"
	line "increased."
	prompt

_PPRestoredText::
	text "PP was restored."
	prompt

_BootedUpTMText::
	text "Booted up a TM!"
	prompt

_BootedUpHMText::
	text "Booted up an HM!"
	prompt

_TeachMachineMoveText::
	text "It contained"
	line "@"
	TX_RAM wcf4b
	text "!"

	para "Teach @"
	TX_RAM wcf4b
	text ""
	line "to a #mon?"
	done

_MonCannotLearnMachineMoveText::
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

_ItemUseNotTimeText::
	text "Oak: [PLAYER]!"
	line "This isn't the"
	cont "time to use that! "
	prompt

_ItemUseNotYoursToUseText::
	text "This isn't yours"
	line "to use!"
	prompt

_ItemUseNoEffectText::
	text "It won't have any"
	line "effect."
	prompt

_ThrowBallAtTrainerMonText1::
	text "The trainer"
	line "blocked the Ball!"
	prompt

_ThrowBallAtTrainerMonText2::
	text "Don't be a thief!"
	prompt

_NoCyclingAllowedHereText::
	text "No cycling"
	next "allowed here."
	prompt

_NoSurfingHereText::
	text "No Surfing on"
	line "@"
	TX_RAM wcd6d
	text " here!"
	prompt

_BoxFullCannotThrowBallText::
	text "The #mon Box"
	line "is full! Can't"
	cont "use that item!"
	prompt


SECTION "Text 11", ROMX, BANK[TEXT_11]

_ItemUseText001::
	text "[PLAYER] used@@"

_ItemUseText002::
	TX_RAM wcf4b
	text "!"
	done

_GotOnBicycleText1::
	text "[PLAYER] got on the@@"

_GotOnBicycleText2::
	TX_RAM wcf4b
	text "!"
	prompt

_GotOffBicycleText1::
	text "[PLAYER] got off@@"

_GotOffBicycleText2::
	text "the @"
	TX_RAM wcf4b
	text "."
	prompt

_ThrewAwayItemText::
	text "Threw away"
	line "@"
	TX_RAM wcd6d
	text "."
	prompt

_IsItOKToTossItemText::
	text "Is it OK to toss"
	line "@"
	TX_RAM wcf4b
	text "?"
	prompt

_TooImportantToTossText::
	text "That's too impor-"
	line "tant to toss!"
	prompt

_AlreadyKnowsText::
	TX_RAM wcd6d
	text " knows"
	line "@"
	TX_RAM wcf4b
	text "!"
	prompt

_ConnectCableText::
	text "Okay, connect the"
	line "cable like so!"
	prompt

_TradedForText::
	text "[PLAYER] traded"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text " for"
	cont "@"
	TX_RAM wInGameTradeReceiveMonName
	text "!@@"

_WannaTrade1Text::
	text "I'm looking for"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "! Wanna"

	para "trade one for"
	line "@"
	TX_RAM wInGameTradeReceiveMonName
	text "? "
	done

_NoTrade1Text::
	text "Awww!"
	line "Oh well..."
	done

_WrongMon1Text::
	text "What? That's not"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "!"

	para "If you get one,"
	line "come back here!"
	done

_Thanks1Text::
	text "Hey thanks!"
	done

_AfterTrade1Text::
	text "Isn't my old"
	line "@"
	TX_RAM wInGameTradeReceiveMonName
	text " great?"
	done

_WannaTrade2Text::
	text "Hello there! Do"
	line "you want to trade"

	para "your @"
	TX_RAM wInGameTradeGiveMonName
	text ""
	line "for @"
	TX_RAM wInGameTradeReceiveMonName
	text "?"
	done

_NoTrade2Text::
	text "Well, if you"
	line "don't want to..."
	done

_WrongMon2Text::
	text "Hmmm? This isn't"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "."

	para "Think of me when"
	line "you get one."
	done

_Thanks2Text::
	text "Thanks!"
	done

_AfterTrade2Text::
	text "Hello there! Your"
    line "old @"
	TX_RAM wInGameTradeGiveMonName
	text " is"
	cont "magnificent!"
	done

_WannaTrade3Text::
	text "Hi! Do you have"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "?"

	para "Want to trade it"
	line "for @"
	TX_RAM wInGameTradeReceiveMonName
	text "?"
	done

_NoTrade3Text::
	text "That's too bad."
	done

_WrongMon3Text::
	text "...This is no"
	line "@"
	TX_RAM wInGameTradeGiveMonName
	text "."

	para "If you get one,"
	line "trade it with me!"
	done

_Thanks3Text::
	text "Thanks, pal!"
	done

_AfterTrade3Text::
	text "How is my old"
	line "@"
	TX_RAM wInGameTradeReceiveMonName
	text "?"

	para "My @"
	TX_RAM wInGameTradeGiveMonName
	text " is"
	line "doing great!"
	done

_NothingToCutText::
	text "There isn't"
	line "anything to Cut!"
	prompt

_UsedCutText::
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
	text ""
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
