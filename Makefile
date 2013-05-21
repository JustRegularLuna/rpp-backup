.SUFFIXES: .asm .tx .o .gbc

ASMFILES = constants.asm color/loadpalettes.asm color/refreshmaps.asm color/sprites.asm
TEXTFILES =	text/oakspeech.tx text/pokedex.tx text/mapRedsHouse1F.tx \
		text/mapBluesHouse.tx text/mapPalletTown.tx

all: pokered.gbc

pokered.o: pokered.asm main.tx ${ASMFILES} ${TEXTFILES}
	rgbasm -o pokered.o pokered.asm
	
pokeblue.o: pokeblue.asm main.tx ${ASMFILES} ${TEXTFILES}
	rgbasm -o pokeblue.o pokeblue.asm

redrle: extras/redrle.c
	${CC} -o $@ $>

.asm.tx:
	python2 textpre.py < $< > $@

pokered.gbc: pokered.o
	rgblink -o $@ $*.o
	rgbfix -Cjsv -k 01 -l 0x33 -m 0x13 -p 0 -r 03 -t "POKEMON RED" $@
#	cmp baserom.gbc $@
	
pokeblue.gbc: pokeblue.o
	rgblink -o $@ $*.o
	rgbfix -Cjsv -k 01 -l 0x33 -m 0x13 -p 0 -r 03 -t "POKEMON BLUE" $@
#	cmp blue.gbc $@

clean:
	rm -f main.tx pokered.o pokered.gbc pokeblue.o pokeblue.gbc redrle ${TEXTFILES}

more: pokered.gbc pokeblue.gbc

run:
	wine ~/bgb/bgb.exe pokered.gbc
