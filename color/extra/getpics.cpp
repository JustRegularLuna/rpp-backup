// Used this on Danny's gen II graphics patch to extract pokemon images.
// It's not perfect and sometimes dumps a bit extra.
#include <cstdio>
#include <algorithm>

using namespace std;

const char* names[] = {
"bulbasaur",
"ivysaur",
"venusaur",
"charmander",
"charmeleon",
"charizard",
"squirtle",
"wartortle",
"blastoise",
"caterpie",
"metapod",
"butterfree",
"weedle",
"kakuna",
"beedrill",
"pidgey",
"pidgeotto",
"pidgeot",
"rattata",
"raticate",
"spearow",
"fearow",
"ekans",
"arbok",
"pikachu",
"raichu",
"sandshrew",
"sandslash",
"nidoranf",
"nidorina",
"nidoqueen",
"nidoranm",
"nidorino",
"nidoking",
"clefairy",
"clefable",
"vulpix",
"ninetales",
"jigglypuff",
"wigglytuff",
"zubat",
"golbat",
"oddish",
"gloom",
"vileplume",
"paras",
"parasect",
"venonat",
"venomoth",
"diglett",
"dugtrio",
"meowth",
"persian",
"psyduck",
"golduck",
"mankey",
"primeape",
"growlithe",
"arcanine",
"poliwag",
"poliwhirl",
"poliwrath",
"abra",
"kadabra",
"alakazam",
"machop",
"machoke",
"machamp",
"bellsprout",
"weepinbell",
"victreebel",
"tentacool",
"tentacruel",
"geodude",
"graveler",
"golem",
"ponyta",
"rapidash",
"slowpoke",
"slowbro",
"magnemite",
"magneton",
"farfetchd",
"doduo",
"dodrio",
"seel",
"dewgong",
"grimer",
"muk",
"shellder",
"cloyster",
"gastly",
"haunter",
"gengar",
"onix",
"drowzee",
"hypno",
"krabby",
"kingler",
"voltorb",
"electrode",
"exeggcute",
"exeggutor",
"cubone",
"marowak",
"hitmonlee",
"hitmonchan",
"lickitung",
"koffing",
"weezing",
"rhyhorn",
"rhydon",
"chansey",
"tangela",
"kangaskhan",
"horsea",
"seadra",
"goldeen",
"seaking",
"staryu",
"starmie",
"mr.mime",
"scyther",
"jynx",
"electabuzz",
"magmar",
"pinsir",
"tauros",
"magikarp",
"gyarados",
"lapras",
"ditto",
"eevee",
"vaporeon",
"jolteon",
"flareon",
"porygon",
"omanyte",
"omastar",
"kabuto",
"kabutops",
"aerodactyl",
"snorlax",
"articuno",
"zapdos",
"moltres",
"dratini",
"dragonair",
"dragonite",
"mewtwo",
"mew"
};


unsigned char rom[0x40*0x4000];

struct Mon {
    int frontPicAddr;
    int backPicAddr;
    int name;
};

bool sortFunc(Mon m1, Mon m2) {
    return m1.frontPicAddr < m2.frontPicAddr;
}

Mon mons[151];
int start, end;
void getStartAndEnd(int s, int e) {
    start = s;
    end = e;

    if (end/0x4000 != start/0x4000 || start > end)
        end = (start/0x4000+1)*0x4000;

    int bank = start/0x4000;

    if (start/0x4000 == 0x9 && start%0x4000 < 0x3d6b && end%0x4000 > 0x3d6b)
        end = 0x9*0x4000+0x3d6b;
    else if (start/0x4000 == 0xa && start%0x4000 < 0x3ea9 && end%0x4000 > 0x3ea9)
        end = 0xa*0x4000+0x3ea9;
    else if (start/0x4000 == 0xb && start%0x4000 < 0x3b7b && end%0x4000 > 0x3b7b)
        end = 0xb*0x4000+0x3b7b;
    else if (start/0x4000 == 0xc && start%0x4000 < 0x3f2b && end%0x4000 > 0x3f2b)
        end = 0xc*0x4000+0x3f2b;
    else if (start/0x4000 == 0xd && start%0x4000 < 0x3244 && end%0x4000 > 0x3244)
        end = 0xd*0x4000+0x3244;
    else if (start/0x4000 == 0x2f) // Mew
        end = 0x2f*0x4000+0x3244;

    else if (bank == 0x2d && end >= 0xb7e86)
        end = 0xb7e86;
    else if (bank == 0x2e && end >= 0xb99da)
        end = 0xb99da;
}

void loadMon(int i, int statOffs) {
    mons[i].frontPicAddr = rom[statOffs+11] | rom[statOffs+12]<<8;
    mons[i].frontPicAddr = mons[i].frontPicAddr-0x4000 + rom[statOffs+0x1b]*0x4000;
    mons[i].name = i;

    mons[i].backPicAddr = rom[statOffs+13] | rom[statOffs+14]<<8;
    mons[i].backPicAddr = mons[i].backPicAddr-0x4000 + rom[statOffs+0x1b]*0x4000;
}

int main(int argc, char* argv[]) {
    FILE* file = fopen(argv[1], "r");
    fread(rom, 1, 0x4000*0x40, file);
    fclose(file);

    int statOffs = 0x03de + 0x4000*0xe;
    for (int i=0; i<150; i++) {
        loadMon(i, statOffs);
        statOffs += 0x1c;
    }
    loadMon(150, 0x425b); // Mew

    sort(mons, mons+151, sortFunc);

    char filename[100];
    for (int i=0; i<151; i++) {
        // Front
        getStartAndEnd(mons[i].frontPicAddr, mons[i].backPicAddr);
        sprintf(filename, "../../pic/gsmon/%s.pic", names[mons[i].name]);
        FILE* out = fopen(filename, "w");
        fwrite(rom+start, 1, end-start, out);
        fclose(out);
        // Back
        if (i == 150) // Mew
            getStartAndEnd(mons[i].backPicAddr, 0xb99da);
        else
            getStartAndEnd(mons[i].backPicAddr, mons[i+1].frontPicAddr);
        sprintf(filename, "../../pic/gsmonback/%sb.pic", names[mons[i].name]);
        out = fopen(filename, "w");
        fwrite(rom+start, 1, end-start, out);
        fclose(out);
        if (i == 150)
            printf("%s, addr %x/%x\n", names[mons[i].name], mons[i].frontPicAddr, mons[i].backPicAddr);
    }
}
