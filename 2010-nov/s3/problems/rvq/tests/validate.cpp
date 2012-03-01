#include "testlib.h"

using namespace std;

int main()
{
    registerValidation();
    int k = inf.readInt(1,100000);
    inf.readEoln();

    for(int i=0; i<k; i++)
    {
        int x = inf.readInt();
        inf.readSpace();
        int y = inf.readInt();
        inf.readEoln();

        ensure(abs(x) > 0 && abs(x) <= 100000);
        ensure(abs(y) > 0 && abs(y) <= 100000);

        if (x > 0) 
            ensure( y >= x);
    }
    inf.readEof();
}
