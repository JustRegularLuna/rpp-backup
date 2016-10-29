# FEATURES
There are a number of different types of updates that have been included so far.
This list is not necessarily complete, but it gives a good list and will be updated semi-regularly

## BUGFIXES
These are notable bugs from original Red that have been fixed

* Frozen Pokémon can thaw naturally, or if they use a move that thaws the user as part of its effect
* Waking up does not waste your entire turn
* Critical Hit and Focus Energy code ported from Pokémon Crystal
* Fixed Missingno. Glitch
* Counter can hit any Physical attack, not just any Normal or Fighting attack
* All attacks should have their Gen 6 typing and Base Power, almost all have Gen 6 effect
* Fixed type strength/weakness issues
* Fixed-Damage moves no longer ignore type immunity
* Swift can no longer hit during the "invulnerable" turn of an attack
* No more "Gen 1 Missing" (aka 100% Accuracy moves no longer accidentally have a 1/256 chance of missing)
* Pokémon do not skip learning a move if they gain enough EXP to skip over that level
* Pokémon can be assigned to learn more than one move per level
* Not necessarily a bug, but Old Rod can catch more than just Magikarp
* No NPCs making impossible claims about Pokémon evolving
* Fixed the bug where Item Evolutions can happen accidentally by level-up
* Changed Struggle to be ???-Type so nothing can be immune to it
* Player turns to face an enemy trainer, like in every game except Red and FireRed
* Defeating a Pokémon does not negate the need for HyperBeam to recharge
* Breaking a substitute doesn't negate HyperBeam, SelfDestruct/Explosion effects
* Dual-Type Pokemon do not display an incorrect message if hit by a move that is Super Effective against one type and Not Very Effective against the other
* Some Bide issues
* Sleep moves do not ignore accuracy and other status conditions when opponent needs to recharge
* Fixed Psywave desync glitch in link battles
* No healing moves failing on 255 or 511 HP
* No more permanent invincibility if fully paralyzed/hurt by confusion while using Dig or Fly
* Fixed Reflect/Lightscreen stat overflow bug
* Rest gets rid of Bad Poison
* Defense cannot become 0 after stat scaling
* Mirror Move/Partial Trapping move desync glitch fixed
* Substitute no longer kills the user if they have exactly 25% HP
* More


## NEW FEATURES
These are notable features which have been added

* Gender selection (Red or Leaf)
* Running Shoes (2x faster than walking)
* Faster Surfing(2x faster than walking)
* Faster Bicycle(4x faster than walking)
* Updated graphics
* Physical/Special Split
* Dark, Steel, and Fairy types
* Several new Pokémon (NO FAKEMON)
* Several new moves from newer generations
* New evolution methods added
* Updated move pools for all Pokémon, inspired by XY/ORAS (not exact)
* Berry Trees (working off of a step counter)
* Option to choose (during the intro) how traded Pokémon behave
* New trainer classes added
* Trainers have individual names
* Animated EXP Bar in battle
* Caught indicator icon for Wild Pokémon
* EXP Share functions like Gen 6 (But is NOT given at the start of the game)
* BW/2 Repel System
* Pack holds 30 items instead of 20
* HM Moves usable without manually selecting them from the party menu
* Ability to use Headbutt outside of Battle, like GSC or HGSS
* Flash is a TM instead of an HM
* New areas in Kanto
* Navel Rock, Faraway Island, and Southern Island from Pokémon Emerald are all included
* Breeding at the Day-Care
* Offline Wonder Trade (Similar to Pokémon Christmas)
* Smarter AI for Boss trainers (Normal Patch) or All Trainers (Hard Patch)
* Item Descriptions in Mart and bag menus
* Move Relearner
* Move Tutors
* Move Deleter
* Shiny Pokémon (same chances as Polished Crystal)
* Pokémon have genders
* Chain-Fishing for Shinies
* More


## BEHIND-THE-SCENES FEATURES
These are probably only interesting to people wanting to use this as a baserom

* Pokémon IDs sorted by Pokédex Number internally
* Trainer sprite and AI no longer forced to be the same for every trainer within a class
* Trainer classes do not all have the same DVs
* Trainers can have individually assigned DVs for certain Pokemon, ie Lance has a shiny Dragonite
* New more flexible (and more readable) format for giving trainers' Pokémon custom movesets
* Variable overworld sprite IDs, like Gen 2 has
* Trainer sprites can be stored in any Rombank
* Town Map is no longer RLE encoded, uses the more flexible Gen 2 format (a standard tilemap)
* Removed this weird unnecessary duplicate check causing some trainer class names to be listed twice
* Fixed an oversight causing things that weren't Items to accidentally show up with a TM/HM name 
* More
