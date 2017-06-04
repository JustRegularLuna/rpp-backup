# Pokémon Red++

This is based on the [**Pokémon Red Disassembly**][pokered]

Red++ serves as an updated version of Pokémon Red.

It fixes a lot of bugs leftover from original Red and Blue, as well as adding new features.
It builds two versions, a "Normal" version and a "Hard" version. The only difference is the level curve.

For a list of features, check out [**FEATURES.md**](FEATURES.md).

* To see a list of all Pokémon included, look [**here**](constants/pokemon_constants.asm).
* To see Pokémon skill sets and evolutions, look [**here**](data/evos_moves.asm).
* To see what the TMs/HMs teach, and where to find them, look [**here**](data/tms.asm).
* To see a list of Move Tutor moves, and where to find them, look [**here**](data/move_tutors.asm)
* To see Pokémon base stats, which TMs and which Move Tutors they learn, look [**here**](data/baseStats/).


## Frequently Asked Questions

### Q: How do you play this in color?
A: In VBA, go to Options -> Gameboy and set it to "Automatic", then close and re-open the emulator for the change to take effect. If you're playing on a mobile emulator, chances are good that if it doesn't automatically play in color, your emulator doesn't support Super Gameboy mode, which this hack currently uses for color.

### Q: Are all Pokémon available?
A: Yes, all Pokémon included in the game are available.

### Q: Which Pokémon are in Wonder Trade?
A: Every Pokémon that isn't legendary can appear in Wonder Trade, but it varies with the level of the Pokémon you put in.

### Q: How do you get Dive?
A: Dive is not available because the functionality hasn't been added yet.

### Q: Where is the Move Deleter?
A: The house between Fuchsia City's Gym and Pokémon Center.

### Q: Where is the Move Relearner?
A: Same house as the Move Deleter.

### Q: Where do I find Shiny Pokémon?
A: There are no event shinies, but all Pokémon have the same chance to be shiny as in Gen 2. Also, breeding at the Daycare is slightly more likely, due to the Day Care Man's Ditto being shiny.

### Q: Is Fairy type in this?
A: Yes, Dark Steel and Fairy are all in, and type strengths/weaknesses match Gen 6.

### Q: Can I go to Johto?
A: There is only Kanto for now.

### Q: Will you add so-and-so feature?
A: Maybe!



## Setting up your own version

To set up the repository, see [**INSTALL.md**](INSTALL.md).
It is advisable to check the main Pokered repository as well for more info.



## See also

* Disassembly of [**Pokémon Crystal**][pokecrystal]
* irc: **irc.freenode.net** [**#pret**][irc]

[pokered]: http://github.com/pret/pokered
[pokecrystal]: https://github.com/kanzure/pokecrystal
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
