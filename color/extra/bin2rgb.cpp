#include <fstream>
#include <cstdio>

using namespace std;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Specify a filename.\n");
        return 1;
    }
    ifstream in(argv[1], ios::binary);
    int count=0;
    for (;;) {
        unsigned char data[2];
        in.read((char*)data, 2);
        if (in.fail())
            break;
        if (count%4 == 0) {
            count = 0;
            printf("\n");
        }
        count++;
        int dat = data[0] | data[1]<<8;
        printf("\tRGB %d,%d,%d\n", dat&0x1f, (dat>>5)&0x1f, (dat>>10)&0x1f);
    }

    return 0;
}
