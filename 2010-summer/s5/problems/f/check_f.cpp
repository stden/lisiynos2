#define _CRT_SECURE_NO_DEPRECATE
#define NOFOOTER
#include "testlib.h"

#include <string>

using namespace std;

void check(bool v)
{
    if (!v) quit(_fail, "check error");
}

const int mmax = 100;

int a[mmax + 1][mmax + 1];
int n, m, k;

int main(int argc, char ** argv)
{
    registerTestlibCmd(argc, argv);
    n = inf.readInt();
    m = inf.readInt();
    check(n*m >= 1 && n*m <= 100);
    k = ouf.readInt();
    if (!ouf.seekEoln()) quitf(_pe, "extra infomation at %d line", 1);
    memset(a, 0, sizeof(a));
    int count = 0;
    for (int i = 0; i < n; ++i)
    {
        string s = ouf.readString();
        if ((int)s.length() != m) quitf(_pe, "extra infomation at %d line: #%s#", i + 2, s.c_str());
        for (int j = 0; j < m; ++j)
        {
            if (s[j] != '.') count++;
            if (s[j] == '\\') a[i][j]++, a[i + 1][j + 1]++; else
            if (s[j] == '/') a[i + 1][j]++, a[i][j + 1]++; else
            if (s[j] != '.') quitf(_wa, "wrong symbols in output file, %d line", i + 2);
        }
    }

    for (int i = 0; i <= n; ++i)
        for (int j = 0; j <= m; ++j)
            if (a[i][j] > 1) quit(_wa, "wrong table");

    if (count != k) quit(_wa, "table does not correspond to answer in output file");
    k = ans.readInt();
    if (k > count) quit(_wa, "jury has better solution");
    if (k < count) quit(_fail, "contestant has better solution than jury");
    quitf(_ok, "%d", k);

    return 0;   
}
