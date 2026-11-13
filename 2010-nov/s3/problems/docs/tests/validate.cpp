#include "testlib.h"

using namespace std;

int main()
{
    registerValidation();
    int n = inf.readInt(1,100000);
    inf.readEoln();

    for(int i=0; i<n; i++)
    {
        inf.readInt(1, (int)1e9);
        inf.readSpace();
        inf.readInt(1, (int)1e9);
        inf.readEoln();
    }

    int m = inf.readInt(1,100000);
    inf.readEoln();

    for(int i=0; i<m; i++)
    {
        inf.readInt(1, (int)1e9);
        inf.readSpace();
        inf.readInt(1, (int)1e9);
        inf.readEoln();
    }
}
