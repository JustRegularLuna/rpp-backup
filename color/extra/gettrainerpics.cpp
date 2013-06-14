// Used this on Danny's gen II graphics patch to extract trainer images.
// It's not perfect and sometimes dumps a bit extra.
// I think this only happens to lance, and the old man.
#include <cstdio>
#include <algorithm>

using namespace std;

const char* names[] = {
"youngster",
"bugcatcher",
"lass",
"sailor",
"jr.trainerm",
"jr.trainerf",
"pokemaniac",
"supernerd",
"hiker",
"biker",
"burglar",
"engineer",
"juggler",
"fisher",
"swimmer",
"cueball",
"gambler",
"beauty",
"psychic",
"rocker",
"juggler",
"tamer",
"birdkeeper",
"blackbelt",
"rival1",
"prof.oak",
"chief",
"scientist",
"giovanni",
"rocket",
"cooltrainerm",
"cooltrainerf",
"bruno",
"brock",
"misty",
"lt.surge",
"erika",
"koga",
"blaine",
"sabrina",
"gentleman",
"rival2",
"rival3",
"lorelei",
"channeler",
"agatha",
"lance",
"redb",
"oldman"
};

const int numTrainers=49;

unsigned char rom[0x40*0x4000];

struct Trainer {
    int frontPicAddr;
    int backPicAddr;
    int name;
};

bool sortFunc(Trainer m1, Trainer m2) {
    return m1.frontPicAddr < m2.frontPicAddr;
}

Trainer trainers[numTrainers];
int start, end;
void getStartAndEnd(int s, int e) {
    start = s;
    end = e;

    if (end/0x4000 != start/0x4000 || start > end)
        end = (start/0x4000+1)*0x4000;

}

void loadTrainer(int i, int addr, bank) {
    trainers[i].frontPicAddr = addr-0x4000 + bank*0x4000;
    trainers[i].name = i;
}

int main(int argc, char* argv[]) {
    FILE* file = fopen(argv[1], "r");
    fread(rom, 1, 0x4000*0x40, file);
    fclose(file);

    int statOffs = 0x39914;
    for (int i=0; i<47; i++) {
        loadTrainer(i, rom[statOffs] | rom[statOffs+1]<<8, 0x13);
        statOffs += 5;
    }
    statOffs = 0x3ec97;
    loadTrainer(47, rom[statOffs] | rom[statOffs+1]<<8, 0xc);
    statOffs = 0x3ec9c;
    loadTrainer(48, rom[statOffs] | rom[statOffs+1]<<8, 0xc);

    sort(trainers, trainers+numTrainers, sortFunc);

    char filename[100];
    for (int i=0; i<numTrainers; i++) {
        getStartAndEnd(trainers[i].frontPicAddr, trainers[i+1].frontPicAddr);
        sprintf(filename, "../../pic/gstrainer/%s.pic", names[trainers[i].name]);
        printf("%x:%s\n", trainers[i].frontPicAddr, names[trainers[i].name]);
        FILE* out = fopen(filename, "w");
        fwrite(rom+start, 1, end-start, out);
        fclose(out);
    }
}
