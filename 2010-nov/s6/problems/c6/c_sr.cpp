#include <cstdio>
#include <iostream>
#include <cmath>
#include <algorithm>
#include <string>
#include <cstring>

using namespace std;

#define forn(i, n) for(int i = 0; i < (int)(n); i++)
#define seta(a,x) memset (a, x, sizeof (a))

const string task = "c";

int n, m, k;
bool a[200][200], u[200];
int ma[200];

bool dfs (int v)
{
    if (u[v])
        return 0;
        u[v] = 1;
        forn (i, n+m-k)
            if (a[v][i])
                if (ma[i] == -1 || dfs (ma[i]))
                {
                    ma[i] = v;
                    return 1;
                }
        return 0;
}

int main ()
{
    if (task != "")
    {
        freopen ((task + ".in").data(), "r", stdin);
        freopen ((task + ".out").data(), "w", stdout);
    }
    seta (a, 0);
    scanf ("%d%d%d", &n, &m, &k);
    for (int i = 0; i < n + m - k; i ++)
        for (int j = 0; j < n + m - k; j ++)
            a[i][j] = 1;
    for (int i = n; i < n + m - k; i ++)
        for (int j = m; j < n + m - k; j ++)
            a[i][j] = 0;
    int t;
    scanf ("%d", &t);
    forn (i, t)
    {
        int x, y;
        scanf ("%d%d", &x, &y);
        x --;
        y --;
        if (x > y)
            swap (x, y);
        a[x][y-n] = 0;
    }
    scanf ("%d", &t);
    forn (i, t)
    {
        int x;
        scanf ("%d", &x);
        x --;
        if (x < n)
            for (int j = m; j < n + m - k; j ++)
                a[x][j] = 0;
        else
            for (int j = n; j < n + m - k; j ++)
                a[j][x-n] = 0;
    }
    seta (ma, 255);
    bool ok = 1;
    forn (i, n+m-k)
    {
        seta (u, 0);
        if (!dfs (i))
            ok = 0;
    }
    if (!ok)
        printf ("NO\n");
    else
    {
        printf ("YES\n");
        forn (i, m)
            if (ma[i] < n)
                printf ("%d %d\n", ma[i]+1, i+n+1);
    }   
    return 0;
}
