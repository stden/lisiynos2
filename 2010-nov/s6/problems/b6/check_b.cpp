#pragma comment (linker, "/STACK:64000000")

#define NOFOOTER
#define EJUDGE
#include <climits>
#include <string>
#include "testlib.h"

using namespace std;

const int NMAX = 500;
const int INF = INT_MAX / 3;

int main(int argc, char *argv[])
{
    registerTestlibCmd(argc, argv);

    int a[NMAX][NMAX], b[NMAX][NMAX];
    int n, m;

    n = inf.readInt();
    m = inf.readInt();
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
        {
            a[i][j] = inf.readInt();
            b[i][j] = INF;
        }

    for (int i = 0; i < n; i++)
        b[i][i] = 0;

    string jOk = ans.readWord();
    string pOk = ouf.readWord();

    if (pOk == "NO")
    {
        if (jOk == "NO")
            quitf(_ok, "The graph does not exist");
        else if (jOk == "YES")
            quitf(_wa, "The graph exists but was not found");
        else
            quitf(_fail, "YES or NO expected while %s found in jury answer", jOk.data());
    }

    if (pOk != "YES")
        quitf(_wa, "YES or NO expected while %s was found", pOk.data());

    for (int i = 0; i < m; i++)
    {
        int x = ouf.readInt(1, n);
        int y = ouf.readInt(1, n);
        int d = ouf.readInt(1, 1000000);

        if (x == y)
            quitf(_wa, "Loop found: %d %d %d", x, y, d);
        
        if (b[x - 1][y - 1] < INF)
            quitf(_wa, "Multiple edges found: %d %d", x, y);

        b[x - 1][y - 1] = d;
        b[y - 1][x - 1] = d;
    }

    for (int k = 0; k < n; k++)
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                if (b[i][j] > b[i][k] + b[k][j])
                    b[i][j] = b[i][k] + b[k][j];
    
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if (a[i][j] != b[i][j])
                quitf(_wa, "Found graph does not correspond to the shortest path matrix");

    if (jOk == "NO")
        quitf(_fail, "The graph exists but was not found by jury");

    quitf(_ok, "The graph exists");

    return 0;   
}
