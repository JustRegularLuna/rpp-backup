INCLUDE "constants.asm"

NPC_SPRITES_1 EQU $4
NPC_SPRITES_2 EQU $5

GFX EQU $4

PICS_1 EQU $9
PICS_2 EQU $A
PICS_3 EQU $B
PICS_4 EQU $C
PICS_5 EQU $D

INCLUDE "home.asm"


SECTION "bank1",ROMX,BANK[$1]

INCLUDE "data/facing.asm"

INCLUDE "engine/black_out.asm"


INCLUDE "engine/battle/safari_zone.asm"

INCLUDE "engine/titlescreen.asm"
INCLUDE "engine/load_mon_data.asm"

INCLUDE "data/item_prices.asm"
INCLUDE "text/item_names.asm"
;INCLUDE "text/unused_names.asm"

INCLUDE "engine/overworld/oam.asm"
INCLUDE "engine/oam_dma.asm"

INCLUDE "engine/print_waiting_text.asm"

INCLUDE "engine/overworld/map_sprite_functions1.asm"

;INCLUDE "engine/test_battle.asm"

INCLUDE "engine/overworld/item.asm"
INCLUDE "engine/overworld/movement.asm"

INCLUDE "engine/cable_club.asm"

INCLUDE "engine/menu/main_menu.asm"

INCLUDE "engine/oak_speech.asm"

INCLUDE "engine/special_warps.asm"

INCLUDE "engine/debug1.asm"

INCLUDE "engine/menu/naming_screen.asm"

INCLUDE "engine/oak_speech2.asm"

INCLUDE "engine/subtract_paid_money.asm"

INCLUDE "engine/menu/swap_items.asm"

INCLUDE "engine/overworld/pokemart.asm"

INCLUDE "engine/learn_move.asm"

INCLUDE "engine/overworld/pokecenter.asm"

INCLUDE "engine/overworld/set_blackout_map.asm"

INCLUDE "engine/display_text_id_init.asm"
INCLUDE "engine/menu/draw_start_menu.asm"

INCLUDE "engine/overworld/cable_club_npc.asm"

INCLUDE "engine/menu/text_box.asm"

INCLUDE "engine/battle/moveEffects/drain_hp_effect.asm"

INCLUDE "engine/menu/players_pc.asm"

INCLUDE "engine/remove_pokemon.asm"

INCLUDE "engine/display_pokedex.asm"


; Hooks for color hack
INCLUDE "color/cable_club.asm"
INCLUDE "color/oak_intro.asm"
INCLUDE "color/load_hp_and_exp_bar.asm"


SECTION "bank3",ROMX,BANK[$3]

INCLUDE "engine/joypad.asm"

INCLUDE "data/map_header_banks.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCLUDE "engine/overworld/clear_variables.asm"
INCLUDE "engine/overworld/player_state.asm"
INCLUDE "engine/overworld/poison.asm"
INCLUDE "engine/overworld/tileset_header.asm"
INCLUDE "engine/overworld/daycare_exp.asm"

INCLUDE "data/hide_show_data.asm"

INCLUDE "engine/overworld/field_move_messages.asm"

INCLUDE "engine/items/inventory.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCLUDE "engine/overworld/wild_mons.asm"

INCLUDE "engine/items/items.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCLUDE "engine/menu/draw_badges.asm"

INCLUDE "engine/overworld/update_map.asm"
INCLUDE "engine/overworld/cut.asm"
INCLUDE "engine/overworld/missable_objects.asm"
INCLUDE "engine/overworld/push_boulder.asm"

INCLUDE "engine/add_mon.asm"
INCLUDE "engine/flag_action.asm"
INCLUDE "engine/heal_party.asm"
INCLUDE "engine/bcd.asm"
INCLUDE "engine/init_player_data.asm"
INCLUDE "engine/get_bag_item_quantity.asm"
INCLUDE "engine/pathfinding.asm"
INCLUDE "engine/hp_bar.asm"
INCLUDE "engine/hidden_object_functions3.asm"

INCLUDE "color/update_hp_bar.asm"

SECTION "NPC Sprites 1", ROMX, BANK[NPC_SPRITES_1]
RocketSprite:          INCBIN "gfx/sprites/rocket.2bpp"
RocketFSprite:         INCBIN "gfx/sprites/rocketf.2bpp"
OakAideSprite:         INCBIN "gfx/sprites/oak_aide.2bpp"
RockerSprite:          INCBIN "gfx/sprites/rocker.2bpp"
SwimmerSprite:         INCBIN "gfx/sprites/swimmer.2bpp"
WhitePlayerSprite:     INCBIN "gfx/sprites/white_player.2bpp"
GymHelperSprite:       INCBIN "gfx/sprites/gym_helper.2bpp"
OldPersonSprite:       INCBIN "gfx/sprites/old_person.2bpp"
MartGuySprite:         INCBIN "gfx/sprites/mart_guy.2bpp"
FisherSprite:          INCBIN "gfx/sprites/fisher.2bpp"
OldMediumWomanSprite:  INCBIN "gfx/sprites/old_medium_woman.2bpp"
NurseSprite:           INCBIN "gfx/sprites/nurse.2bpp"
CableClubWomanSprite:  INCBIN "gfx/sprites/cable_club_woman.2bpp"
MrMasterballSprite:    INCBIN "gfx/sprites/mr_masterball.2bpp"
LaprasGiverSprite:     INCBIN "gfx/sprites/lapras_giver.2bpp"
WardenSprite:          INCBIN "gfx/sprites/warden.2bpp"
SsCaptainSprite:       INCBIN "gfx/sprites/ss_captain.2bpp"
Fisher2Sprite:         INCBIN "gfx/sprites/fisher2.2bpp"
BlackbeltSprite:       INCBIN "gfx/sprites/blackbelt.2bpp"
GuardSprite:           INCBIN "gfx/sprites/guard.2bpp"
; Other sprites were moved to another bank



SECTION "Graphics", ROMX, BANK[GFX]

PokemonLogoGraphics:            INCBIN "gfx/pokemon_logo.2bpp"
FontGraphics:                   INCBIN "gfx/font.1bpp"
FontGraphicsEnd:
ABTiles:                        INCBIN "gfx/AB.2bpp"
HpBarAndStatusGraphics:  INCBIN "gfx/hp_bar_and_status.2bpp"
HpBarAndStatusGraphicsEnd:
BattleHudTiles1:         INCBIN "gfx/battle_hud1.1bpp"
BattleHudTiles1End:
BattleHudTiles2:         INCBIN "gfx/battle_hud2.1bpp"
BattleHudTiles3:         INCBIN "gfx/battle_hud3.1bpp"
BattleHudTiles3End:
NintendoCopyrightLogoGraphics:  INCBIN "gfx/copyright.2bpp"
GamefreakLogoGraphics:          INCBIN "gfx/gamefreak.2bpp"
GamefreakLogoGraphicsEnd:
TextBoxGraphics:                INCBIN "gfx/text_box.2bpp"
TextBoxGraphicsEnd:
PokedexTileGraphics:            INCBIN "gfx/pokedex.2bpp"
PokedexTileGraphicsEnd:
PlayerCharacterTitleGraphics:   INCBIN "gfx/player_title.2bpp"
PlayerCharacterTitleGraphicsEnd:


SECTION "Battle (bank 4)", ROMX, BANK[$4]

INCLUDE "engine/overworld/is_player_just_outside_map.asm"
INCLUDE "engine/menu/status_screen.asm"
INCLUDE "engine/menu/party_menu.asm"

RedPicFront::  INCBIN "pic/trainer/red.pic"
LeafPicFront:: INCBIN "pic/trainer/leaf.pic"
ShrinkPic1::   INCBIN "pic/trainer/shrink1.pic"
ShrinkPic2::   INCBIN "pic/trainer/shrink2.pic"

INCLUDE "engine/turn_sprite.asm"
INCLUDE "engine/menu/start_sub_menus.asm"
INCLUDE "engine/items/tms.asm"
INCLUDE "engine/battle/end_of_battle.asm"
INCLUDE "engine/battle/wild_encounters.asm"
INCLUDE "engine/battle/moveEffects/recoil_effect.asm"
INCLUDE "engine/battle/moveEffects/conversion_effect.asm"
INCLUDE "engine/battle/moveEffects/haze_effect.asm"
INCLUDE "engine/battle/get_trainer_name.asm"
INCLUDE "engine/random.asm"

EXPBarGraphics: INCBIN "gfx/exp_bar.2bpp"
ShinySparkleGraphics: INCBIN "gfx/shiny_sparkle.2bpp"
EXPBarShinySparkleGraphicsEnd:


SECTION "NPC Sprites 2", ROMX, BANK[NPC_SPRITES_2]

RedCyclingSprite:     INCBIN "gfx/sprites/cycling.2bpp"
RedSprite:            INCBIN "gfx/sprites/red.2bpp"
LeafSprite:           INCBIN "gfx/sprites/leaf.2bpp"
LeafCyclingSprite:    INCBIN "gfx/sprites/leafcycling.2bpp"
BlueSprite:           INCBIN "gfx/sprites/blue.2bpp"
OakSprite:            INCBIN "gfx/sprites/oak.2bpp"
BugCatcherSprite:     INCBIN "gfx/sprites/bug_catcher.2bpp"
LassSprite:           INCBIN "gfx/sprites/lass.2bpp"
BlackHairBoy1Sprite:  INCBIN "gfx/sprites/black_hair_boy_1.2bpp"
LittleGirlSprite:     INCBIN "gfx/sprites/little_girl.2bpp"
FatBaldGuySprite:     INCBIN "gfx/sprites/fat_bald_guy.2bpp"
GamblerSprite:        INCBIN "gfx/sprites/gambler.2bpp"
BlackHairBoy2Sprite:  INCBIN "gfx/sprites/black_hair_boy_2.2bpp"
GirlSprite:           INCBIN "gfx/sprites/girl.2bpp"
HikerSprite:          INCBIN "gfx/sprites/hiker.2bpp"
FoulardWomanSprite:   INCBIN "gfx/sprites/foulard_woman.2bpp"
GentlemanSprite:      INCBIN "gfx/sprites/gentleman.2bpp"
DaisySprite:          INCBIN "gfx/sprites/daisy.2bpp"
BikerSprite:          INCBIN "gfx/sprites/biker.2bpp"
SailorSprite:         INCBIN "gfx/sprites/sailor.2bpp"
CookSprite:           INCBIN "gfx/sprites/cook.2bpp"
BikeShopGuySprite:    INCBIN "gfx/sprites/bike_shop_guy.2bpp"
MrFujiSprite:         INCBIN "gfx/sprites/mr_fuji.2bpp"
MediumSprite:         INCBIN "gfx/sprites/medium.2bpp"
WaiterSprite:         INCBIN "gfx/sprites/waiter.2bpp"
MomGeishaSprite:      INCBIN "gfx/sprites/mom_geisha.2bpp"
BrunetteGirlSprite:   INCBIN "gfx/sprites/brunette_girl.2bpp"
LanceSprite:          INCBIN "gfx/sprites/lance.2bpp"
MomSprite:            INCBIN "gfx/sprites/mom.2bpp"
BaldingGuySprite:     INCBIN "gfx/sprites/balding_guy.2bpp"
YoungBoySprite:       INCBIN "gfx/sprites/young_boy.2bpp"
GameboyKidSprite:     INCBIN "gfx/sprites/gameboy_kid.2bpp"
AgathaSprite:         INCBIN "gfx/sprites/agatha.2bpp"
BrunoSprite:          INCBIN "gfx/sprites/bruno.2bpp"
LoreleiSprite:        INCBIN "gfx/sprites/lorelei.2bpp"
SurfingLapras:        INCBIN "gfx/sprites/surf_lapras.2bpp"


SECTION "Battle (bank 5)", ROMX, BANK[$5]

INCLUDE "engine/load_pokedex_tiles.asm"
INCLUDE "engine/overworld/map_sprites.asm"
INCLUDE "engine/overworld/emotion_bubbles.asm"
INCLUDE "engine/evolve_trade.asm"
INCLUDE "engine/battle/moveEffects/substitute_effect.asm"
INCLUDE "engine/menu/pc.asm"

INCLUDE "data/map_songs.asm" ; moved from bank 3


SECTION "bank6",ROMX,BANK[$6]

INCLUDE "data/mapHeaders/CeladonCity.asm"
INCLUDE "data/mapObjects/CeladonCity.asm"
CeladonCityBlocks: INCBIN "maps/CeladonCity.blk"

INCLUDE "data/mapHeaders/PalletTown.asm"
INCLUDE "data/mapObjects/PalletTown.asm"
PalletTownBlocks: INCBIN "maps/PalletTown.blk"

INCLUDE "data/mapHeaders/ViridianCity.asm"
INCLUDE "data/mapObjects/ViridianCity.asm"
ViridianCityBlocks: INCBIN "maps/ViridianCity.blk"

INCLUDE "data/mapHeaders/PewterCity.asm"
INCLUDE "data/mapObjects/PewterCity.asm"
PewterCityBlocks: INCBIN "maps/PewterCity.blk"

INCLUDE "data/mapHeaders/CeruleanCity.asm"
INCLUDE "data/mapObjects/CeruleanCity.asm"
CeruleanCityBlocks: INCBIN "maps/CeruleanCity.blk"

INCLUDE "data/mapHeaders/VermilionCity.asm"
INCLUDE "data/mapObjects/VermilionCity.asm"
VermilionCityBlocks: INCBIN "maps/VermilionCity.blk"

INCLUDE "data/mapHeaders/FuchsiaCity.asm"
INCLUDE "data/mapObjects/FuchsiaCity.asm"
FuchsiaCityBlocks: INCBIN "maps/FuchsiaCity.blk"

INCLUDE "engine/play_time.asm"

INCLUDE "scripts/PalletTown.asm"
INCLUDE "scripts/ViridianCity.asm"
INCLUDE "scripts/PewterCity.asm"
INCLUDE "scripts/CeruleanCity.asm"
INCLUDE "scripts/VermilionCity.asm"
INCLUDE "scripts/CeladonCity.asm"
INCLUDE "scripts/FuchsiaCity.asm"

INCLUDE "data/mapHeaders/BluesHouse.asm"
INCLUDE "scripts/BluesHouse.asm"
INCLUDE "data/mapObjects/BluesHouse.asm"
BluesHouseBlocks: INCBIN "maps/BluesHouse.blk"

INCLUDE "data/mapHeaders/VermilionHouse3.asm"
INCLUDE "scripts/VermilionHouse3.asm"
INCLUDE "data/mapObjects/VermilionHouse3.asm"
VermilionHouse3Blocks: INCBIN "maps/VermilionHouse3.blk"

INCLUDE "data/mapHeaders/SilphCo4F.asm"
INCLUDE "scripts/SilphCo4F.asm"
INCLUDE "data/mapObjects/SilphCo4F.asm"
SilphCo4Blocks: INCBIN "maps/SilphCo4F.blk"

INCLUDE "data/mapHeaders/SilphCo5F.asm"
INCLUDE "scripts/SilphCo5F.asm"
INCLUDE "data/mapObjects/SilphCo5F.asm"
SilphCo5Blocks: INCBIN "maps/SilphCo5F.blk"

INCLUDE "data/mapHeaders/SilphCo6F.asm"
INCLUDE "scripts/SilphCo6F.asm"
INCLUDE "data/mapObjects/SilphCo6F.asm"
SilphCo6Blocks: INCBIN "maps/SilphCo6F.blk"

INCLUDE "engine/overworld/npc_movement.asm"
INCLUDE "engine/overworld/doors.asm"
INCLUDE "engine/overworld/ledges.asm"


SECTION "bank7",ROMX,BANK[$7]

INCLUDE "data/mapHeaders/CinnabarIsland.asm"
INCLUDE "data/mapObjects/CinnabarIsland.asm"
CinnabarIslandBlocks: INCBIN "maps/CinnabarIsland.blk"

INCLUDE "data/mapHeaders/Route1.asm"
INCLUDE "data/mapObjects/Route1.asm"
Route1Blocks: INCBIN "maps/Route1.blk"

UndergroundPathEntranceRoute8Blocks: INCBIN "maps/PathEntranceRoute8.blk"

OaksLabBlocks: INCBIN "maps/OaksLab.blk"

Route16HouseBlocks:
Route2HouseBlocks:
SaffronHouse1Blocks:
SaffronHouse2Blocks:
VermilionHouse1Blocks:
NameRaterBlocks:
LavenderHouse1Blocks:
LavenderHouse2Blocks:
CeruleanHouse1Blocks:
PewterHouse1Blocks:
PewterHouse2Blocks:
ViridianHouseBlocks: INCBIN "maps/ViridianHouse.blk"

CeladonMansion5Blocks:
SchoolBlocks: INCBIN "maps/ViridianSchool.blk"

CeruleanHouseTrashedBlocks: INCBIN "maps/TrashedHouse.blk"

DiglettsCaveEntranceRoute11Blocks:
DiglettsCaveRoute2Blocks: INCBIN "maps/DiglettsCaveExit.blk"

INCLUDE "text/monster_names.asm"

INCLUDE "engine/clear_save.asm"

INCLUDE "engine/predefs7.asm"

INCLUDE "scripts/CinnabarIsland.asm"

INCLUDE "scripts/Route1.asm"

INCLUDE "data/mapHeaders/OaksLab.asm"
INCLUDE "scripts/OaksLab.asm"
INCLUDE "data/mapObjects/OaksLab.asm"

INCLUDE "data/mapHeaders/ViridianMart.asm"
INCLUDE "scripts/ViridianMart.asm"
INCLUDE "data/mapObjects/ViridianMart.asm"
INCLUDE "data/martInventories/viridian.asm"
ViridianMartBlocks: INCBIN "maps/ViridianMart.blk"

INCLUDE "data/mapHeaders/ViridianSchool.asm"
INCLUDE "scripts/ViridianSchool.asm"
INCLUDE "data/mapObjects/ViridianSchool.asm"

INCLUDE "data/mapHeaders/ViridianHouse.asm"
INCLUDE "scripts/ViridianHouse.asm"
INCLUDE "data/mapObjects/ViridianHouse.asm"

INCLUDE "data/mapHeaders/PewterHouse1.asm"
INCLUDE "scripts/PewterHouse1.asm"
INCLUDE "data/mapObjects/PewterHouse1.asm"

INCLUDE "data/mapHeaders/PewterHouse2.asm"
INCLUDE "scripts/PewterHouse2.asm"
INCLUDE "data/mapObjects/PewterHouse2.asm"

INCLUDE "data/mapHeaders/TrashedHouse.asm"
INCLUDE "scripts/TrashedHouse.asm"
INCLUDE "data/mapObjects/TrashedHouse.asm"

INCLUDE "data/mapHeaders/CeruleanHouse1.asm"
INCLUDE "scripts/CeruleanHouse1.asm"
INCLUDE "data/mapObjects/CeruleanHouse1.asm"

INCLUDE "data/mapHeaders/BikeShop.asm"
INCLUDE "scripts/BikeShop.asm"
INCLUDE "data/mapObjects/BikeShop.asm"
BikeShopBlocks: INCBIN "maps/BikeShop.blk"

INCLUDE "data/mapHeaders/LavenderHouse1.asm"
INCLUDE "scripts/LavenderHouse1.asm"
INCLUDE "data/mapObjects/LavenderHouse1.asm"

INCLUDE "data/mapHeaders/LavenderHouse2.asm"
INCLUDE "scripts/LavenderHouse2.asm"
INCLUDE "data/mapObjects/LavenderHouse2.asm"

INCLUDE "data/mapHeaders/NameRatersHouse.asm"
INCLUDE "scripts/NameRatersHouse.asm"
INCLUDE "data/mapObjects/NameRatersHouse.asm"

INCLUDE "data/mapHeaders/VermilionHouse1.asm"
INCLUDE "scripts/VermilionHouse1.asm"
INCLUDE "data/mapObjects/VermilionHouse1.asm"

INCLUDE "data/mapHeaders/VermilionDock.asm"
INCLUDE "scripts/VermilionDock.asm"
INCLUDE "data/mapObjects/VermilionDock.asm"
VermilionDockBlocks: INCBIN "maps/VermilionDock.blk"

INCLUDE "data/mapHeaders/CeladonMansion5.asm"
INCLUDE "scripts/CeladonMansion5.asm"
INCLUDE "data/mapObjects/CeladonMansion5.asm"

INCLUDE "data/mapHeaders/FuchsiaMart.asm"
INCLUDE "scripts/FuchsiaMart.asm"
INCLUDE "data/mapObjects/FuchsiaMart.asm"
INCLUDE "data/martInventories/fuchsia.asm"
FuchsiaMartBlocks: INCBIN "maps/FuchsiaMart.blk"

INCLUDE "data/mapHeaders/SaffronHouse1.asm"
INCLUDE "scripts/SaffronHouse1.asm"
INCLUDE "data/mapObjects/SaffronHouse1.asm"

INCLUDE "data/mapHeaders/SaffronHouse2.asm"
INCLUDE "scripts/SaffronHouse2.asm"
INCLUDE "data/mapObjects/SaffronHouse2.asm"

INCLUDE "data/mapHeaders/DiglettsCaveExit.asm"
INCLUDE "scripts/DiglettsCaveExit.asm"
INCLUDE "data/mapObjects/DiglettsCaveExit.asm"

INCLUDE "data/mapHeaders/Route2House.asm"
INCLUDE "scripts/Route2House.asm"
INCLUDE "data/mapObjects/Route2House.asm"

INCLUDE "data/mapHeaders/Route19Gate.asm"
INCLUDE "scripts/Route19Gate.asm"
INCLUDE "data/mapObjects/Route19Gate.asm"

INCLUDE "data/mapHeaders/Route5Gate.asm"
INCLUDE "scripts/Route5Gate.asm"
INCLUDE "data/mapObjects/Route5Gate.asm"
Route19GateBlocks:
Route5GateBlocks: INCBIN "maps/Route5Gate.blk"

INCLUDE "data/mapHeaders/Route6Gate.asm"
INCLUDE "scripts/Route6Gate.asm"
INCLUDE "data/mapObjects/Route6Gate.asm"
Route6GateBlocks: INCBIN "maps/Route6Gate.blk"

INCLUDE "data/mapHeaders/Route7Gate.asm"
INCLUDE "scripts/Route7Gate.asm"
INCLUDE "data/mapObjects/Route7Gate.asm"
Route7GateBlocks: INCBIN "maps/Route7Gate.blk"

INCLUDE "data/mapHeaders/Route8Gate.asm"
INCLUDE "scripts/Route8Gate.asm"
INCLUDE "data/mapObjects/Route8Gate.asm"
Route8GateBlocks: INCBIN "maps/Route8Gate.blk"

INCLUDE "data/mapHeaders/PathEntranceRoute8.asm"
INCLUDE "scripts/PathEntranceRoute8.asm"
INCLUDE "data/mapObjects/PathEntranceRoute8.asm"

INCLUDE "data/mapHeaders/PowerPlant.asm"
INCLUDE "scripts/PowerPlant.asm"
INCLUDE "data/mapObjects/PowerPlant.asm"
PowerPlantBlocks: INCBIN "maps/PowerPlant.blk"

INCLUDE "data/mapHeaders/DiglettsCaveRoute11.asm"
INCLUDE "scripts/DiglettsCaveRoute11.asm"
INCLUDE "data/mapObjects/DiglettsCaveRoute11.asm"

INCLUDE "data/mapHeaders/Route16House.asm"
INCLUDE "scripts/Route16House.asm"
INCLUDE "data/mapObjects/Route16House.asm"

INCLUDE "data/mapHeaders/Route22Gate.asm"
INCLUDE "scripts/Route22Gate.asm"
INCLUDE "data/mapObjects/Route22Gate.asm"
Route22GateBlocks: INCBIN "maps/Route22Gate.blk"

INCLUDE "data/mapHeaders/BillsHouse.asm"
INCLUDE "scripts/BillsHouse.asm"
INCLUDE "data/mapObjects/BillsHouse.asm"
BillsHouseBlocks: INCBIN "maps/BillsHouse.blk"

INCLUDE "engine/menu/oaks_pc.asm"

INCLUDE "engine/hidden_object_functions7.asm"


SECTION "Pics 1", ROMX, BANK[PICS_1]

BulbasaurPicFront::   INCBIN "pic/bmon/bulbasaur.pic"
BulbasaurPicBack::    INCBIN "pic/monback/bulbasaurb.pic"
IvysaurPicFront::     INCBIN "pic/bmon/ivysaur.pic"
IvysaurPicBack::      INCBIN "pic/monback/ivysaurb.pic"
VenusaurPicFront::    INCBIN "pic/bmon/venusaur.pic"
VenusaurPicBack::     INCBIN "pic/monback/venusaurb.pic"
CharmanderPicFront::  INCBIN "pic/bmon/charmander.pic"
CharmanderPicBack::   INCBIN "pic/monback/charmanderb.pic"
CharmeleonPicFront::  INCBIN "pic/bmon/charmeleon.pic"
CharmeleonPicBack::   INCBIN "pic/monback/charmeleonb.pic"
CharizardPicFront::   INCBIN "pic/bmon/charizard.pic"
CharizardPicBack::    INCBIN "pic/monback/charizardb.pic"
SquirtlePicFront::    INCBIN "pic/bmon/squirtle.pic"
SquirtlePicBack::     INCBIN "pic/monback/squirtleb.pic"
WartortlePicFront::   INCBIN "pic/bmon/wartortle.pic"
WartortlePicBack::    INCBIN "pic/monback/wartortleb.pic"
BlastoisePicFront::   INCBIN "pic/bmon/blastoise.pic"
BlastoisePicBack::    INCBIN "pic/monback/blastoiseb.pic"
CaterpiePicFront::    INCBIN "pic/bmon/caterpie.pic"
CaterpiePicBack::     INCBIN "pic/monback/caterpieb.pic"
MetapodPicFront::     INCBIN "pic/bmon/metapod.pic"
MetapodPicBack::      INCBIN "pic/monback/metapodb.pic"
ButterfreePicFront::  INCBIN "pic/bmon/butterfree.pic"
ButterfreePicBack::   INCBIN "pic/monback/butterfreeb.pic"
WeedlePicFront::      INCBIN "pic/bmon/weedle.pic"
WeedlePicBack::       INCBIN "pic/monback/weedleb.pic"
KakunaPicFront::      INCBIN "pic/bmon/kakuna.pic"
KakunaPicBack::       INCBIN "pic/monback/kakunab.pic"
BeedrillPicFront::    INCBIN "pic/bmon/beedrill.pic"
BeedrillPicBack::     INCBIN "pic/monback/beedrillb.pic"
PidgeyPicFront::      INCBIN "pic/bmon/pidgey.pic"
PidgeyPicBack::       INCBIN "pic/monback/pidgeyb.pic"
PidgeottoPicFront::   INCBIN "pic/bmon/pidgeotto.pic"
PidgeottoPicBack::    INCBIN "pic/monback/pidgeottob.pic"
PidgeotPicFront::     INCBIN "pic/bmon/pidgeot.pic"
PidgeotPicBack::      INCBIN "pic/monback/pidgeotb.pic"
RattataPicFront::     INCBIN "pic/bmon/rattata.pic"
RattataPicBack::      INCBIN "pic/monback/rattatab.pic"
RaticatePicFront::    INCBIN "pic/bmon/raticate.pic"
RaticatePicBack::     INCBIN "pic/monback/raticateb.pic"
SpearowPicFront::     INCBIN "pic/bmon/spearow.pic"
SpearowPicBack::      INCBIN "pic/monback/spearowb.pic"
FearowPicFront::      INCBIN "pic/bmon/fearow.pic"
FearowPicBack::       INCBIN "pic/monback/fearowb.pic"
EkansPicFront::       INCBIN "pic/bmon/ekans.pic"
EkansPicBack::        INCBIN "pic/monback/ekansb.pic"
ArbokPicFront::       INCBIN "pic/bmon/arbok.pic"
ArbokPicBack::        INCBIN "pic/monback/arbokb.pic"
PikachuPicFront::     INCBIN "pic/bmon/pikachu.pic"
PikachuPicBack::      INCBIN "pic/monback/pikachub.pic"



SECTION "Battle (bank 9)", ROMX[$7d6b], BANK[$9]
INCLUDE "engine/battle/print_type.asm"
INCLUDE "engine/battle/moveEffects/focus_energy_effect.asm"


SECTION "Pics 2", ROMX, BANK[PICS_2]

RaichuPicFront::      INCBIN "pic/bmon/raichu.pic"
RaichuPicBack::       INCBIN "pic/monback/raichub.pic"
SandshrewPicFront::   INCBIN "pic/bmon/sandshrew.pic"
SandshrewPicBack::    INCBIN "pic/monback/sandshrewb.pic"
SandslashPicFront::   INCBIN "pic/bmon/sandslash.pic"
SandslashPicBack::    INCBIN "pic/monback/sandslashb.pic"
NidoranFPicFront::    INCBIN "pic/bmon/nidoranf.pic"
NidoranFPicBack::     INCBIN "pic/monback/nidoranfb.pic"
NidorinaPicFront::    INCBIN "pic/bmon/nidorina.pic"
NidorinaPicBack::     INCBIN "pic/monback/nidorinab.pic"
NidoqueenPicFront::   INCBIN "pic/bmon/nidoqueen.pic"
NidoqueenPicBack::    INCBIN "pic/monback/nidoqueenb.pic"
NidoranMPicFront::    INCBIN "pic/bmon/nidoranm.pic"
NidoranMPicBack::     INCBIN "pic/monback/nidoranmb.pic"
NidorinoPicFront::    INCBIN "pic/bmon/nidorino.pic"
NidorinoPicBack::     INCBIN "pic/monback/nidorinob.pic"
NidokingPicFront::    INCBIN "pic/bmon/nidoking.pic"
NidokingPicBack::     INCBIN "pic/monback/nidokingb.pic"
ClefairyPicFront::    INCBIN "pic/bmon/clefairy.pic"
ClefairyPicBack::     INCBIN "pic/monback/clefairyb.pic"
ClefablePicFront::    INCBIN "pic/bmon/clefable.pic"
ClefablePicBack::     INCBIN "pic/monback/clefableb.pic"
VulpixPicFront::      INCBIN "pic/bmon/vulpix.pic"
VulpixPicBack::       INCBIN "pic/monback/vulpixb.pic"
NinetalesPicFront::   INCBIN "pic/bmon/ninetales.pic"
NinetalesPicBack::    INCBIN "pic/monback/ninetalesb.pic"
JigglypuffPicFront::  INCBIN "pic/bmon/jigglypuff.pic"
JigglypuffPicBack::   INCBIN "pic/monback/jigglypuffb.pic"
WigglytuffPicFront::  INCBIN "pic/bmon/wigglytuff.pic"
WigglytuffPicBack::   INCBIN "pic/monback/wigglytuffb.pic"
ZubatPicFront::       INCBIN "pic/bmon/zubat.pic"
ZubatPicBack::        INCBIN "pic/monback/zubatb.pic"
GolbatPicFront::      INCBIN "pic/bmon/golbat.pic"
GolbatPicBack::       INCBIN "pic/monback/golbatb.pic"
OddishPicFront::      INCBIN "pic/bmon/oddish.pic"
OddishPicBack::       INCBIN "pic/monback/oddishb.pic"
GloomPicFront::       INCBIN "pic/bmon/gloom.pic"
GloomPicBack::        INCBIN "pic/monback/gloomb.pic"
VileplumePicFront::   INCBIN "pic/bmon/vileplume.pic"
VileplumePicBack::    INCBIN "pic/monback/vileplumeb.pic"
ParasPicFront::       INCBIN "pic/bmon/paras.pic"
ParasPicBack::        INCBIN "pic/monback/parasb.pic"
ParasectPicFront::    INCBIN "pic/bmon/parasect.pic"
ParasectPicBack::     INCBIN "pic/monback/parasectb.pic"
VenonatPicFront::     INCBIN "pic/bmon/venonat.pic"
VenonatPicBack::      INCBIN "pic/monback/venonatb.pic"
VenomothPicFront::    INCBIN "pic/bmon/venomoth.pic"
VenomothPicBack::     INCBIN "pic/monback/venomothb.pic"
DiglettPicFront::     INCBIN "pic/bmon/diglett.pic"
DiglettPicBack::      INCBIN "pic/monback/diglettb.pic"



SECTION "Battle (bank A)", ROMX[$7ea9], BANK[$A]
INCLUDE "engine/battle/moveEffects/leech_seed_effect.asm"


SECTION "Pics 3", ROMX, BANK[PICS_3]

DugtrioPicFront::     INCBIN "pic/bmon/dugtrio.pic"
DugtrioPicBack::      INCBIN "pic/monback/dugtriob.pic"
MeowthPicFront::      INCBIN "pic/bmon/meowth.pic"
MeowthPicBack::       INCBIN "pic/monback/meowthb.pic"
PersianPicFront::     INCBIN "pic/bmon/persian.pic"
PersianPicBack::      INCBIN "pic/monback/persianb.pic"
PsyduckPicFront::     INCBIN "pic/bmon/psyduck.pic"
PsyduckPicBack::      INCBIN "pic/monback/psyduckb.pic"
GolduckPicFront::     INCBIN "pic/bmon/golduck.pic"
GolduckPicBack::      INCBIN "pic/monback/golduckb.pic"
MankeyPicFront::      INCBIN "pic/bmon/mankey.pic"
MankeyPicBack::       INCBIN "pic/monback/mankeyb.pic"
PrimeapePicFront::    INCBIN "pic/bmon/primeape.pic"
PrimeapePicBack::     INCBIN "pic/monback/primeapeb.pic"
GrowlithePicFront::   INCBIN "pic/bmon/growlithe.pic"
GrowlithePicBack::    INCBIN "pic/monback/growlitheb.pic"
ArcaninePicFront::    INCBIN "pic/bmon/arcanine.pic"
ArcaninePicBack::     INCBIN "pic/monback/arcanineb.pic"
PoliwagPicFront::     INCBIN "pic/bmon/poliwag.pic"
PoliwagPicBack::      INCBIN "pic/monback/poliwagb.pic"
PoliwhirlPicFront::   INCBIN "pic/bmon/poliwhirl.pic"
PoliwhirlPicBack::    INCBIN "pic/monback/poliwhirlb.pic"
PoliwrathPicFront::   INCBIN "pic/bmon/poliwrath.pic"
PoliwrathPicBack::    INCBIN "pic/monback/poliwrathb.pic"
AbraPicFront::        INCBIN "pic/bmon/abra.pic"
AbraPicBack::         INCBIN "pic/monback/abrab.pic"
KadabraPicFront::     INCBIN "pic/bmon/kadabra.pic"
KadabraPicBack::      INCBIN "pic/monback/kadabrab.pic"
AlakazamPicFront::    INCBIN "pic/bmon/alakazam.pic"
AlakazamPicBack::     INCBIN "pic/monback/alakazamb.pic"
MachopPicFront::      INCBIN "pic/bmon/machop.pic"
MachopPicBack::       INCBIN "pic/monback/machopb.pic"
MachokePicFront::     INCBIN "pic/bmon/machoke.pic"
MachokePicBack::      INCBIN "pic/monback/machokeb.pic"
MachampPicFront::     INCBIN "pic/bmon/machamp.pic"
MachampPicBack::      INCBIN "pic/monback/machampb.pic"
BellsproutPicFront::  INCBIN "pic/bmon/bellsprout.pic"
BellsproutPicBack::   INCBIN "pic/monback/bellsproutb.pic"
WeepinbellPicFront::  INCBIN "pic/bmon/weepinbell.pic"
WeepinbellPicBack::   INCBIN "pic/monback/weepinbellb.pic"
VictreebelPicFront::  INCBIN "pic/bmon/victreebel.pic"
VictreebelPicBack::   INCBIN "pic/monback/victreebelb.pic"
TentacoolPicFront::   INCBIN "pic/bmon/tentacool.pic"
TentacoolPicBack::    INCBIN "pic/monback/tentacoolb.pic"
TentacruelPicFront::  INCBIN "pic/bmon/tentacruel.pic"
TentacruelPicBack::   INCBIN "pic/monback/tentacruelb.pic"



SECTION "Battle (bank B)", ROMX, BANK[$B]

INCLUDE "engine/battle/display_effectiveness.asm"

TrainerInfoTextBoxTileGraphics:  INCBIN "gfx/trainer_info.2bpp"
TrainerInfoTextBoxTileGraphicsEnd:
BlankLeaderNames:                INCBIN "gfx/blank_leader_names.2bpp"
CircleTile:                      INCBIN "gfx/circle_tile.2bpp"
BadgeNumbersTileGraphics:        INCBIN "gfx/badge_numbers.2bpp"

INCLUDE "engine/items/tmhm.asm"
INCLUDE "engine/battle/scale_sprites.asm"
INCLUDE "engine/battle/moveEffects/pay_day_effect.asm"
INCLUDE "engine/game_corner_slots2.asm"


SECTION "Pics 4", ROMX, BANK[PICS_4]

GeodudePicFront::     INCBIN "pic/bmon/geodude.pic"
GeodudePicBack::      INCBIN "pic/monback/geodudeb.pic"
GravelerPicFront::   INCBIN "pic/bmon/graveler.pic"
GravelerPicBack::    INCBIN "pic/monback/gravelerb.pic"
GolemPicFront::      INCBIN "pic/bmon/golem.pic"
GolemPicBack::       INCBIN "pic/monback/golemb.pic"
PonytaPicFront::     INCBIN "pic/bmon/ponyta.pic"
PonytaPicBack::      INCBIN "pic/monback/ponytab.pic"
RapidashPicFront::   INCBIN "pic/bmon/rapidash.pic"
RapidashPicBack::    INCBIN "pic/monback/rapidashb.pic"
SlowpokePicFront::   INCBIN "pic/bmon/slowpoke.pic"
SlowpokePicBack::    INCBIN "pic/monback/slowpokeb.pic"
SlowbroPicFront::    INCBIN "pic/bmon/slowbro.pic"
SlowbroPicBack::     INCBIN "pic/monback/slowbrob.pic"
MagnemitePicFront::  INCBIN "pic/bmon/magnemite.pic"
MagnemitePicBack::   INCBIN "pic/monback/magnemiteb.pic"
MagnetonPicFront::   INCBIN "pic/bmon/magneton.pic"
MagnetonPicBack::    INCBIN "pic/monback/magnetonb.pic"
FarfetchdPicFront::  INCBIN "pic/bmon/farfetchd.pic"
FarfetchdPicBack::   INCBIN "pic/monback/farfetchdb.pic"
DoduoPicFront::      INCBIN "pic/bmon/doduo.pic"
DoduoPicBack::       INCBIN "pic/monback/doduob.pic"
DodrioPicFront::     INCBIN "pic/bmon/dodrio.pic"
DodrioPicBack::      INCBIN "pic/monback/dodriob.pic"
SeelPicFront::       INCBIN "pic/bmon/seel.pic"
SeelPicBack::        INCBIN "pic/monback/seelb.pic"
DewgongPicFront::    INCBIN "pic/bmon/dewgong.pic"
DewgongPicBack::     INCBIN "pic/monback/dewgongb.pic"
GrimerPicFront::     INCBIN "pic/bmon/grimer.pic"
GrimerPicBack::      INCBIN "pic/monback/grimerb.pic"
MukPicFront::        INCBIN "pic/bmon/muk.pic"
MukPicBack::         INCBIN "pic/monback/mukb.pic"
ShellderPicFront::   INCBIN "pic/bmon/shellder.pic"
ShellderPicBack::    INCBIN "pic/monback/shellderb.pic"
CloysterPicFront::   INCBIN "pic/bmon/cloyster.pic"
CloysterPicBack::    INCBIN "pic/monback/cloysterb.pic"
GastlyPicFront::     INCBIN "pic/bmon/gastly.pic"
GastlyPicBack::      INCBIN "pic/monback/gastlyb.pic"
HaunterPicFront::    INCBIN "pic/bmon/haunter.pic"
HaunterPicBack::     INCBIN "pic/monback/haunterb.pic"
GengarPicFront::     INCBIN "pic/bmon/gengar.pic"
GengarPicBack::      INCBIN "pic/monback/gengarb.pic"
OnixPicFront::       INCBIN "pic/bmon/onix.pic"
OnixPicBack::        INCBIN "pic/monback/onixb.pic"
DrowzeePicFront::    INCBIN "pic/bmon/drowzee.pic"
DrowzeePicBack::     INCBIN "pic/monback/drowzeeb.pic"
HypnoPicFront::      INCBIN "pic/bmon/hypno.pic"
HypnoPicBack::       INCBIN "pic/monback/hypnob.pic"



SECTION "Battle (bank C)", ROMX[$7f2b], BANK[$C]
INCLUDE "engine/battle/moveEffects/mist_effect.asm"
INCLUDE "engine/battle/moveEffects/one_hit_ko_effect.asm"


SECTION "Pics 5", ROMX, BANK[PICS_5]

KrabbyPicFront::     INCBIN "pic/bmon/krabby.pic"
KrabbyPicBack::      INCBIN "pic/monback/krabbyb.pic"
KinglerPicFront::      INCBIN "pic/bmon/kingler.pic"
KinglerPicBack::       INCBIN "pic/monback/kinglerb.pic"
VoltorbPicFront::      INCBIN "pic/bmon/voltorb.pic"
VoltorbPicBack::       INCBIN "pic/monback/voltorbb.pic"
ElectrodePicFront::    INCBIN "pic/bmon/electrode.pic"
ElectrodePicBack::     INCBIN "pic/monback/electrodeb.pic"
ExeggcutePicFront::    INCBIN "pic/bmon/exeggcute.pic"
ExeggcutePicBack::     INCBIN "pic/monback/exeggcuteb.pic"
ExeggutorPicFront::    INCBIN "pic/bmon/exeggutor.pic"
ExeggutorPicBack::     INCBIN "pic/monback/exeggutorb.pic"
CubonePicFront::       INCBIN "pic/bmon/cubone.pic"
CubonePicBack::        INCBIN "pic/monback/cuboneb.pic"
MarowakPicFront::      INCBIN "pic/bmon/marowak.pic"
MarowakPicBack::       INCBIN "pic/monback/marowakb.pic"
HitmonleePicFront::    INCBIN "pic/bmon/hitmonlee.pic"
HitmonleePicBack::     INCBIN "pic/monback/hitmonleeb.pic"
HitmonchanPicFront::   INCBIN "pic/bmon/hitmonchan.pic"
HitmonchanPicBack::    INCBIN "pic/monback/hitmonchanb.pic"
LickitungPicFront::    INCBIN "pic/bmon/lickitung.pic"
LickitungPicBack::     INCBIN "pic/monback/lickitungb.pic"
KoffingPicFront::      INCBIN "pic/bmon/koffing.pic"
KoffingPicBack::       INCBIN "pic/monback/koffingb.pic"
WeezingPicFront::      INCBIN "pic/bmon/weezing.pic"
WeezingPicBack::       INCBIN "pic/monback/weezingb.pic"
RhyhornPicFront::      INCBIN "pic/bmon/rhyhorn.pic"
RhyhornPicBack::       INCBIN "pic/monback/rhyhornb.pic"
RhydonPicFront::       INCBIN "pic/bmon/rhydon.pic"
RhydonPicBack::        INCBIN "pic/monback/rhydonb.pic"
ChanseyPicFront::      INCBIN "pic/bmon/chansey.pic"
ChanseyPicBack::       INCBIN "pic/monback/chanseyb.pic"
TangelaPicFront::      INCBIN "pic/bmon/tangela.pic"
TangelaPicBack::       INCBIN "pic/monback/tangelab.pic"
KangaskhanPicFront::   INCBIN "pic/bmon/kangaskhan.pic"
KangaskhanPicBack::    INCBIN "pic/monback/kangaskhanb.pic"
FossilKabutopsPic::    INCBIN "pic/bmon/fossilkabutops.pic"
FossilAerodactylPic::  INCBIN "pic/bmon/fossilaerodactyl.pic"
GhostPic::             INCBIN "pic/other/ghost.pic"


SECTION "Battle (bank D)", ROMX, BANK[$D]

INCLUDE "engine/titlescreen2.asm"
INCLUDE "engine/battle/link_battle_versus_text.asm"
INCLUDE "engine/slot_machine.asm"
INCLUDE "engine/overworld/pewter_guys.asm"
INCLUDE "engine/multiply_divide.asm"
INCLUDE "engine/game_corner_slots.asm"


SECTION "bankE",ROMX,BANK[$E]

INCLUDE "engine/battle/unused_stats_functions.asm"
INCLUDE "engine/battle/scroll_draw_trainer_pic.asm"
INCLUDE "engine/battle/trainer_ai.asm"
INCLUDE "engine/battle/trainer_pic_money_pointers.asm"
INCLUDE "text/trainer_names.asm"
INCLUDE "engine/battle/bank_e_misc.asm"
INCLUDE "engine/battle/draw_hud_pokeball_gfx.asm"
INCLUDE "engine/battle/moveEffects/rage_effect.asm"
INCLUDE "engine/battle/moveEffects/heal_effect.asm"
INCLUDE "engine/battle/moveEffects/transform_effect.asm"
INCLUDE "engine/battle/moveEffects/reflect_light_screen_effect.asm"
INCLUDE "color/draw_hud_pokeball_gfx.asm"

INCLUDE "engine/evos_moves.asm"


SECTION "bankF",ROMX,BANK[$F]

INCLUDE "engine/battle/core.asm"

	
SECTION "bank10",ROMX,BANK[$10]

INCLUDE "engine/menu/pokedex.asm"
INCLUDE "engine/trade.asm"
INCLUDE "engine/intro.asm"
INCLUDE "engine/trade2.asm"
INCLUDE "engine/battle/ai_read_move.asm"
INCLUDE "data/moves.asm"
INCLUDE "data/cries.asm"
INCLUDE "engine/overworld/berrytree.asm"

; Hooks for color hack
INCLUDE "color/trade.asm"

SECTION "bank11",ROMX,BANK[$11]

INCLUDE "data/mapHeaders/LavenderTown.asm"
INCLUDE "data/mapObjects/LavenderTown.asm"
LavenderTownBlocks: INCBIN "maps/LavenderTown.blk"

SafariZoneRestHouse1Blocks:
SafariZoneRestHouse2Blocks:
SafariZoneRestHouse3Blocks:
SafariZoneRestHouse4Blocks: INCBIN "maps/SafariZoneRestHouse1.blk"

INCLUDE "scripts/LavenderTown.asm"

INCLUDE "engine/pokedex_rating.asm"

INCLUDE "data/mapHeaders/Mansion1.asm"
INCLUDE "scripts/Mansion1.asm"
INCLUDE "data/mapObjects/Mansion1.asm"
Mansion1Blocks: INCBIN "maps/Mansion1.blk"

INCLUDE "data/mapHeaders/RockTunnel1.asm"
INCLUDE "scripts/RockTunnel1.asm"
INCLUDE "data/mapObjects/RockTunnel1.asm"
RockTunnel1Blocks: INCBIN "maps/RockTunnel1.blk"

INCLUDE "data/mapHeaders/SeafoamIslands1.asm"
INCLUDE "scripts/SeafoamIslands1.asm"
INCLUDE "data/mapObjects/SeafoamIslands1.asm"
SeafoamIslands1Blocks: INCBIN "maps/SeafoamIslands1.blk"

INCLUDE "data/mapHeaders/SsAnne3.asm"
INCLUDE "scripts/SsAnne3.asm"
INCLUDE "data/mapObjects/SsAnne3.asm"
SSAnne3Blocks: INCBIN "maps/SsAnne3.blk"

INCLUDE "data/mapHeaders/VictoryRoad3.asm"
INCLUDE "scripts/VictoryRoad3.asm"
INCLUDE "data/mapObjects/VictoryRoad3.asm"
VictoryRoad3Blocks: INCBIN "maps/VictoryRoad3.blk"

INCLUDE "data/mapHeaders/RocketHideout1.asm"
INCLUDE "scripts/RocketHideout1.asm"
INCLUDE "data/mapObjects/RocketHideout1.asm"
RocketHideout1Blocks: INCBIN "maps/RocketHideout1.blk"

INCLUDE "data/mapHeaders/RocketHideout2.asm"
INCLUDE "scripts/RocketHideout2.asm"
INCLUDE "data/mapObjects/RocketHideout2.asm"
RocketHideout2Blocks: INCBIN "maps/RocketHideout2.blk"

INCLUDE "data/mapHeaders/RocketHideout3.asm"
INCLUDE "scripts/RocketHideout3.asm"
INCLUDE "data/mapObjects/RocketHideout3.asm"
RocketHideout3Blocks: INCBIN "maps/RocketHideout3.blk"

INCLUDE "data/mapHeaders/RocketHideout4.asm"
INCLUDE "scripts/RocketHideout4.asm"
INCLUDE "data/mapObjects/RocketHideout4.asm"
RocketHideout4Blocks: INCBIN "maps/RocketHideout4.blk"

INCLUDE "data/mapHeaders/RocketHideoutElevator.asm"
INCLUDE "scripts/RocketHideoutElevator.asm"
INCLUDE "data/mapObjects/RocketHideoutElevator.asm"
RocketHideoutElevatorBlocks: INCBIN "maps/RocketHideoutElevator.blk"

INCLUDE "data/mapHeaders/SilphCoElevator.asm"
INCLUDE "scripts/SilphCoElevator.asm"
INCLUDE "data/mapObjects/SilphCoElevator.asm"
SilphCoElevatorBlocks: INCBIN "maps/SilphCoElevator.blk"

INCLUDE "data/mapHeaders/SafariZoneEast.asm"
INCLUDE "scripts/SafariZoneEast.asm"
INCLUDE "data/mapObjects/SafariZoneEast.asm"
SafariZoneEastBlocks: INCBIN "maps/SafariZoneEast.blk"

INCLUDE "data/mapHeaders/SafariZoneNorth.asm"
INCLUDE "scripts/SafariZoneNorth.asm"
INCLUDE "data/mapObjects/SafariZoneNorth.asm"
SafariZoneNorthBlocks: INCBIN "maps/SafariZoneNorth.blk"

INCLUDE "data/mapHeaders/SafariZoneCenter.asm"
INCLUDE "scripts/SafariZoneCenter.asm"
INCLUDE "data/mapObjects/SafariZoneCenter.asm"
SafariZoneCenterBlocks: INCBIN "maps/SafariZoneCenter.blk"

INCLUDE "data/mapHeaders/SafariZoneRestHouse1.asm"
INCLUDE "scripts/SafariZoneRestHouse1.asm"
INCLUDE "data/mapObjects/SafariZoneRestHouse1.asm"

INCLUDE "data/mapHeaders/SafariZoneRestHouse2.asm"
INCLUDE "scripts/SafariZoneRestHouse2.asm"
INCLUDE "data/mapObjects/SafariZoneRestHouse2.asm"

INCLUDE "data/mapHeaders/SafariZoneRestHouse3.asm"
INCLUDE "scripts/SafariZoneRestHouse3.asm"
INCLUDE "data/mapObjects/SafariZoneRestHouse3.asm"

INCLUDE "data/mapHeaders/SafariZoneRestHouse4.asm"
INCLUDE "scripts/SafariZoneRestHouse4.asm"
INCLUDE "data/mapObjects/SafariZoneRestHouse4.asm"

INCLUDE "data/mapHeaders/UnknownDungeon2.asm"
INCLUDE "scripts/UnknownDungeon2.asm"
INCLUDE "data/mapObjects/UnknownDungeon2.asm"
UnknownDungeon2Blocks: INCBIN "maps/UnknownDungeon2.blk"

INCLUDE "data/mapHeaders/UnknownDungeon3.asm"
INCLUDE "scripts/UnknownDungeon3.asm"
INCLUDE "data/mapObjects/UnknownDungeon3.asm"
UnknownDungeon3Blocks: INCBIN "maps/UnknownDungeon3.blk"

INCLUDE "data/mapHeaders/RockTunnel2.asm"
INCLUDE "scripts/RockTunnel2.asm"
INCLUDE "data/mapObjects/RockTunnel2.asm"
RockTunnel2Blocks: INCBIN "maps/RockTunnel2.blk"

INCLUDE "data/mapHeaders/SeafoamIslands2.asm"
INCLUDE "scripts/SeafoamIslands2.asm"
INCLUDE "data/mapObjects/SeafoamIslands2.asm"
SeafoamIslands2Blocks: INCBIN "maps/SeafoamIslands2.blk"

INCLUDE "data/mapHeaders/SeafoamIslands3.asm"
INCLUDE "scripts/SeafoamIslands3.asm"
INCLUDE "data/mapObjects/SeafoamIslands3.asm"
SeafoamIslands3Blocks: INCBIN "maps/SeafoamIslands3.blk"

INCLUDE "data/mapHeaders/SeafoamIslands4.asm"
INCLUDE "scripts/SeafoamIslands4.asm"
INCLUDE "data/mapObjects/SeafoamIslands4.asm"
SeafoamIslands4Blocks: INCBIN "maps/SeafoamIslands4.blk"

INCLUDE "data/mapHeaders/SeafoamIslands5.asm"
INCLUDE "scripts/SeafoamIslands5.asm"
INCLUDE "data/mapObjects/SeafoamIslands5.asm"
SeafoamIslands5Blocks: INCBIN "maps/SeafoamIslands5.blk"

INCLUDE "engine/overworld/hidden_objects.asm"


SECTION "bank12",ROMX,BANK[$12]

INCLUDE "data/mapHeaders/Route7.asm"
INCLUDE "data/mapObjects/Route7.asm"
Route7Blocks: INCBIN "maps/Route7.blk"

Route18GateBlocks:
Route15GateBlocks:
Route11GateBlocks: INCBIN "maps/Route11Gate1F.blk"

Route18GateUpstairsBlocks:
Route16GateUpstairsBlocks:
Route12GateUpstairsBlocks:
Route15GateUpstairsBlocks:
Route11GateUpstairsBlocks: INCBIN "maps/Route11Gate2F.blk"

INCLUDE "engine/predefs12.asm"

INCLUDE "scripts/Route7.asm"

INCLUDE "data/mapHeaders/RedsHouse1F.asm"
INCLUDE "scripts/RedsHouse1F.asm"
INCLUDE "data/mapObjects/RedsHouse1F.asm"
RedsHouse1FBlocks: INCBIN "maps/RedsHouse1F.blk"

INCLUDE "data/mapHeaders/CeladonMart3.asm"
INCLUDE "scripts/CeladonMart3.asm"
INCLUDE "data/mapObjects/CeladonMart3.asm"
CeladonMart3Blocks: INCBIN "maps/CeladonMart3.blk"

INCLUDE "data/mapHeaders/CeladonMart4.asm"
INCLUDE "scripts/CeladonMart4.asm"
INCLUDE "data/mapObjects/CeladonMart4.asm"
INCLUDE "data/martInventories/celadon_4.asm"
CeladonMart4Blocks: INCBIN "maps/CeladonMart4.blk"

INCLUDE "data/mapHeaders/CeladonMartRoof.asm"
INCLUDE "scripts/CeladonMartRoof.asm"
INCLUDE "data/mapObjects/CeladonMartRoof.asm"
CeladonMartRoofBlocks: INCBIN "maps/CeladonMartRoof.blk"

INCLUDE "data/mapHeaders/CeladonMartElevator.asm"
INCLUDE "scripts/CeladonMartElevator.asm"
INCLUDE "data/mapObjects/CeladonMartElevator.asm"
CeladonMartElevatorBlocks: INCBIN "maps/CeladonMartElevator.blk"

INCLUDE "data/mapHeaders/CeladonMansion1.asm"
INCLUDE "scripts/CeladonMansion1.asm"
INCLUDE "data/mapObjects/CeladonMansion1.asm"
CeladonMansion1Blocks: INCBIN "maps/CeladonMansion1.blk"

INCLUDE "data/mapHeaders/CeladonMansion2.asm"
INCLUDE "scripts/CeladonMansion2.asm"
INCLUDE "data/mapObjects/CeladonMansion2.asm"
CeladonMansion2Blocks: INCBIN "maps/CeladonMansion2.blk"

INCLUDE "data/mapHeaders/CeladonMansion3.asm"
INCLUDE "scripts/CeladonMansion3.asm"
INCLUDE "data/mapObjects/CeladonMansion3.asm"
CeladonMansion3Blocks: INCBIN "maps/CeladonMansion3.blk"

INCLUDE "data/mapHeaders/CeladonMansion4.asm"
INCLUDE "scripts/CeladonMansion4.asm"
INCLUDE "data/mapObjects/CeladonMansion4.asm"
CeladonMansion4Blocks: INCBIN "maps/CeladonMansion4.blk"

INCLUDE "data/mapHeaders/CeladonGym.asm"
INCLUDE "scripts/CeladonGym.asm"
INCLUDE "data/mapObjects/CeladonGym.asm"
CeladonGymBlocks: INCBIN "maps/CeladonGym.blk"

INCLUDE "data/mapHeaders/GameCorner.asm"
INCLUDE "scripts/GameCorner.asm"
INCLUDE "data/mapObjects/GameCorner.asm"
CeladonGameCornerBlocks: INCBIN "maps/GameCorner.blk"

INCLUDE "data/mapHeaders/CeladonMart5.asm"
INCLUDE "scripts/CeladonMart5.asm"
INCLUDE "data/mapObjects/CeladonMart5.asm"
INCLUDE "data/martInventories/celadon_5.asm"
CeladonMart5Blocks: INCBIN "maps/CeladonMart5.blk"

INCLUDE "data/mapHeaders/CeladonPrizeRoom.asm"
INCLUDE "scripts/CeladonPrizeRoom.asm"
INCLUDE "data/mapObjects/CeladonPrizeRoom.asm"
CeladonPrizeRoomBlocks: INCBIN "maps/CeladonPrizeRoom.blk"

INCLUDE "data/mapHeaders/CeladonDiner.asm"
INCLUDE "scripts/CeladonDiner.asm"
INCLUDE "data/mapObjects/CeladonDiner.asm"
CeladonDinerBlocks: INCBIN "maps/CeladonDiner.blk"

INCLUDE "data/mapHeaders/CeladonHouse.asm"
INCLUDE "scripts/CeladonHouse.asm"
INCLUDE "data/mapObjects/CeladonHouse.asm"
CeladonHouseBlocks: INCBIN "maps/CeladonHouse.blk"

INCLUDE "data/mapHeaders/CeladonHotel.asm"
INCLUDE "scripts/CeladonHotel.asm"
INCLUDE "data/mapObjects/CeladonHotel.asm"
CeladonHotelBlocks: INCBIN "maps/CeladonHotel.blk"

INCLUDE "data/mapHeaders/Route11Gate1F.asm"
INCLUDE "scripts/Route11Gate1F.asm"
INCLUDE "data/mapObjects/Route11Gate1F.asm"

INCLUDE "data/mapHeaders/Route11Gate2F.asm"
INCLUDE "scripts/Route11Gate2F.asm"
INCLUDE "data/mapObjects/Route11Gate2F.asm"

INCLUDE "data/mapHeaders/Route12Gate1F.asm"
INCLUDE "scripts/Route12Gate1F.asm"
INCLUDE "data/mapObjects/Route12Gate1F.asm"
Route12GateBlocks: INCBIN "maps/Route12Gate1F.blk"

INCLUDE "data/mapHeaders/Route12Gate2F.asm"
INCLUDE "scripts/Route12Gate2F.asm"
INCLUDE "data/mapObjects/Route12Gate2F.asm"

INCLUDE "data/mapHeaders/Route15Gate1F.asm"
INCLUDE "scripts/Route15Gate1F.asm"
INCLUDE "data/mapObjects/Route15Gate1F.asm"

INCLUDE "data/mapHeaders/Route15Gate2F.asm"
INCLUDE "scripts/Route15Gate2F.asm"
INCLUDE "data/mapObjects/Route15Gate2F.asm"

INCLUDE "data/mapHeaders/Route16Gate1F.asm"
INCLUDE "scripts/Route16Gate1F.asm"
INCLUDE "data/mapObjects/Route16Gate1F.asm"
Route16GateBlocks: INCBIN "maps/Route16Gate1F.blk"

INCLUDE "data/mapHeaders/Route16Gate2F.asm"
INCLUDE "scripts/Route16Gate2F.asm"
INCLUDE "data/mapObjects/Route16Gate2F.asm"

INCLUDE "data/mapHeaders/Route18Gate1F.asm"
INCLUDE "scripts/Route18Gate1F.asm"
INCLUDE "data/mapObjects/Route18Gate1F.asm"

INCLUDE "data/mapHeaders/Route18Gate2F.asm"
INCLUDE "scripts/Route18Gate2F.asm"
INCLUDE "data/mapObjects/Route18Gate2F.asm"

INCLUDE "data/mapHeaders/MtMoon1.asm"
INCLUDE "scripts/MtMoon1.asm"
INCLUDE "data/mapObjects/MtMoon1.asm"
MtMoon1Blocks: INCBIN "maps/MtMoon1.blk"

INCLUDE "data/mapHeaders/MtMoon3.asm"
INCLUDE "scripts/MtMoon3.asm"
INCLUDE "data/mapObjects/MtMoon3.asm"
MtMoon3Blocks: INCBIN "maps/MtMoon3.blk"

INCLUDE "data/mapHeaders/SafariZoneWest.asm"
INCLUDE "scripts/SafariZoneWest.asm"
INCLUDE "data/mapObjects/SafariZoneWest.asm"
SafariZoneWestBlocks: INCBIN "maps/SafariZoneWest.blk"

INCLUDE "data/mapHeaders/SafariZoneSecretHouse.asm"
INCLUDE "scripts/SafariZoneSecretHouse.asm"
INCLUDE "data/mapObjects/SafariZoneSecretHouse.asm"
SafariZoneSecretHouseBlocks: INCBIN "maps/SafariZoneSecretHouse.blk"


SECTION "bank13",ROMX,BANK[$13]

TrainerPics::
YoungsterPic::     INCBIN "pic/trainer/youngster.pic"
BugCatcherPic::    INCBIN "pic/trainer/bugcatcher.pic"
LassPic::          INCBIN "pic/trainer/lass.pic"
SailorPic::        INCBIN "pic/trainer/sailor.pic"
JrTrainerMPic::    INCBIN "pic/trainer/jr.trainerm.pic"
JrTrainerFPic::    INCBIN "pic/trainer/jr.trainerf.pic"
PokemaniacPic::    INCBIN "pic/trainer/pokemaniac.pic"
SuperNerdPic::     INCBIN "pic/trainer/supernerd.pic"
HikerPic::         INCBIN "pic/trainer/hiker.pic"
BikerPic::         INCBIN "pic/trainer/biker.pic"
BurglarPic::       INCBIN "pic/trainer/burglar.pic"
EngineerPic::      INCBIN "pic/trainer/engineer.pic"
FisherPic::        INCBIN "pic/trainer/fisher.pic"
SwimmerPic::       INCBIN "pic/trainer/swimmer.pic"
CueBallPic::       INCBIN "pic/trainer/cueball.pic"
GamblerPic::       INCBIN "pic/trainer/gambler.pic"
BeautyPic::        INCBIN "pic/trainer/beauty.pic"
PsychicPic::       INCBIN "pic/trainer/psychic.pic"
RockerPic::        INCBIN "pic/trainer/rocker.pic"
JugglerPic::       INCBIN "pic/trainer/juggler.pic"
TamerPic::         INCBIN "pic/trainer/tamer.pic"
BirdKeeperPic::    INCBIN "pic/trainer/birdkeeper.pic"
BlackbeltPic::     INCBIN "pic/trainer/blackbelt.pic"
Rival1Pic::        INCBIN "pic/trainer/rival1.pic"
SwimmerFPic::      INCBIN "pic/trainer/swimmerf.pic"
RocketFPic::       INCBIN "pic/trainer/rocketf.pic"
ScientistPic::     INCBIN "pic/trainer/scientist.pic"
GiovanniPic::      INCBIN "pic/trainer/giovanni.pic"
RocketPic::        INCBIN "pic/trainer/rocket.pic"
CooltrainerMPic::  INCBIN "pic/trainer/cooltrainerm.pic"
CooltrainerFPic::  INCBIN "pic/trainer/cooltrainerf.pic"
BrunoPic::         INCBIN "pic/trainer/bruno.pic"
BrockPic::         INCBIN "pic/trainer/brock.pic"
MistyPic::         INCBIN "pic/trainer/misty.pic"
LtSurgePic::       INCBIN "pic/trainer/lt.surge.pic"
ErikaPic::         INCBIN "pic/trainer/erika.pic"
KogaPic::          INCBIN "pic/trainer/koga.pic"
BlainePic::        INCBIN "pic/trainer/blaine.pic"
SabrinaPic::       INCBIN "pic/trainer/sabrina.pic"
GentlemanPic::     INCBIN "pic/trainer/gentleman.pic"
Rival2Pic::        INCBIN "pic/trainer/rival2.pic"
Rival3Pic::        INCBIN "pic/trainer/rival3.pic"
LoreleiPic::       INCBIN "pic/trainer/lorelei.pic"
ChannelerPic::     INCBIN "pic/trainer/channeler.pic"
AgathaPic::        INCBIN "pic/trainer/agatha.pic"
LancePic::         INCBIN "pic/trainer/lance.pic"
YoungCouplePic::   INCBIN "pic/trainer/young_couple.pic"
FlanneryPic::      INCBIN "pic/trainer/flannery.pic"

INCLUDE "data/mapHeaders/TradeCenter.asm"
INCLUDE "scripts/TradeCenter.asm"
INCLUDE "data/mapObjects/TradeCenter.asm"
TradeCenterBlocks: INCBIN "maps/TradeCenter.blk"

INCLUDE "data/mapHeaders/Colosseum.asm"
INCLUDE "scripts/Colosseum.asm"
INCLUDE "data/mapObjects/Colosseum.asm"
ColosseumBlocks: INCBIN "maps/Colosseum.blk"

INCLUDE "engine/give_pokemon.asm"

INCLUDE "engine/predefs.asm"


SECTION "bank14",ROMX,BANK[$14]

INCLUDE "data/mapHeaders/Route22.asm"
INCLUDE "data/mapObjects/Route22.asm"
Route22Blocks: INCBIN "maps/Route22.blk"

INCLUDE "data/mapHeaders/Route20.asm"
INCLUDE "data/mapObjects/Route20.asm"
Route20Blocks: INCBIN "maps/Route20.blk"

INCLUDE "data/mapHeaders/Route23.asm"
INCLUDE "data/mapObjects/Route23.asm"
Route23Blocks: INCBIN "maps/Route23.blk"

INCLUDE "data/mapHeaders/Route24.asm"
INCLUDE "data/mapObjects/Route24.asm"
Route24Blocks: INCBIN "maps/Route24.blk"

INCLUDE "data/mapHeaders/Route25.asm"
INCLUDE "data/mapObjects/Route25.asm"
Route25Blocks: INCBIN "maps/Route25.blk"

INCLUDE "data/mapHeaders/IndigoPlateau.asm"
INCLUDE "scripts/IndigoPlateau.asm"
INCLUDE "data/mapObjects/IndigoPlateau.asm"
IndigoPlateauBlocks: INCBIN "maps/IndigoPlateau.blk"

INCLUDE "data/mapHeaders/SaffronCity.asm"
INCLUDE "data/mapObjects/SaffronCity.asm"
SaffronCityBlocks: INCBIN "maps/SaffronCity.blk"
INCLUDE "scripts/SaffronCity.asm"

INCLUDE "scripts/Route20.asm"
INCLUDE "scripts/Route22.asm"
INCLUDE "scripts/Route23.asm"
INCLUDE "scripts/Route24.asm"
INCLUDE "scripts/Route25.asm"

INCLUDE "data/mapHeaders/VictoryRoad2.asm"
INCLUDE "scripts/VictoryRoad2.asm"
INCLUDE "data/mapObjects/VictoryRoad2.asm"
VictoryRoad2Blocks: INCBIN "maps/VictoryRoad2.blk"

INCLUDE "data/mapHeaders/MtMoon2.asm"
INCLUDE "scripts/MtMoon2.asm"
INCLUDE "data/mapObjects/MtMoon2.asm"
MtMoon2Blocks: INCBIN "maps/MtMoon2.blk"

INCLUDE "data/mapHeaders/SilphCo7F.asm"
INCLUDE "scripts/SilphCo7F.asm"
INCLUDE "data/mapObjects/SilphCo7F.asm"
SilphCo7Blocks: INCBIN "maps/SilphCo7F.blk"

INCLUDE "data/mapHeaders/Mansion2.asm"
INCLUDE "scripts/Mansion2.asm"
INCLUDE "data/mapObjects/Mansion2.asm"
Mansion2Blocks: INCBIN "maps/Mansion2.blk"

INCLUDE "data/mapHeaders/Mansion3.asm"
INCLUDE "scripts/Mansion3.asm"
INCLUDE "data/mapObjects/Mansion3.asm"
Mansion3Blocks: INCBIN "maps/Mansion3.blk"

INCLUDE "data/mapHeaders/Mansion4.asm"
INCLUDE "scripts/Mansion4.asm"
INCLUDE "data/mapObjects/Mansion4.asm"
Mansion4Blocks: INCBIN "maps/Mansion4.blk"

INCLUDE "engine/battle/init_battle_variables.asm"
INCLUDE "engine/battle/moveEffects/paralyze_effect.asm"

INCLUDE "engine/overworld/card_key.asm"

INCLUDE "engine/menu/prize_menu.asm"

INCLUDE "engine/hidden_object_functions14.asm"


SECTION "bank15",ROMX,BANK[$15]

INCLUDE "data/mapHeaders/Route2.asm"
INCLUDE "data/mapObjects/Route2.asm"
Route2Blocks: INCBIN "maps/Route2.blk"

INCLUDE "data/mapHeaders/Route3.asm"
INCLUDE "data/mapObjects/Route3.asm"
Route3Blocks: INCBIN "maps/Route3.blk"

INCLUDE "data/mapHeaders/Route4.asm"
INCLUDE "data/mapObjects/Route4.asm"
Route4Blocks: INCBIN "maps/Route4.blk"

INCLUDE "data/mapHeaders/Route5.asm"
INCLUDE "data/mapObjects/Route5.asm"
Route5Blocks: INCBIN "maps/Route5.blk"

INCLUDE "data/mapHeaders/Route9.asm"
INCLUDE "data/mapObjects/Route9.asm"
Route9Blocks: INCBIN "maps/Route9.blk"

INCLUDE "data/mapHeaders/Route13.asm"
INCLUDE "data/mapObjects/Route13.asm"
Route13Blocks: INCBIN "maps/Route13.blk"

INCLUDE "data/mapHeaders/Route14.asm"
INCLUDE "data/mapObjects/Route14.asm"
Route14Blocks: INCBIN "maps/Route14.blk"

INCLUDE "data/mapHeaders/Route17.asm"
INCLUDE "data/mapObjects/Route17.asm"
Route17Blocks: INCBIN "maps/Route17.blk"

INCLUDE "data/mapHeaders/Route19.asm"
INCLUDE "data/mapObjects/Route19.asm"
Route19Blocks: INCBIN "maps/Route19.blk"

INCLUDE "data/mapHeaders/Route21.asm"
INCLUDE "data/mapObjects/Route21.asm"
Route21Blocks: INCBIN "maps/Route21.blk"

VermilionHouse2Blocks:
Route12HouseBlocks:
DayCareMBlocks: INCBIN "maps/Daycarem.blk"

FuchsiaHouse3Blocks: INCBIN "maps/FuchsiaHouse3.blk"

INCLUDE "engine/battle/experience.asm"

INCLUDE "scripts/Route2.asm"
INCLUDE "scripts/Route3.asm"
INCLUDE "scripts/Route4.asm"
INCLUDE "scripts/Route5.asm"
INCLUDE "scripts/Route9.asm"
INCLUDE "scripts/Route13.asm"
INCLUDE "scripts/Route14.asm"
INCLUDE "scripts/Route17.asm"
INCLUDE "scripts/Route19.asm"
INCLUDE "scripts/Route21.asm"

INCLUDE "data/mapHeaders/VermilionHouse2.asm"
INCLUDE "scripts/VermilionHouse2.asm"
INCLUDE "data/mapObjects/VermilionHouse2.asm"

INCLUDE "data/mapHeaders/CeladonMart2.asm"
INCLUDE "scripts/CeladonMart2.asm"
INCLUDE "data/mapObjects/CeladonMart2.asm"
INCLUDE "data/martInventories/celadon_2.asm"
CeladonMart2Blocks: INCBIN "maps/CeladonMart2.blk"

INCLUDE "data/mapHeaders/FuchsiaHouse3.asm"
INCLUDE "scripts/FuchsiaHouse3.asm"
INCLUDE "data/mapObjects/FuchsiaHouse3.asm"

INCLUDE "data/mapHeaders/Daycarem.asm"
INCLUDE "scripts/Daycarem.asm"
INCLUDE "data/mapObjects/Daycarem.asm"

INCLUDE "data/mapHeaders/Route12House.asm"
INCLUDE "scripts/Route12House.asm"
INCLUDE "data/mapObjects/Route12House.asm"

INCLUDE "data/mapHeaders/SilphCo8F.asm"
INCLUDE "scripts/SilphCo8F.asm"
INCLUDE "data/mapObjects/SilphCo8F.asm"
SilphCo8Blocks: INCBIN "maps/SilphCo8F.blk"

INCLUDE "engine/menu/diploma.asm"

INCLUDE "engine/overworld/trainers.asm"

IsMonShiny:
; Input: de = address in RAM for DVs
; Reset zero flag if mon is shiny
; 1 in 1024 wild Pokémon is shiny.

	ld h, d
	ld l, e

; Attack must be odd (1, 3, 5, 7, 9, 11, 13, or 15) (1 in 2)
	ld a, [hl]
	and 1 << 4
	jr z, .NotShiny

; Defense must be 2, 3, 7, or 11 (1 in 4)
	ld a, [hli]
	and $f
	cp 2
	jr z, .MaybeShiny1
	cp 3
	jr z, .MaybeShiny1
	cp 7
	jr z, .MaybeShiny1
	cp 11
	jr nz, .NotShiny

; Speed must be 5 or 13 (1 in 8)
.MaybeShiny1
	ld a, [hl]
	and $f << 4
	cp 5 << 4
	jr z, .MaybeShiny2
	cp 13 << 4
	jr nz, .NotShiny

; Special must be 15 (1 in 16)
.MaybeShiny2
	ld a, [hl]
	and $f
	cp 15
	jr nz, .NotShiny

.Shiny
	; set zero flag
	and a ; a cannot be 0, so zero flag is set with thing command
	ret
.NotShiny
	; reset zero flag
	xor a
	ret

EvolutionSetWholeScreenPalette_:
	; check if evolving mon is shiny
	ld hl, wShinyMonFlag
	res 0, [hl]
	ld b, Bank(IsMonShiny)
	ld hl, IsMonShiny
	push de
	ld de, wLoadedMonDVs
	call Bankswitch
	pop de
	jr z, .setPAL
	ld hl, wShinyMonFlag
	set 0, [hl]
.setPAL
	ld c, d
	ld b, SET_PAL_POKEMON_WHOLE_SCREEN
	jp RunPaletteCommand

PlayShinySparkleAnimation:
	; flash the screen
	ld a, [rBGP]
	push af
	ld a,%00011011 ; 0, 1, 2, 3 (inverted colors)
	ld [rBGP],a
	ld c,4
	call DelayFrames
	pop af
	ld [rBGP],a ; restore initial palette
	; play animation
	ld b, $b + 1
.loop
	dec b
	jr z,.animationFinished
	ld c, ((ShinySparkleCoordsEnd - ShinySparkleCoords) / 3) + 1
	ld a, [wShinyMonFlag]
	bit 1, a
	ld de,ShinySparkleCoords
	jr z, .ok
	ld de,EnemyShinySparkleCoords
.ok
	ld hl,wOAMBuffer
.innerLoop
	dec c
	jr z,.delayFrames
	ld a, [de]
	cp b
	jr c, .sparkleInactive
	sub b
	cp 4
	jr nc, .sparkleInactive
	push bc
	ld b, a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, $C9 ; first sparkle tile
	add 3
	sub b
	ld [hli], a
	xor a
	ld [hli], a
	pop bc
	jr .innerLoop
.sparkleInactive
	inc de
	inc de
	inc de
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	jr .innerLoop
.delayFrames
	push bc
	ld c,2
	call DelayFrames
	ld a, SFX_SILPH_SCOPE
	call PlaySound
	pop bc
	jr .loop
.animationFinished
	xor a
	ld hl, wOAMBuffer
	ld bc, 4 * ((ShinySparkleCoordsEnd - ShinySparkleCoords) / 3)
	jp FillMemory

ShinySparkleCoords:
; First byte is the frame where the animation starts (higher = sooner)
; Second and third bytes are y/x coordinates
	db $0B, 70, 48
	db $0A, 75, 60
	db $09, 86, 64
	db $08, 99, 60
	db $07, 103, 48
	db $06, 99, 36
	db $05, 86, 30
	db $04, 75, 36
ShinySparkleCoordsEnd:

EnemyShinySparkleCoords:
; First byte is the frame where the animation starts (higher = sooner)
; Second and third bytes are y/x coordinates
	db $0B, 70 - 48, 48 + 80
	db $0A, 75 - 48, 60 + 80
	db $09, 86 - 48, 64 + 80
	db $08, 99 - 48, 60 + 80
	db $07, 103 - 48, 48 + 80
	db $06, 99 - 48, 36 + 80
	db $05, 86 - 48, 30 + 80
	db $04, 75 - 48, 36 + 80
EnemyShinySparkleCoordsEnd:

INCLUDE "engine/menu/item_descriptions.asm"

INCLUDE "color/exp_bar.asm"


SECTION "bank16",ROMX,BANK[$16]

INCLUDE "data/mapHeaders/Route6.asm"
INCLUDE "data/mapObjects/Route6.asm"
Route6Blocks: INCBIN "maps/Route6.blk"

INCLUDE "data/mapHeaders/Route8.asm"
INCLUDE "data/mapObjects/Route8.asm"
Route8Blocks: INCBIN "maps/Route8.blk"

INCLUDE "data/mapHeaders/Route10.asm"
INCLUDE "data/mapObjects/Route10.asm"
Route10Blocks: INCBIN "maps/Route10.blk"

INCLUDE "data/mapHeaders/Route11.asm"
INCLUDE "data/mapObjects/Route11.asm"
Route11Blocks: INCBIN "maps/Route11.blk"

INCLUDE "data/mapHeaders/Route12.asm"
INCLUDE "data/mapObjects/Route12.asm"
Route12Blocks: INCBIN "maps/Route12.blk"

INCLUDE "data/mapHeaders/Route15.asm"
INCLUDE "data/mapObjects/Route15.asm"
Route15Blocks: INCBIN "maps/Route15.blk"

INCLUDE "data/mapHeaders/Route16.asm"
INCLUDE "data/mapObjects/Route16.asm"
Route16Blocks: INCBIN "maps/Route16.blk"

INCLUDE "data/mapHeaders/Route18.asm"
INCLUDE "data/mapObjects/Route18.asm"
Route18Blocks: INCBIN "maps/Route18.blk"


INCLUDE "engine/battle/common_text.asm"

INCLUDE "engine/experience.asm"

INCLUDE "engine/overworld/oaks_aide.asm"

INCLUDE "scripts/Route6.asm"
INCLUDE "scripts/Route8.asm"
INCLUDE "scripts/Route10.asm"
INCLUDE "scripts/Route11.asm"
INCLUDE "scripts/Route12.asm"
INCLUDE "scripts/Route15.asm"
INCLUDE "scripts/Route16.asm"
INCLUDE "scripts/Route18.asm"

INCLUDE "data/mapHeaders/PokemonFanClub.asm"
INCLUDE "scripts/PokemonFanClub.asm"
INCLUDE "data/mapObjects/PokemonFanClub.asm"
FanClubBlocks:
	INCBIN "maps/PokemonFanClub.blk"

INCLUDE "data/mapHeaders/SilphCo2F.asm"
INCLUDE "scripts/SilphCo2F.asm"
INCLUDE "data/mapObjects/SilphCo2F.asm"
SilphCo2Blocks:
	INCBIN "maps/SilphCo2F.blk"

INCLUDE "data/mapHeaders/SilphCo3F.asm"
INCLUDE "scripts/SilphCo3F.asm"
INCLUDE "data/mapObjects/SilphCo3F.asm"
SilphCo3Blocks:
	INCBIN "maps/SilphCo3F.blk"

INCLUDE "data/mapHeaders/SilphCo10F.asm"
INCLUDE "scripts/SilphCo10F.asm"
INCLUDE "data/mapObjects/SilphCo10F.asm"
SilphCo10Blocks:
	INCBIN "maps/SilphCo10F.blk"

INCLUDE "data/mapHeaders/LancesRoom.asm"
INCLUDE "scripts/LancesRoom.asm"
INCLUDE "data/mapObjects/LancesRoom.asm"
LanceBlocks:
	INCBIN "maps/LancesRoom.blk"

INCLUDE "data/mapHeaders/HallOfFame.asm"
INCLUDE "scripts/HallOfFame.asm"
INCLUDE "data/mapObjects/HallOfFame.asm"
HallofFameRoomBlocks:
	INCBIN "maps/HallOfFame.blk"

INCLUDE "engine/overworld/saffron_guards.asm"


SECTION "bank17",ROMX,BANK[$17]

SaffronMartBlocks:
LavenderMartBlocks:
CeruleanMartBlocks:
VermilionMartBlocks: INCBIN "maps/VermilionMart.blk"

CopycatsHouse2FBlocks:
RedsHouse2FBlocks: INCBIN "maps/RedsHouse2F.blk"

Museum1FBlocks: INCBIN "maps/Museum1F.blk"

Museum2FBlocks: INCBIN "maps/Museum2F.blk"

UndergroundPathEntranceRoute7Blocks:
UndergroundPathEntranceRoute7CopyBlocks:
UndergroundPathEntranceRoute6Blocks:
UndergroundPathEntranceRoute5Blocks: INCBIN "maps/PathEntranceRoute5.blk"

Route2GateBlocks:
ViridianForestEntranceBlocks:
ViridianForestExitBlocks: INCBIN "maps/ViridianForestExit.blk"

INCLUDE "data/mapHeaders/RedsHouse2F.asm"
INCLUDE "scripts/RedsHouse2F.asm"
INCLUDE "data/mapObjects/RedsHouse2F.asm"

INCLUDE "engine/predefs17.asm"

INCLUDE "data/mapHeaders/Museum1F.asm"
INCLUDE "scripts/Museum1F.asm"
INCLUDE "data/mapObjects/Museum1F.asm"

INCLUDE "data/mapHeaders/Museum2F.asm"
INCLUDE "scripts/Museum2F.asm"
INCLUDE "data/mapObjects/Museum2F.asm"

INCLUDE "data/mapHeaders/PewterGym.asm"
INCLUDE "scripts/PewterGym.asm"
INCLUDE "data/mapObjects/PewterGym.asm"
PewterGymBlocks: INCBIN "maps/PewterGym.blk"

INCLUDE "data/mapHeaders/CeruleanGym.asm"
INCLUDE "scripts/CeruleanGym.asm"
INCLUDE "data/mapObjects/CeruleanGym.asm"
CeruleanGymBlocks: INCBIN "maps/CeruleanGym.blk"

INCLUDE "data/mapHeaders/CeruleanMart.asm"
INCLUDE "scripts/CeruleanMart.asm"
INCLUDE "data/mapObjects/CeruleanMart.asm"
INCLUDE "data/martInventories/cerulean.asm"

INCLUDE "data/mapHeaders/LavenderMart.asm"
INCLUDE "scripts/LavenderMart.asm"
INCLUDE "data/mapObjects/LavenderMart.asm"
INCLUDE "data/martInventories/lavender.asm"

INCLUDE "data/mapHeaders/VermilionMart.asm"
INCLUDE "scripts/VermilionMart.asm"
INCLUDE "data/mapObjects/VermilionMart.asm"
INCLUDE "data/martInventories/vermillion.asm"

INCLUDE "data/mapHeaders/VermilionGym.asm"
INCLUDE "scripts/VermilionGym.asm"
INCLUDE "data/mapObjects/VermilionGym.asm"
VermilionGymBlocks: INCBIN "maps/VermilionGym.blk"

INCLUDE "data/mapHeaders/CopycatsHouse2F.asm"
INCLUDE "scripts/CopycatsHouse2F.asm"
INCLUDE "data/mapObjects/CopycatsHouse2F.asm"

INCLUDE "data/mapHeaders/FightingDojo.asm"
INCLUDE "scripts/FightingDojo.asm"
INCLUDE "data/mapObjects/FightingDojo.asm"
FightingDojoBlocks: INCBIN "maps/FightingDojo.blk"

INCLUDE "data/mapHeaders/SaffronGym.asm"
INCLUDE "scripts/SaffronGym.asm"
INCLUDE "data/mapObjects/SaffronGym.asm"
SaffronGymBlocks: INCBIN "maps/SaffronGym.blk"

INCLUDE "data/mapHeaders/SaffronMart.asm"
INCLUDE "scripts/SaffronMart.asm"
INCLUDE "data/mapObjects/SaffronMart.asm"
INCLUDE "data/martInventories/saffron.asm"

INCLUDE "data/mapHeaders/SilphCo1F.asm"
INCLUDE "scripts/SilphCo1F.asm"
INCLUDE "data/mapObjects/SilphCo1F.asm"
SilphCo1Blocks: INCBIN "maps/SilphCo1F.blk"

INCLUDE "data/mapHeaders/ViridianForestExit.asm"
INCLUDE "scripts/ViridianForestExit.asm"
INCLUDE "data/mapObjects/ViridianForestExit.asm"

INCLUDE "data/mapHeaders/Route2Gate.asm"
INCLUDE "scripts/Route2Gate.asm"
INCLUDE "data/mapObjects/Route2Gate.asm"

INCLUDE "data/mapHeaders/ViridianForestEntrance.asm"
INCLUDE "scripts/ViridianForestEntrance.asm"
INCLUDE "data/mapObjects/ViridianForestEntrance.asm"

INCLUDE "data/mapHeaders/PathEntranceRoute5.asm"
INCLUDE "scripts/PathEntranceRoute5.asm"
INCLUDE "data/mapObjects/PathEntranceRoute5.asm"

INCLUDE "data/mapHeaders/PathEntranceRoute6.asm"
INCLUDE "scripts/PathEntranceRoute6.asm"
INCLUDE "data/mapObjects/PathEntranceRoute6.asm"

INCLUDE "data/mapHeaders/PathEntranceRoute7.asm"
INCLUDE "scripts/PathEntranceRoute7.asm"
INCLUDE "data/mapObjects/PathEntranceRoute7.asm"

INCLUDE "data/mapHeaders/PathEntranceRoute5Copy.asm"
INCLUDE "scripts/PathEntranceRoute5Copy.asm"
INCLUDE "data/mapObjects/PathEntranceRoute5Copy.asm"

INCLUDE "data/mapHeaders/SilphCo9F.asm"
INCLUDE "scripts/SilphCo9F.asm"
INCLUDE "data/mapObjects/SilphCo9F.asm"
SilphCo9Blocks: INCBIN "maps/SilphCo9F.blk"

INCLUDE "data/mapHeaders/VictoryRoad1.asm"
INCLUDE "scripts/VictoryRoad1.asm"
INCLUDE "data/mapObjects/VictoryRoad1.asm"
VictoryRoad1Blocks: INCBIN "maps/VictoryRoad1.blk"

INCLUDE "engine/predefs17_2.asm"

INCLUDE "engine/hidden_object_functions17.asm"


SECTION "bank18",ROMX,BANK[$18]

ViridianForestBlocks:    INCBIN "maps/ViridianForest.blk"
UndergroundPathNSBlocks: INCBIN "maps/UndergroundPathNS.blk"
UndergroundPathWEBlocks: INCBIN "maps/UndergroundPathWE.blk"

SSAnne10Blocks:
SSAnne9Blocks: INCBIN "maps/SsAnne9.blk"

INCLUDE "data/mapHeaders/Pokemontower1.asm"
INCLUDE "scripts/Pokemontower1.asm"
INCLUDE "data/mapObjects/Pokemontower1.asm"
PokemonTower1Blocks: INCBIN "maps/Pokemontower1.blk"

INCLUDE "data/mapHeaders/Pokemontower2.asm"
INCLUDE "scripts/Pokemontower2.asm"
INCLUDE "data/mapObjects/Pokemontower2.asm"
PokemonTower2Blocks: INCBIN "maps/Pokemontower2.blk"

INCLUDE "data/mapHeaders/Pokemontower3.asm"
INCLUDE "scripts/Pokemontower3.asm"
INCLUDE "data/mapObjects/Pokemontower3.asm"
PokemonTower3Blocks: INCBIN "maps/Pokemontower3.blk"

INCLUDE "data/mapHeaders/Pokemontower4.asm"
INCLUDE "scripts/Pokemontower4.asm"
INCLUDE "data/mapObjects/Pokemontower4.asm"
PokemonTower4Blocks: INCBIN "maps/Pokemontower4.blk"

INCLUDE "data/mapHeaders/Pokemontower5.asm"
INCLUDE "scripts/Pokemontower5.asm"
INCLUDE "data/mapObjects/Pokemontower5.asm"
PokemonTower5Blocks: INCBIN "maps/Pokemontower5.blk"

INCLUDE "data/mapHeaders/Pokemontower6.asm"
INCLUDE "scripts/Pokemontower6.asm"
INCLUDE "data/mapObjects/Pokemontower6.asm"
PokemonTower6Blocks: INCBIN "maps/Pokemontower6.blk"

INCLUDE "data/mapHeaders/Pokemontower7.asm"
INCLUDE "scripts/Pokemontower7.asm"
INCLUDE "data/mapObjects/Pokemontower7.asm"
PokemonTower7Blocks: INCBIN "maps/Pokemontower7.blk"

INCLUDE "data/mapHeaders/CeladonMart1.asm"
INCLUDE "scripts/CeladonMart1.asm"
INCLUDE "data/mapObjects/CeladonMart1.asm"
CeladonMart1Blocks: INCBIN "maps/CeladonMart1.blk"

INCLUDE "engine/overworld/cinnabar_lab.asm"

INCLUDE "data/mapHeaders/ViridianForest.asm"
INCLUDE "scripts/ViridianForest.asm"
INCLUDE "data/mapObjects/ViridianForest.asm"

INCLUDE "data/mapHeaders/SsAnne1.asm"
INCLUDE "scripts/SsAnne1.asm"
INCLUDE "data/mapObjects/SsAnne1.asm"
SSAnne1Blocks: INCBIN "maps/SsAnne1.blk"

INCLUDE "data/mapHeaders/SsAnne2.asm"
INCLUDE "scripts/SsAnne2.asm"
INCLUDE "data/mapObjects/SsAnne2.asm"
SSAnne2Blocks: INCBIN "maps/SsAnne2.blk"

INCLUDE "data/mapHeaders/SsAnne4.asm"
INCLUDE "scripts/SsAnne4.asm"
INCLUDE "data/mapObjects/SsAnne4.asm"
SSAnne4Blocks: INCBIN "maps/SsAnne4.blk"

INCLUDE "data/mapHeaders/SsAnne5.asm"
INCLUDE "scripts/SsAnne5.asm"
INCLUDE "data/mapObjects/SsAnne5.asm"
SSAnne5Blocks: INCBIN "maps/SsAnne5.blk"

INCLUDE "data/mapHeaders/SsAnne6.asm"
INCLUDE "scripts/SsAnne6.asm"
INCLUDE "data/mapObjects/SsAnne6.asm"
SSAnne6Blocks: INCBIN "maps/SsAnne6.blk"

INCLUDE "data/mapHeaders/SsAnne7.asm"
INCLUDE "scripts/SsAnne7.asm"
INCLUDE "data/mapObjects/SsAnne7.asm"
SSAnne7Blocks: INCBIN "maps/SsAnne7.blk"

INCLUDE "data/mapHeaders/SsAnne8.asm"
INCLUDE "scripts/SsAnne8.asm"
INCLUDE "data/mapObjects/SsAnne8.asm"
SSAnne8Blocks: INCBIN "maps/SsAnne8.blk"

INCLUDE "data/mapHeaders/SsAnne9.asm"
INCLUDE "scripts/SsAnne9.asm"
INCLUDE "data/mapObjects/SsAnne9.asm"

INCLUDE "data/mapHeaders/SsAnne10.asm"
INCLUDE "scripts/SsAnne10.asm"
INCLUDE "data/mapObjects/SsAnne10.asm"

INCLUDE "data/mapHeaders/UndergroundPathNS.asm"
INCLUDE "scripts/UndergroundPathNS.asm"
INCLUDE "data/mapObjects/UndergroundPathNS.asm"

INCLUDE "data/mapHeaders/UndergroundPathWE.asm"
INCLUDE "scripts/UndergroundPathWE.asm"
INCLUDE "data/mapObjects/UndergroundPathWE.asm"

INCLUDE "data/mapHeaders/DiglettsCave.asm"
INCLUDE "scripts/DiglettsCave.asm"
INCLUDE "data/mapObjects/DiglettsCave.asm"
DiglettsCaveBlocks: INCBIN "maps/DiglettsCave.blk"

INCLUDE "data/mapHeaders/SilphCo11F.asm"
INCLUDE "scripts/SilphCo11F.asm"
INCLUDE "data/mapObjects/SilphCo11F.asm"
SilphCo11Blocks: INCBIN "maps/SilphCo11F.blk"

INCLUDE "engine/hidden_object_functions18.asm"


SECTION "bank19",ROMX,BANK[$19]

RedsHouse1_GFX:
RedsHouse2_GFX:    INCBIN "gfx/tilesets/reds_house.2bpp"
RedsHouse1_Block:
RedsHouse2_Block:  INCBIN "gfx/blocksets/reds_house.bst"

House_GFX:         INCBIN "gfx/tilesets/house.t2.2bpp"
House_Block:       INCBIN "gfx/blocksets/house.bst"
Mansion_GFX:       INCBIN "gfx/tilesets/mansion.t2.2bpp"
Mansion_Block:     INCBIN "gfx/blocksets/mansion.bst"
ShipPort_GFX:      INCBIN "gfx/tilesets/ship_port.t2.2bpp"
ShipPort_Block:    INCBIN "gfx/blocksets/ship_port.bst"
Interior_GFX:      INCBIN "gfx/tilesets/interior.t1.2bpp"
Interior_Block:    INCBIN "gfx/blocksets/interior.bst"
Plateau_GFX:       INCBIN "gfx/tilesets/plateau.t6.2bpp"
Plateau_Block:     INCBIN "gfx/blocksets/plateau.bst"

INCLUDE "engine/battle/get_trainer_pic_pointers.asm"

SECTION "bank1A",ROMX,BANK[$1A]

INCLUDE "engine/battle/decrement_pp.asm"

Version_GFX:       INCBIN "gfx/red/redgreenversion.1bpp" ; 10 tiles
Version_GFXEnd:

OakTS_GFX:         INCBIN "gfx/tilesets/oakts.2bpp"
OakTS_Block:       INCBIN "gfx/blocksets/oakts.bst"

Gym_GFX:           INCBIN "gfx/tilesets/gym.2bpp"
Gym_Block:         INCBIN "gfx/blocksets/gym.bst"

Pokecenter_GFX:    INCBIN "gfx/tilesets/pokecenter.2bpp"
Pokecenter_Block:  INCBIN "gfx/blocksets/pokecenter.bst"

Gate_GFX:          INCBIN "gfx/tilesets/gate.t1.2bpp"
Gate_Block:        INCBIN "gfx/blocksets/gate.bst"

Facility_GFX:      INCBIN "gfx/tilesets/facility.2bpp"
Facility_Block:    INCBIN "gfx/blocksets/facility.bst"


SECTION "bank1B",ROMX,BANK[$1B]

Cemetery_GFX:      INCBIN "gfx/tilesets/cemetery.t4.2bpp"
Cemetery_Block:    INCBIN "gfx/blocksets/cemetery.bst"
Lobby_GFX:         INCBIN "gfx/tilesets/lobby.t2.2bpp"
Lobby_Block:       INCBIN "gfx/blocksets/lobby.bst"
Ship_GFX:          INCBIN "gfx/tilesets/ship.t6.2bpp"
Ship_Block:        INCBIN "gfx/blocksets/ship.bst"
Lab_GFX:           INCBIN "gfx/tilesets/lab.t4.2bpp"
Lab_Block:         INCBIN "gfx/blocksets/lab.bst"
Club_GFX:          INCBIN "gfx/tilesets/club.t5.2bpp"
Club_Block:        INCBIN "gfx/blocksets/club.bst"
Underground_GFX:   INCBIN "gfx/tilesets/underground.t7.2bpp"
Underground_Block: INCBIN "gfx/blocksets/underground.bst"


SECTION "bank1C",ROMX,BANK[$1C]

INCLUDE "engine/gamefreak.asm"
INCLUDE "engine/hall_of_fame.asm"
INCLUDE "engine/overworld/healing_machine.asm"
INCLUDE "engine/overworld/player_animations.asm"
INCLUDE "engine/battle/ghost_marowak_anim.asm"
INCLUDE "engine/battle/battle_transitions.asm"
INCLUDE "engine/town_map.asm"
INCLUDE "engine/mon_party_sprites.asm"
INCLUDE "engine/in_game_trades.asm"
INCLUDE "engine/palettes.asm"

INCLUDE "engine/save.asm"
 
BlackTile:
	REPT 16
	db $ff
	ENDR
BlackTileEnd:

INCLUDE "color/ghost_marowak_anim.asm"
INCLUDE "color/color.asm"


SECTION "bank1D",ROMX,BANK[$1D]

CopycatsHouse1FBlocks: INCBIN "maps/CopycatsHouse1F.blk"

CinnabarMartBlocks:
PewterMartBlocks: INCBIN "maps/PewterMart.blk"

FuchsiaHouse1Blocks: INCBIN "maps/FuchsiaHouse1.blk"

CeruleanHouse2Blocks: INCBIN "maps/CeruleanHouse2.blk"

INCLUDE "engine/HoF_room_pc.asm"

INCLUDE "engine/status_ailments.asm"

INCLUDE "engine/items/itemfinder.asm"

INCLUDE "scripts/CeruleanCity2.asm"

INCLUDE "data/mapHeaders/ViridianGym.asm"
INCLUDE "scripts/ViridianGym.asm"
INCLUDE "data/mapObjects/ViridianGym.asm"
ViridianGymBlocks: INCBIN "maps/ViridianGym.blk"

INCLUDE "data/mapHeaders/PewterMart.asm"
INCLUDE "scripts/PewterMart.asm"
INCLUDE "data/mapObjects/PewterMart.asm"
INCLUDE "data/martInventories/pewter.asm"

INCLUDE "data/mapHeaders/UnknownDungeon1.asm"
INCLUDE "scripts/UnknownDungeon1.asm"
INCLUDE "data/mapObjects/UnknownDungeon1.asm"
UnknownDungeon1Blocks: INCBIN "maps/UnknownDungeon1.blk"

INCLUDE "data/mapHeaders/CeruleanHouse2.asm"
INCLUDE "scripts/CeruleanHouse2.asm"
INCLUDE "data/mapObjects/CeruleanHouse2.asm"

INCLUDE "engine/menu/vending_machine.asm"

INCLUDE "data/mapHeaders/FuchsiaHouse1.asm"
INCLUDE "scripts/FuchsiaHouse1.asm"
INCLUDE "data/mapObjects/FuchsiaHouse1.asm"

INCLUDE "data/mapHeaders/FuchsiaHouse2.asm"
INCLUDE "scripts/FuchsiaHouse2.asm"
INCLUDE "data/mapObjects/FuchsiaHouse2.asm"
FuchsiaHouse2Blocks: INCBIN "maps/FuchsiaHouse2.blk"

INCLUDE "data/mapHeaders/SafariZoneEntrance.asm"
INCLUDE "scripts/SafariZoneEntrance.asm"
INCLUDE "data/mapObjects/SafariZoneEntrance.asm"
SafariZoneEntranceBlocks: INCBIN "maps/SafariZoneEntrance.blk"

INCLUDE "data/mapHeaders/FuchsiaGym.asm"
INCLUDE "scripts/FuchsiaGym.asm"
INCLUDE "data/mapObjects/FuchsiaGym.asm"
FuchsiaGymBlocks: INCBIN "maps/FuchsiaGym.blk"

INCLUDE "data/mapHeaders/FuchsiaMeetingRoom.asm"
INCLUDE "scripts/FuchsiaMeetingRoom.asm"
INCLUDE "data/mapObjects/FuchsiaMeetingRoom.asm"
FuchsiaMeetingRoomBlocks: INCBIN "maps/FuchsiaMeetingRoom.blk"

INCLUDE "data/mapHeaders/CinnabarGym.asm"
INCLUDE "scripts/CinnabarGym.asm"
INCLUDE "data/mapObjects/CinnabarGym.asm"
CinnabarGymBlocks: INCBIN "maps/CinnabarGym.blk"

INCLUDE "data/mapHeaders/CinnabarLab1.asm"
INCLUDE "scripts/CinnabarLab1.asm"
INCLUDE "data/mapObjects/CinnabarLab1.asm"
Lab1Blocks: INCBIN "maps/CinnabarLab1.blk"

INCLUDE "data/mapHeaders/CinnabarLab2.asm"
INCLUDE "scripts/CinnabarLab2.asm"
INCLUDE "data/mapObjects/CinnabarLab2.asm"
Lab2Blocks: INCBIN "maps/CinnabarLab2.blk"

INCLUDE "data/mapHeaders/CinnabarLab3.asm"
INCLUDE "scripts/CinnabarLab3.asm"
INCLUDE "data/mapObjects/CinnabarLab3.asm"
Lab3Blocks: INCBIN "maps/CinnabarLab3.blk"

INCLUDE "data/mapHeaders/CinnabarLab4.asm"
INCLUDE "scripts/CinnabarLab4.asm"
INCLUDE "data/mapObjects/CinnabarLab4.asm"
Lab4Blocks: INCBIN "maps/CinnabarLab4.blk"

INCLUDE "data/mapHeaders/CinnabarMart.asm"
INCLUDE "scripts/CinnabarMart.asm"
INCLUDE "data/mapObjects/CinnabarMart.asm"
INCLUDE "data/martInventories/cinnabar.asm"

INCLUDE "data/mapHeaders/CopycatsHouse1F.asm"
INCLUDE "scripts/CopycatsHouse1F.asm"
INCLUDE "data/mapObjects/CopycatsHouse1F.asm"

INCLUDE "data/mapHeaders/ChampionsRoom.asm"
INCLUDE "scripts/ChampionsRoom.asm"
INCLUDE "data/mapObjects/ChampionsRoom.asm"
GaryBlocks: INCBIN "maps/ChampionsRoom.blk"

INCLUDE "data/mapHeaders/LoreleisRoom.asm"
INCLUDE "scripts/LoreleisRoom.asm"
INCLUDE "data/mapObjects/LoreleisRoom.asm"
LoreleiBlocks: INCBIN "maps/LoreleisRoom.blk"

INCLUDE "data/mapHeaders/BrunosRoom.asm"
INCLUDE "scripts/BrunosRoom.asm"
INCLUDE "data/mapObjects/BrunosRoom.asm"
BrunoBlocks: INCBIN "maps/BrunosRoom.blk"

INCLUDE "data/mapHeaders/AgathasRoom.asm"
INCLUDE "scripts/AgathasRoom.asm"
INCLUDE "data/mapObjects/AgathasRoom.asm"
AgathaBlocks: INCBIN "maps/AgathasRoom.blk"

INCLUDE "engine/menu/league_pc.asm"

INCLUDE "engine/overworld/hidden_items.asm"

RedFishingTilesFront: INCBIN "gfx/red_fishing_tile_front.2bpp"
RedFishingTilesBack:  INCBIN "gfx/red_fishing_tile_back.2bpp"
RedFishingTilesSide:  INCBIN "gfx/red_fishing_tile_side.2bpp"
RedFishingRodTiles:   INCBIN "gfx/red_fishingrod_tiles.2bpp"


SECTION "bank1E",ROMX,BANK[$1E]

INCLUDE "engine/battle/animations.asm"

INCLUDE "engine/overworld/cut2.asm"

INCLUDE "engine/overworld/ssanne.asm"

INCLUDE "data/animations.asm"

INCLUDE "engine/evolution.asm"

INCLUDE "engine/overworld/elevator.asm"

INCLUDE "engine/items/tm_prices.asm"

INCLUDE "color/animations.asm"


SECTION "bank2D",ROMX,BANK[$2D]

HorseaPicFront::       INCBIN "pic/bmon/horsea.pic"
HorseaPicBack::        INCBIN "pic/monback/horseab.pic"
SeadraPicFront::      INCBIN "pic/bmon/seadra.pic"
SeadraPicBack::       INCBIN "pic/monback/seadrab.pic"
GoldeenPicFront::     INCBIN "pic/bmon/goldeen.pic"
GoldeenPicBack::      INCBIN "pic/monback/goldeenb.pic"
SeakingPicFront::     INCBIN "pic/bmon/seaking.pic"
SeakingPicBack::      INCBIN "pic/monback/seakingb.pic"
StaryuPicFront::      INCBIN "pic/bmon/staryu.pic"
StaryuPicBack::       INCBIN "pic/monback/staryub.pic"
StarmiePicFront::     INCBIN "pic/bmon/starmie.pic"
StarmiePicBack::      INCBIN "pic/monback/starmieb.pic"
MrMimePicFront::      INCBIN "pic/bmon/mr.mime.pic"
MrMimePicBack::       INCBIN "pic/monback/mr.mimeb.pic"
ScytherPicFront::     INCBIN "pic/bmon/scyther.pic"
ScytherPicBack::      INCBIN "pic/monback/scytherb.pic"
JynxPicFront::        INCBIN "pic/bmon/jynx.pic"
JynxPicBack::         INCBIN "pic/monback/jynxb.pic"
ElectabuzzPicFront::  INCBIN "pic/bmon/electabuzz.pic"
ElectabuzzPicBack::   INCBIN "pic/monback/electabuzzb.pic"
MagmarPicFront::      INCBIN "pic/bmon/magmar.pic"
MagmarPicBack::       INCBIN "pic/monback/magmarb.pic"
PinsirPicFront::      INCBIN "pic/bmon/pinsir.pic"
PinsirPicBack::       INCBIN "pic/monback/pinsirb.pic"
TaurosPicFront::      INCBIN "pic/bmon/tauros.pic"
TaurosPicBack::       INCBIN "pic/monback/taurosb.pic"
MagikarpPicFront::    INCBIN "pic/bmon/magikarp.pic"
MagikarpPicBack::     INCBIN "pic/monback/magikarpb.pic"
GyaradosPicFront::    INCBIN "pic/bmon/gyarados.pic"
GyaradosPicBack::     INCBIN "pic/monback/gyaradosb.pic"
LaprasPicFront::      INCBIN "pic/bmon/lapras.pic"
LaprasPicBack::       INCBIN "pic/monback/laprasb.pic"
DittoPicFront::       INCBIN "pic/bmon/ditto.pic"
DittoPicBack::        INCBIN "pic/monback/dittob.pic"
EeveePicFront::       INCBIN "pic/bmon/eevee.pic"
EeveePicBack::        INCBIN "pic/monback/eeveeb.pic"
VaporeonPicFront::    INCBIN "pic/bmon/vaporeon.pic"
VaporeonPicBack::     INCBIN "pic/monback/vaporeonb.pic"
JolteonPicFront::     INCBIN "pic/bmon/jolteon.pic"
JolteonPicBack::      INCBIN "pic/monback/jolteonb.pic"
FlareonPicFront::     INCBIN "pic/bmon/flareon.pic"
FlareonPicBack::      INCBIN "pic/monback/flareonb.pic"
PorygonPicFront::     INCBIN "pic/bmon/porygon.pic"
PorygonPicBack::      INCBIN "pic/monback/porygonb.pic"
OmanytePicFront::     INCBIN "pic/bmon/omanyte.pic"
OmanytePicBack::      INCBIN "pic/monback/omanyteb.pic"
OmastarPicFront::     INCBIN "pic/bmon/omastar.pic"
OmastarPicBack::      INCBIN "pic/monback/omastarb.pic"



SECTION "bank2E",ROMX,BANK[$2E]

KabutoPicFront::      INCBIN "pic/bmon/kabuto.pic"
KabutoPicBack::       INCBIN "pic/monback/kabutob.pic"
KabutopsPicFront::    INCBIN "pic/bmon/kabutops.pic"
KabutopsPicBack::     INCBIN "pic/monback/kabutopsb.pic"
AerodactylPicFront::  INCBIN "pic/bmon/aerodactyl.pic"
AerodactylPicBack::   INCBIN "pic/monback/aerodactylb.pic"
SnorlaxPicFront::     INCBIN "pic/bmon/snorlax.pic"
SnorlaxPicBack::      INCBIN "pic/monback/snorlaxb.pic"
ArticunoPicFront::    INCBIN "pic/bmon/articuno.pic"
ArticunoPicBack::     INCBIN "pic/monback/articunob.pic"
ZapdosPicFront::      INCBIN "pic/bmon/zapdos.pic"
ZapdosPicBack::       INCBIN "pic/monback/zapdosb.pic"
MoltresPicFront::     INCBIN "pic/bmon/moltres.pic"
MoltresPicBack::      INCBIN "pic/monback/moltresb.pic"
DratiniPicFront::     INCBIN "pic/bmon/dratini.pic"
DratiniPicBack::      INCBIN "pic/monback/dratinib.pic"
DragonairPicFront::   INCBIN "pic/bmon/dragonair.pic"
DragonairPicBack::    INCBIN "pic/monback/dragonairb.pic"
DragonitePicFront::   INCBIN "pic/bmon/dragonite.pic"
DragonitePicBack::    INCBIN "pic/monback/dragoniteb.pic"
MewtwoPicFront::      INCBIN "pic/bmon/mewtwo.pic"
MewtwoPicBack::       INCBIN "pic/monback/mewtwob.pic"
MewPicFront::         INCBIN "pic/bmon/mew.pic"
MewPicBack::          INCBIN "pic/monback/mewb.pic"
LugiaPicFront::		  INCBIN "pic/bmon/lugia.pic"
LugiaPicBack::		  INCBIN "pic/monback/lugia.pic"
HoundourPicFront::    INCBIN "pic/bmon/houndour.pic"
HoundourPicBack::     INCBIN "pic/monback/houndour.pic"
HoundoomPicFront::    INCBIN "pic/bmon/houndoom.pic"
HoundoomPicBack::     INCBIN "pic/monback/houndoom.pic"
MurkrowPicFront::     INCBIN "pic/bmon/murkrow.pic"
MurkrowPicBack::      INCBIN "pic/monback/murkrow.pic"
HonchkrowPicFront::   INCBIN "pic/bmon/honchkrow.pic"
HonchkrowPicBack::    INCBIN "pic/monback/honchkrow.pic"
HeracrossPicFront::   INCBIN "pic/bmon/heracross.pic"
HeracrossPicBack::    INCBIN "pic/monback/heracross.pic"
EspeonPicFront::      INCBIN "pic/bmon/espeon.pic"
EspeonPicBack::       INCBIN "pic/monback/espeon.pic"
UmbreonPicFront::     INCBIN "pic/bmon/umbreon.pic"
UmbreonPicBack::      INCBIN "pic/monback/umbreon.pic"
GlaceonPicFront::     INCBIN "pic/bmon/glaceon.pic"
GlaceonPicBack::      INCBIN "pic/monback/glaceon.pic"
LeafeonPicFront::     INCBIN "pic/bmon/leafeon.pic"
LeafeonPicBack::      INCBIN "pic/monback/leafeon.pic"
SylveonPicFront::     INCBIN "pic/bmon/sylveon.pic"
SylveonPicBack::      INCBIN "pic/monback/sylveon.pic"
ScizorPicFront:       INCBIN "pic/bmon/scizor.pic"
ScizorPicBack:        INCBIN "pic/monback/scizor.pic"



SECTION "bank2F",ROMX,BANK[$2F]

TradingAnimationGraphics:
	INCBIN "gfx/game_boy.norepeat.2bpp"
	INCBIN "gfx/link_cable.2bpp"
TradingAnimationGraphicsEnd:

TradingAnimationGraphics2:
; Pokeball traveling through the link cable.
	INCBIN "gfx/trade2.2bpp"
TradingAnimationGraphics2End:

MissingnoPic::          INCBIN "pic/other/missingno.pic"

RedPicBack::            INCBIN "pic/trainer/redb.pic"
LeafPicBack::           INCBIN "pic/trainer/leafb.pic"
OldManPic::             INCBIN "pic/trainer/oldman.pic"

LeafFishingTilesFront:: INCBIN "gfx/leaf_fishing_tile_front.2bpp"
LeafFishingTilesBack::  INCBIN "gfx/leaf_fishing_tile_back.2bpp"
LeafFishingTilesSide::  INCBIN "gfx/leaf_fishing_tile_side.2bpp"

LyingOldManSprite:     INCBIN "gfx/sprites/lying_old_man.2bpp"
BoulderSprite:         INCBIN "gfx/sprites/boulder.2bpp"
PaperSheetSprite:      INCBIN "gfx/sprites/paper_sheet.2bpp"
BookMapDexSprite:      INCBIN "gfx/sprites/book_map_dex.2bpp"
ClipboardSprite:       INCBIN "gfx/sprites/clipboard.2bpp"
OldAmberSprite:        INCBIN "gfx/sprites/old_amber.2bpp"
PokedexSprite:         INCBIN "gfx/sprites/pokedex.2bpp"
TownMapSprite:         INCBIN "gfx/sprites/map_ow.2bpp"
BerryTreeSprite:       INCBIN "gfx/sprites/berry_tree.2bpp"
BagOverworldSprite:    INCBIN "gfx/sprites/bag.2bpp"
BallSprite:            INCBIN "gfx/sprites/ball.2bpp"
OmanyteSprite:         INCBIN "gfx/sprites/omanyte.2bpp"
FossilSprite:          INCBIN "gfx/sprites/fossil.2bpp"
SudowoodoSprite:       INCBIN "gfx/sprites/sudowoodo.2bpp"
SlowpokeOverworld:     INCBIN "gfx/sprites/pokey.2bpp"
DittoOverworld:        INCBIN "gfx/sprites/ditto.2bpp"
SnorlaxSprite:         INCBIN "gfx/sprites/snorlax.2bpp"
CelebiSprite:          INCBIN "gfx/sprites/celebi.2bpp"

SurfingPikachu:        INCBIN "gfx/sprites/surfing_pikachu.2bpp"
SeelSprite:            INCBIN "gfx/sprites/seel.2bpp"
SlowbroSprite:         INCBIN "gfx/sprites/slowbro.2bpp"

BirdSprite:            INCBIN "gfx/sprites/bird.2bpp"
ClefairySprite:        INCBIN "gfx/sprites/clefairy.2bpp"

BrockOverworld:        INCBIN "gfx/sprites/brock.2bpp"
MistyOverworld:        INCBIN "gfx/sprites/misty.2bpp"
SurgeOverworld:        INCBIN "gfx/sprites/surge.2bpp"
ErikaSprite:           INCBIN "gfx/sprites/erika.2bpp"
SabrinaOverworld:      INCBIN "gfx/sprites/sabrina.2bpp"
KogaOverworld:         INCBIN "gfx/sprites/koga.2bpp"
BlaineOverworld:       INCBIN "gfx/sprites/blaine.2bpp"
GiovanniSprite:        INCBIN "gfx/sprites/giovanni.2bpp"

BrendanOverworld:      INCBIN "gfx/sprites/brendan.2bpp"
FlanneryOverworld:     INCBIN "gfx/sprites/flannery.2bpp"
LookerOverworld:       INCBIN "gfx/sprites/tennant.2bpp"
GreeterWoman:          INCBIN "gfx/sprites/greeter_woman.2bpp"
SwimmerFSprite:        INCBIN "gfx/sprites/swimmer_f.2bpp"
OfficerJennySprite:    INCBIN "gfx/sprites/officer_jenny.2bpp"
JessieSprite:          INCBIN "gfx/sprites/jessie.2bpp"
JamesSprite:           INCBIN "gfx/sprites/james.2bpp"
HiroSprite:            INCBIN "gfx/sprites/hiro.2bpp"
KrisSprite:            INCBIN "gfx/sprites/kris.2bpp"
SilverSprite:          INCBIN "gfx/sprites/silver.2bpp"



SECTION "bank30",ROMX,BANK[$30]

BaseStats: INCLUDE "data/base_stats.asm"


SECTION "bank31",ROMX,BANK[$31]

SteelixPicFront:        INCBIN "pic/bmon/steelix.pic"
SteelixPicBack:         INCBIN "pic/monback/steelix.pic"
CrobatPicFront:         INCBIN "pic/bmon/crobat.pic"
CrobatPicBack:          INCBIN "pic/monback/crobat.pic"
PolitoedPicFront:       INCBIN "pic/bmon/politoed.pic"
PolitoedPicBack:        INCBIN "pic/monback/politoed.pic"
SlowkingPicFront:       INCBIN "pic/bmon/slowking.pic"
SlowkingPicBack:        INCBIN "pic/monback/slowking.pic"
BellossomPicFront:      INCBIN "pic/bmon/bellossom.pic"
BellossomPicBack:       INCBIN "pic/monback/bellossom.pic"
KingdraPicFront:        INCBIN "pic/bmon/kingdra.pic"
KingdraPicBack:         INCBIN "pic/monback/kingdra.pic"
BlisseyPicFront:        INCBIN "pic/bmon/blissey.pic"
BlisseyPicBack:         INCBIN "pic/monback/blissey.pic"
Porygon2PicFront:       INCBIN "pic/bmon/porygon2.pic"
Porygon2PicBack:        INCBIN "pic/monback/porygon2.pic"
PorygonZPicFront:       INCBIN "pic/bmon/porygonz.pic"
PorygonZPicBack:        INCBIN "pic/monback/porygonz.pic"
MagmortarPicFront:      INCBIN "pic/bmon/magmortar.pic"
MagmortarPicBack:       INCBIN "pic/monback/magmortar.pic"
ElectivirePicFront:     INCBIN "pic/bmon/electivire.pic"
ElectivirePicBack:      INCBIN "pic/monback/electivire.pic"
MagnezonePicFront:      INCBIN "pic/bmon/magnezone.pic"
MagnezonePicBack:       INCBIN "pic/monback/magnezone.pic"
RhyperiorPicFront:      INCBIN "pic/bmon/rhyperior.pic"
RhyperiorPicBack:       INCBIN "pic/monback/rhyperior.pic"
TangrowthPicFront:      INCBIN "pic/bmon/tangrowth.pic"
TangrowthPicBack:       INCBIN "pic/monback/tangrowth.pic"
LickilickyPicFront:     INCBIN "pic/bmon/lickilicky.pic"
LickilickyPicBack:      INCBIN "pic/monback/lickilicky.pic"
TogepiPicFront:         INCBIN "pic/bmon/togepi.pic"
TogepiPicBack:          INCBIN "pic/monback/togepi.pic"
TogeticPicFront:        INCBIN "pic/bmon/togetic.pic"
TogeticPicBack:         INCBIN "pic/monback/togetic.pic"
TogekissPicFront:       INCBIN "pic/bmon/togekiss.pic"
TogekissPicBack:        INCBIN "pic/monback/togekiss.pic"
SneaselPicFront:        INCBIN "pic/bmon/sneasel.pic"
SneaselPicBack:         INCBIN "pic/monback/sneasel.pic"
WeavilePicFront:        INCBIN "pic/bmon/weavile.pic"
WeavilePicBack:         INCBIN "pic/monback/weavile.pic"
SkarmoryPicFront:       INCBIN "pic/bmon/skarmory.pic"
SkarmoryPicBack:        INCBIN "pic/monback/skarmory.pic"
MisdreavusPicFront:     INCBIN "pic/bmon/misdreavus.pic"
MisdreavusPicBack:      INCBIN "pic/monback/misdreavus.pic"
MismagiusPicFront:      INCBIN "pic/bmon/mismagius.pic"
MismagiusPicBack:       INCBIN "pic/monback/mismagius.pic"
MiltankPicFront:        INCBIN "pic/bmon/miltank.pic"
MiltankPicBack:         INCBIN "pic/monback/miltank.pic"


;============================
; BANK $32 holds Pokedex text
;============================



SECTION "bank33",ROMX,BANK[$33]

ChinchouPicFront:       INCBIN "pic/bmon/chinchou.pic"
ChinchouPicBack:        INCBIN "pic/monback/chinchou.pic"
LanturnPicFront:        INCBIN "pic/bmon/lanturn.pic"
LanturnPicBack:         INCBIN "pic/monback/lanturn.pic"
SlugmaPicFront::   INCBIN "pic/bmon/slugma.pic"
SlugmaPicBack::    INCBIN "pic/monback/slugma.pic"
MagcargoPicFront:: INCBIN "pic/bmon/magcargo.pic"
MagcargoPicBack::  INCBIN "pic/monback/magcargo.pic"
TorkoalPicFront::  INCBIN "pic/bmon/torkoal.pic"
TorkoalPicBack::   INCBIN "pic/monback/torkoal.pic"
LatiasPicFront::   INCBIN "pic/bmon/latias.pic"
LatiasPicBack::    INCBIN "pic/monback/latias.pic"
LatiosPicFront::   INCBIN "pic/bmon/latios.pic"
LatiosPicBack::    INCBIN "pic/monback/latios.pic"
HitmontopPicFront:: INCBIN "pic/bmon/hitmontop.pic"
HitmontopPicBack::  INCBIN "pic/monback/hitmontop.pic"
TyroguePicFront::   INCBIN "pic/bmon/tyrogue.pic"
TyroguePicBack::    INCBIN "pic/monback/tyrogue.pic"
PichuPicFront::     INCBIN "pic/bmon/pichu.pic"
PichuPicBack::      INCBIN "pic/monback/pichu.pic"
CleffaPicFront::    INCBIN "pic/bmon/cleffa.pic"
CleffaPicBack::     INCBIN "pic/monback/cleffa.pic"
IgglybuffPicFront:: INCBIN "pic/bmon/igglybuff.pic"
IgglybuffPicBack::  INCBIN "pic/monback/igglybuff.pic"
SmoochumPicFront::  INCBIN "pic/bmon/smoochum.pic"
SmoochumPicBack::   INCBIN "pic/monback/smoochum.pic"
ElekidPicFront::    INCBIN "pic/bmon/elekid.pic"
ElekidPicBack::     INCBIN "pic/monback/elekid.pic"
MagbyPicFront::     INCBIN "pic/bmon/magby.pic"
MagbyPicBack::      INCBIN "pic/monback/magby.pic"
MimeJrPicFront::    INCBIN "pic/bmon/mime_jr.pic"
MimeJrPicBack::     INCBIN "pic/monback/mime_jr.pic"
HappinyPicFront::   INCBIN "pic/bmon/happiny.pic"
HappinyPicBack::    INCBIN "pic/monback/happiny.pic"
MunchlaxPicFront::  INCBIN "pic/bmon/munchlax.pic"
MunchlaxPicBack::   INCBIN "pic/monback/munchlax.pic"

WorldMapTileGraphics:
	INCBIN "gfx/town_map.2bpp"
WorldMapTileGraphicsEnd:

Mart_GFX:          INCBIN "gfx/tilesets/mart.2bpp"
Mart_Block:        INCBIN "gfx/blocksets/mart.bst"

SECTION "bank34",ROMX,BANK[$34]

; Mt Moon Square
INCLUDE "data/mapHeaders/MtMoonSquare.asm"
INCLUDE "scripts/MtMoonSquare.asm"
INCLUDE "data/mapObjects/MtMoonSquare.asm"
MtMoonSquareBlocks: INCBIN "maps/MtMoonSquare.blk"

; Mt Moon Shop
INCLUDE "data/mapHeaders/MtMoonShop.asm"
INCLUDE "scripts/MtMoonShop.asm"
INCLUDE "data/mapObjects/MtMoonShop.asm"
INCLUDE "data/martInventories/mt_moon_square.asm"
MtMoonShopBlocks: INCBIN "maps/MtMoonShop.blk"

; Vermilion Ferry Dock
INCLUDE "data/mapHeaders/VermilionFerryDock.asm"
INCLUDE "data/mapObjects/VermilionFerryDock.asm"
INCLUDE "scripts/VermilionFerryDock.asm"
NavelRockFerryBlocks:
VermilionFerryBlocks: INCBIN "maps/VermilionFerryDock.blk"

; Faraway Island (Outside)
INCLUDE "data/mapHeaders/FarawayIslandOutside.asm"
INCLUDE "data/mapObjects/FarawayIslandOutside.asm"
INCLUDE "scripts/FarawayIslandOutside.asm"
FarawayIslandOutsideBlocks: INCBIN "maps/FarawayIslandOutside.blk"

; Faraway Island (Inside)
INCLUDE "data/mapHeaders/FarawayIslandInside.asm"
INCLUDE "data/mapObjects/FarawayIslandInside.asm"
INCLUDE "scripts/FarawayIslandInside.asm"
FarawayIslandInsideBlocks: INCBIN "maps/FarawayIslandInside.blk"

; Southern Island (Outside)
INCLUDE "data/mapHeaders/SouthernIslandOutside.asm"
INCLUDE "data/mapObjects/SouthernIslandOutside.asm"
INCLUDE "scripts/SouthernIslandOutside.asm"
SouthernIslandOutsideBlocks: INCBIN "maps/SouthernIslandOutside.blk"

; Southern Island (Inside)
INCLUDE "data/mapHeaders/SouthernIslandInside.asm"
INCLUDE "data/mapObjects/SouthernIslandInside.asm"
INCLUDE "scripts/SouthernIslandInside.asm"
SouthernIslandInsideBlocks: INCBIN "maps/SouthernIslandInside.blk"

; Navel Rock Ferry Dock
INCLUDE "data/mapHeaders/NavelRockFerry.asm"
INCLUDE "data/mapObjects/NavelRockFerry.asm"
INCLUDE "scripts/NavelRockFerry.asm"
; uses same map as Vermilion Ferry Dock

; Navel Rock (Outside)
INCLUDE "data/mapHeaders/NavelRockOutside.asm"
INCLUDE "data/mapObjects/NavelRockOutside.asm"
INCLUDE "scripts/NavelRockOutside.asm"
NavelRockOutsideBlocks: INCBIN "maps/NavelRockOutside.blk"

; Navel Rock (Cave 1)
INCLUDE "data/mapHeaders/NavelRockCave1.asm"
INCLUDE "data/mapObjects/NavelRockCave1.asm"
INCLUDE "scripts/NavelRockCave1.asm"
NavelRockCave1Blocks: INCBIN "maps/NavelRockCave1.blk"

; Navel Rock (Cave 2)
INCLUDE "data/mapHeaders/NavelRockCave2.asm"
INCLUDE "data/mapObjects/NavelRockCave2.asm"
INCLUDE "scripts/NavelRockCave2.asm"
NavelRockCave2Blocks: INCBIN "maps/NavelRockCave2.blk"

; Navel Rock (Lugia Room)
INCLUDE "data/mapHeaders/NavelRockLugiaRoom.asm"
INCLUDE "data/mapObjects/NavelRockLugiaRoom.asm"
INCLUDE "scripts/NavelRockLugiaRoom.asm"
NavelRockLugiaRoomBlocks: INCBIN "maps/NavelRockLugiaRoom.blk"

; Inside Ferry
INCLUDE "data/mapHeaders/InsideFerry.asm"
INCLUDE "data/mapObjects/InsideFerry.asm"
INCLUDE "scripts/InsideFerry.asm"
InsideFerryBlocks: INCBIN "maps/InsideFerry.blk"

SECTION "pokecenters", ROMX,BANK[$35]

ViridianPokecenterBlocks:
CeladonPokecenterBlocks:
RockTunnelPokecenterBlocks:
MtMoonPokecenterBlocks:
SaffronPokecenterBlocks:
VermilionPokecenterBlocks:
LavenderPokecenterBlocks:
PewterPokecenterBlocks:
CeruleanPokecenterBlocks:
CinnabarPokecenterBlocks:
FuchsiaPokecenterBlocks:
	INCBIN "maps/Pokecenter.blk"

INCLUDE "data/mapHeaders/ViridianPokecenter.asm"
INCLUDE "scripts/ViridianPokecenter.asm"
INCLUDE "data/mapObjects/ViridianPokecenter.asm"

INCLUDE "data/mapHeaders/CeladonPokecenter.asm"
INCLUDE "scripts/CeladonPokecenter.asm"
INCLUDE "data/mapObjects/CeladonPokecenter.asm"

INCLUDE "data/mapHeaders/MtMoonPokecenter.asm"
INCLUDE "scripts/MtMoonPokecenter.asm"
INCLUDE "data/mapObjects/MtMoonPokecenter.asm"

INCLUDE "data/mapHeaders/RockTunnelPokecenter.asm"
INCLUDE "scripts/RockTunnelPokecenter.asm"
INCLUDE "data/mapObjects/RockTunnelPokecenter.asm"

INCLUDE "data/mapHeaders/PewterPokecenter.asm"
INCLUDE "scripts/PewterPokecenter.asm"
INCLUDE "data/mapObjects/PewterPokecenter.asm"

INCLUDE "data/mapHeaders/CeruleanPokecenter.asm"
INCLUDE "scripts/CeruleanPokecenter.asm"
INCLUDE "data/mapObjects/CeruleanPokecenter.asm"

INCLUDE "data/mapHeaders/LavenderPokecenter.asm"
INCLUDE "scripts/LavenderPokecenter.asm"
INCLUDE "data/mapObjects/LavenderPokecenter.asm"

INCLUDE "data/mapHeaders/VermilionPokecenter.asm"
INCLUDE "scripts/VermilionPokecenter.asm"
INCLUDE "data/mapObjects/VermilionPokecenter.asm"

INCLUDE "data/mapHeaders/SaffronPokecenter.asm"
INCLUDE "scripts/SaffronPokecenter.asm"
INCLUDE "data/mapObjects/SaffronPokecenter.asm"

INCLUDE "data/mapHeaders/FuchsiaPokecenter.asm"
INCLUDE "scripts/FuchsiaPokecenter.asm"
INCLUDE "data/mapObjects/FuchsiaPokecenter.asm"

INCLUDE "data/mapHeaders/CinnabarPokecenter.asm"
INCLUDE "scripts/CinnabarPokecenter.asm"
INCLUDE "data/mapObjects/CinnabarPokecenter.asm"

INCLUDE "data/mapHeaders/IndigoPlateauLobby.asm"
INCLUDE "scripts/IndigoPlateauLobby.asm"
INCLUDE "data/mapObjects/IndigoPlateauLobby.asm"
INCLUDE "data/martInventories/indigo_plateau.asm"
IndigoPlateauLobbyBlocks: INCBIN "maps/IndigoPlateauLobby.blk"


SECTION "bank36",ROMX,BANK[$36]

ForestGate_GFX:      INCBIN "gfx/tilesets/forest_gate.2bpp"
ForestGate_Block:    INCBIN "gfx/blocksets/forest_gate.bst"

Museum_GFX:          INCBIN "gfx/tilesets/museum.2bpp"
Museum_Block:        INCBIN "gfx/blocksets/museum.bst"

Safari_GFX:        INCBIN "gfx/tilesets/safari.2bpp"
Safari_Block:      INCBIN "gfx/blocksets/safari.bst"

Forest_GFX:        INCBIN "gfx/tilesets/forest.2bpp"
Forest_Block:      INCBIN "gfx/blocksets/forest.bst"


SECTION "bank37",ROMX,BANK[$37]

Overworld_GFX:     INCBIN "gfx/tilesets/overworld.2bpp"
Overworld_Block:   INCBIN "gfx/blocksets/overworld.bst"

Ferry_GFX:    INCBIN "gfx/tilesets/ferry.2bpp"
Ferry_Block:  INCBIN "gfx/blocksets/ferry.bst"

Ice_Cavern_GFX:    INCBIN "gfx/tilesets/ice_cavern.t14.2bpp"
Cavern_GFX:        INCBIN "gfx/tilesets/cavern.t14.2bpp"
Cavern_Block:      INCBIN "gfx/blocksets/cavern.bst"

INCLUDE "data/mapHeaders/BeachHouse.asm"
INCLUDE "scripts/BeachHouse.asm"
INCLUDE "data/mapObjects/BeachHouse.asm"
BeachHouseBlocks: INCBIN "maps/BeachHouse.blk"

SECTION "field moves", ROMX,BANK[$38]

INCLUDE "engine/overworld/field_moves.asm"
INCLUDE "engine/wonder_trade.asm"
INCLUDE "engine/overworld/automatic_repel.asm"
INCLUDE "scripts/DayCareManScript.asm"
INCLUDE "engine/overworld/ferry_script.asm"
INCLUDE "engine/battle/physical_special_split.asm"
INCLUDE "scripts/move_deleter.asm"
INCLUDE "scripts/move_relearner.asm"
INCLUDE "scripts/move_tutor.asm"

SECTION "trainer pics 2", ROMX,BANK[$39]

ProfOakPic::     INCBIN "pic/trainer/prof.oak.pic"
ExecutiveFPic::  INCBIN "pic/trainer/executivef.pic"
ExecutiveMPic::  INCBIN "pic/trainer/executivem.pic"
RockerFPic::     INCBIN "pic/trainer/rockerf.pic"
JessieJamesPic:: INCBIN "pic/trainer/jessiejames.pic"
CosplayGirlPic:: INCBIN "pic/trainer/cosplaygirl.pic"
JaninePic::      INCBIN "pic/trainer/janine.pic"
TraceyPic::      INCBIN "pic/trainer/tracey.pic"
PiTrainerPic::   INCBIN "pic/trainer/pi.pic"
HexManiacPic::   INCBIN "pic/trainer/hex_maniac.pic"
JessiePic::      INCBIN "pic/trainer/jessie.pic"
JamesPic::       INCBIN "pic/trainer/james.pic"
GiovanniGymPic:: INCBIN "pic/trainer/giovanni2.pic"

SECTION "random stuff", ROMX,BANK[$3A]
WindowsGraphics1:
	INCBIN "gfx/windows1.2bpp"
WindowsGraphics1End:
INCLUDE "engine/splashscreens/splashscreen_main.asm"
INCLUDE "engine/splashscreens/programmer.asm"
INCLUDE "engine/splashscreens/tetris.asm"
INCLUDE "engine/splashscreens/gamescript.asm"
INCLUDE "engine/splashscreens/mateo_presents.asm"
INCLUDE "engine/splashscreens/version_screen.asm"
INCLUDE "engine/splashscreens/players_in_intro.asm"

INCLUDE "engine/overworld/headbutt.asm"

SECTION "Trainer Parties", ROMX,BANK[$3B]
INCLUDE "engine/battle/read_trainer_party.asm"
INCLUDE "engine/overworld/advance_player_sprite.asm"
INCLUDE "engine/mon_gender.asm"
