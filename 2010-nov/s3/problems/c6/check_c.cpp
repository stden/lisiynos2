#define _CRT_SECURE_NO_DEPRECATE
#define NOFOOTER

#include "testlib.h"
#include <string>

using namespace std;

const int MAXN = 202;

void check(bool v)
{
    if (!v) quit(_fail, "check error");
}

int main(int argc, char ** argv)
{
    registerTestlibCmd(argc, argv);
    int n = inf.readInt();
    int m = inf.readInt();
    int k = inf.readInt();
    check(1 <= n && 1 <= m && n+m <= 200 && k <= n && k <= m && k >= 0);
    int a[MAXN][MAXN] = {0};
    int b[MAXN] = {0};
    int t = inf.readInt();
    for (int i = 0; i < t; ++i)
    {
        int x = inf.readInt();
        int y = inf.readInt();
        check(1 <= x && x <= n && n+1 <= y && y <= n+m);
        check(a[x][y] == 0);
        
        a[x][y] = 1;
    }
    int q = inf.readInt();
    for (int i = 0; i < q; ++i)
    {
        int x = inf.readInt();
        check(1 <= x && x <= n+m && b[x] == 0);
        b[x] = 1;
    }
    string s = ouf.readString();
    if (s != "YES" && s != "NO") quit(_wa, "First line contains trash.");
    string ss = ans.readString();
    if (ss == "NO") 
        if (s == "NO") quit(_ok, "Impossible.");
        else quit(_wa, "NO expected.");
    if ( s == "NO" ) quit ( _wa, "YES expected." );
    for (int i = 0; i < k; ++i)
    {
        int x = ouf.readInt();
        int y = ouf.readInt();
        if (x < 1 || x > n || y <= n || y > n+m) quit(_wa, "Wrong numbered dragons.");
        if (a[x][y]) quit(_wa, "Dragons conflict!");
        if (b[x] == 2 || b[y] == 2) quit(_wa, "Some dragon lives in two aquariums!");
        b[x] = 2;
        b[y] = 2;
    }
    for (int i = 1; i <= n+m; ++i)
        if (b[i] == 1) quit(_wa, "Ronery dragon is ronery!");
    quit(_ok, "OK");
    
    return 0;
}
