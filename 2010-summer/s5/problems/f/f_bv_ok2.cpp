// 8119 profiles
// calcs p[][] using backtracking

#define _CRT_SECURE_NO_DEPRECATE

#include <iostream>
#include <algorithm>
#include <string>
#include <cstdio>

using namespace std;

const int nmax = 10;
const int mmax = 100;
const int Cmax = 8119;
const int Pmax = 4000000;

int n, m, C, P;
int a[nmax + 1], b[nmax + 1], c[nmax + 1];
int p[Pmax];
int v[Pmax];
int f[Cmax];

int dp[mmax][Cmax];
int w[mmax][Cmax];

bool swapped = false;

inline int I(int p, int i) { return ((p >> i) & 1); }
inline int O(int p, int i) { return 1 - I(p, i); }

extern "C" void * memset (void *, int, size_t);

string line(int p)
{
    string r;
    for (int i = n; i > 0; --i)
    {
        if (p >= a[i] + b[i])
        {
            r = '\\' + r;
            p -= (a[i] + b[i]);
            if (p >= a[i - 1]) p += b[i - 1];
        }
        else
            if (p >= a[i]) r = '/' + r, p -= a[i];
            else r = '.' + r;
    }
    return r;
}

void go ( int p, int q, int i, int v, int last )
{
    for (; i <= n; ++i, last = 0)
    {
        if ( last != 2 && O ( p, i ) )
            go ( p, q + a[i], i + 1, v + 1, 1 );
        if ( last != 1 && O ( p, i - 1 ) )
            go ( p, q + a[i] + b[i] - (last == 2)*b[i - 1], i + 1, v + 1, 2 );
    }
    ::p[P] = q;
    ::v[P++] = v;
}

int main()
{
    freopen("f.in", "rt", stdin);
    freopen("f.out", "wt", stdout);

    cin >> n >> m;
    if (n > m) swap(n, m), swapped = true;

    a[0] = 1, b[0] = c[0] = 0;
    for (int k = 0; k < n; ++k)
    {
        a[k + 1] = a[k] + b[k] + c[k];
        b[k + 1] = a[k] + b[k];
        c[k + 1] = a[k] + c[k];
    }
    C = a[n] + b[n] + c[n];
    P = 0;
    memset(dp, 0, sizeof(dp));

    for (int p1 = 0; p1 < C; ++p1)
    {
        string s = line(p1);
        int mask = 0;
        dp[0][p1] = 0;
        for (int i = n - 1; i >= 0; --i)
        {
            mask <<= 1;
            if (s[i] == '\\') mask |= 2, dp[0][p1]++;
            if (s[i] == '/') mask |= 1, dp[0][p1]++;
        }

        go(mask, 0, 1, 0, 0);
        f[p1] = P;
    }

    cerr << "P = " << P << endl;

    for (int i = 1; i < m; ++i)
    {
        int p1 = 0;
        for (int j = 0; j < P; ++j)
        {
            while (f[p1] == j) p1++;
            if (dp[i][p[j]] < dp[i - 1][p1] + v[j])
            {
                dp[i][p[j]] = dp[i - 1][p1] + v[j];
                w[i][p[j]] = p1;
            }
        }
    }

    int v = 0;
    for (int p1 = 1; p1 < C; ++p1)
        if (dp[m - 1][v] < dp[m - 1][p1]) v = p1;

    cout << dp[m - 1][v] << endl;

    string res[mmax];
    for (int i = m - 1; i >= 0; --i)
    {
        res[i] = line(v);
        v = w[i][v];
    }

    if (swapped)
        for (int i = 0; i < m; ++i)
            cout << res[i] << endl;
    else
        for (int j = 0; j < n; ++j)
        {
            for (int i = 0; i < m; ++i)
                cout << res[i][j];
            cout << endl;
        }

    return 0;
}
