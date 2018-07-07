# Pokémon Red++

This is based on the [**Pokémon Red Disassembly**][pokered]

Red++ serves as an updated version of Pokémon Red.

It fixes a lot of bugs leftover from original Red and Blue, as well as adding new features.
It builds two versions, a "Normal" version and a "Hard" version. The only difference is the level curve.
By default, it builds the Hard rom. To build the Normal rom, go to [constants.asm](constants.asm) and comment out the line it tells you to at the top.

For a list of features, check out [**FEATURES.md**](FEATURES.md).

* To see a list of all Pokémon included, look [**here**](constants/pokemon_constants.asm).
* To see Pokémon skill sets and evolutions, look [**here**](data/evos_moves.asm).
* To see what the TMs/HMs teach, and where to find them, look [**here**](data/tms.asm).
* To see a list of Move Tutor moves, and where to find them, look [**here**](data/move_tutors.asm)
* To see Pokémon base stats, which TMs and which Move Tutors they learn, look [**here**](data/baseStats/).
* To see which Pokémon are found in the wild in each area, look [**here**](data/wildPokemon/).


## Frequently Asked Questions

### Q: How do you play this in color?
A: If you build the current copy yourself, it is already in Full Color. For the current stable release (v2.4.2), however: In VBA, go to Options -> Gameboy and set it to "Automatic", then close and re-open the emulator for the change to take effect. If you're playing on a mobile emulator, chances are good that if it doesn't automatically play in color, your emulator doesn't support Super Gameboy mode, which this hack currently uses for color.

### Q: Are all Pokémon available?
A: Yes, all 205 Pokémon that are included in the game are available without needing to trade with another person or abusing Wonder Trade.

### Q: Which Pokémon are in Wonder Trade?
A: Every Pokémon that isn't legendary can appear in Wonder Trade, but you will only find Pokémon that can legally exist at the same level as the one you offered for the trade.

### Q: How do you get Dive?
A: Dive is not available because the functionality hasn't been added yet.

### Q: Where is the Move Deleter?
A: The house between Fuchsia City's Gym and Pokémon Center.

### Q: Where is the Move Relearner?
A: Same house as the Move Deleter.

### Q: Where do I find Shiny Pokémon?
A: The only "Event Shiny" for now is the Magikarp you buy in the Mt. Moon Pokécenter, but all other Pokémon have the same chance to be shiny as in [**Polished Crystal v2**][polished]. Also, breeding at the Daycare is slightly more likely, due to the Day Care Man's Ditto being shiny.

### Q: Is Fairy type in this?
A: Yes, Dark Steel and Fairy are all in, and type strengths/weaknesses match Gen 6.

### Q: Can I go to Johto?
A: There is only Kanto for now. Johto is part of the ongoing copy of v3 in the main repo.

### Q: Will you add so-and-so feature?
A: Maybe!


For help, questions, or to generally keep up with development, check out the [**Lunaverse Discord**][lunaverse].



## Setting up your own version

To set up the repository, see [**INSTALL.md**](INSTALL.md). This way you can build the latest dev version for yourself, or use it as a starting point for your own hack.
It is advisable to check the main Pokered repository as well for more info.

After setting up the repository, you'll want to download the current release of [**Polished Map**][polishedmap] by Rangi if you want to edit maps.



## See also

* Disassembly of [**Pokémon Yellow**][pokeyellow]
* Disassembly of [**Pokémon Crystal**][pokecrystal]
* Disassembly of [**Pokémon Pinball**][pokepinball]
* Disassembly of [**Pokémon TCG**][poketcg]
* Disassembly of [**Pokémon Ruby**][pokeruby]
* Disassembly of [**Pokémon Emerald**][pokeemerald]
* Discord: [**pret**][Discord]
* irc: **irc.freenode.net** [**#pret**][irc]

[polished]: http://github.com/roukaour/polishedcrystal
[polishedmap]: https://github.com/roukaour/polished-map
[pokered]: http://github.com/pret/pokered
[pokeyellow]: https://github.com/pret/pokeyellow
[pokecrystal]: https://github.com/pret/pokecrystal
[pokepinball]: https://github.com/pret/pokepinball
[poketcg]: https://github.com/pret/poketcg
[pokeruby]: https://github.com/pret/pokeruby
[pokeemerald]: https://github.com/pret/pokeemerald
[Discord]: https://discord.gg/cJxDDVP
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
[lunaverse]: https://discord.gg/SQwkd7r
