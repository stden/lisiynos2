#include <cstdio>
#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <string>
#include <set>
#include <map>
#include <ctime>
#include <cstring>
#include <cassert>
#include <sstream>
#include <iomanip>
#include <complex>
#include <queue>
#include <functional>

using namespace std;

#define forn(i, n) for(int i = 0; i < (int)(n); i++)
#define ford(i, n) for(int i = (int)(n) - 1; i >= 0; i--)
#define pb push_back
#define mp make_pair
#define fs first
#define sc second
#define last(a) int(a.size() - 1)
#define all(a) a.begin(), a.end()
#define seta(a,x) memset (a, x, sizeof (a))
#define I (int)

typedef long long int64;
typedef pair <int, int> pii;
typedef long double ldb;

const long double eps = 1e-9;
const int inf = (1 << 30) - 1;
const int64 inf64 = ((int64)1 << 62) - 1;
const long double pi = 3.1415926535897932384626433832795;
const string task = "l";

template <class T> T sqr (T x) {return x * x;}

const int NMAX = 100;

struct rec
{
    int x, y, d;
    rec (int X = 0, int Y = 0, int D = 0) 
    {
        x = X;
        y = Y;
        d = D;
    }
};

short dx[4] = {1, -1, 0, 0};
short dy[4] = {0, 0, 1, -1};
int n, m, f[NMAX][NMAX], k, ans;
char a[NMAX][NMAX];
bool u[NMAX*NMAX];
short d[NMAX*NMAX];
rec q[NMAX*NMAX];
short qs[NMAX*NMAX];
vector <rec> A;
vector < vector <short> > e;


bool less1 (const rec &p1, const rec &p2)
{
    return p1.d < p2.d;
}

void paint (int x, int y, int md)
{
    int h, t;
    h = t = 0;
    q[0] = rec (x, y, 0);
    f[x][y] = k;
    while (h <= t)
    {
        rec v = q[h++];
        forn (i, 4)
        {
            rec w = v;
            w.x += dx[i];
            w.y += dy[i];
            if (w.x < 0 || w.x >= n || w.y < 0 || w.y >= m)
                continue;
            if (a[w.x][w.y] != a[v.x][v.y])
                w.d ++;
                if (w.d <= md && f[w.x][w.y] == -1)
                {
                    f[w.x][w.y] = k;
                    t ++;
                    q[t] = w;   
                }
        }
    }
    k ++;
}

int calc (short v)
{
    short h, t;
    h = t = 0;
    qs[0] = v;
    memset (d, 255, k*2);
    d[v] = 0;
    short res = 0;
    while (h <= t)
    {
        v = qs[h++];
        for (short i = 0; i < e[v].size(); i ++)
        {
            int w = e[v][i];
            if (d[w] == -1)
            {
                d[w] = d[v] + 1;
                qs[++t] = w;
                if (d[w] >= ans)
                    return ans;
                res = d[w];
                if (t == k - 1)
                    return res;
            }
        }
    }
}

int main ()
{
    freopen ((task + ".in").data(), "r", stdin);
    freopen ((task + ".out").data(), "w", stdout);
    scanf ("%d%d", &n, &m);
    forn (i, n)
        forn (j, m)
            scanf (" %c", &a[i][j]);
    k = 0;
    seta (f, 255);
    forn (i, n)
        forn (j, m)
            if (f[i][j] == -1)
                paint (i, j, 0);
    e.resize (k);
    forn (i, k)
        e[i].clear ();
    A.resize (n*m);
    forn (i, n)
        forn (j, m)
            A[i*m+j] = rec (i, j, abs (i - n/2) + abs (j - m/2));
    forn (i, n)
        forn (j, m)
            forn (w, 4)
                if (i+dx[w] >= 0 && i+dx[w] < n && j+dy[w] >= 0 && j+dy[w] < m && 
                    f[i+dx[w]][j+dy[w]] != f[i][j])
                    e[f[i][j]].pb (f[i+dx[w]][j+dy[w]]);
    forn (i, k)
    {
        sort (all (e[i]));
        e[i].resize (unique (all (e[i])) - e[i].begin());
    } 
    sort (all (A), less1);
    seta (u, 0);
    ans = (n+m);
    int it = 0;
    forn (i, A.size())
    {
        int v = f[A[i].x][A[i].y];
        if ((double)clock() > 1.7 * (double)CLOCKS_PER_SEC)
            break;
        if (u[v])
            continue;
        u[v] = 1;
        int w = calc (v);
        if (w < ans)
        {
            ans = w;
            it = clock();
        }
    }
    cout << ans << endl;
    return 0;
}
