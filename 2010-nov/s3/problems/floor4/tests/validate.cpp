#include "testlib.h"

using namespace std;

vector<bool> used;

int main()
{
    registerValidation();
    int n = inf.readInt(1,100000);
    used.resize(200000);
    inf.readEoln();

    for(int i=0; i<n; i++)
    {
      int a = inf.readInt();
      inf.readEoln();
      if (a > 0) ensure(a <= 100000);
      else
      {
        ensure(a < 0);
        ensure(a >= -200000);
      }
    }
    inf.readEof();
}
