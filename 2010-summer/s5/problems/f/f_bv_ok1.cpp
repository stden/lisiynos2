// 2^{n + 1} profiles
// calcs p[][] using dp

#define _CRT_SECURE_NO_DEPRECATE

#include <iostream>
#include <algorithm>
#include <string>
#include <cstdio>

using namespace std;

const int nmax = 10;
const int mmax = 100;

int n, m, C;
int p[2 << nmax][2 << nmax];
int a[mmax + 1][2 << nmax];
int w[mmax + 1][2 << nmax];

bool swapped = false;

inline int I(int p, int i) { return ((p >> i) & 1); }
inline int O(int p, int i) { return 1 - I(p, i); }

extern "C" void * memset (void *, int, size_t);

int capacity(int p, int q)
{
    int a = 0, b = 0, c = 0;
    for (int k = 0; k < n; ++k)
    {
        int na = max(max(a*O(q, k), b*O(q, k)), c);
        int nb = (max(a, b) + 1) * O(p, k + 1)*I(q, k);
        int nc = (max(a*O(q, k), c) + 1) * O(p, k)*I(q, k + 1);
        a = na, b = nb, c = nc;
    }
    return max(max(a*O(q, n), b*O(q, n)), c);
}

inline int argmax(int a, int b) { return (b > a); }
inline int argmax(int a, int b, int c) { return (a >= max(b, c)) ? 0 : argmax(b, c) + 1; }

string line(int p, int q)
{
    static int a[nmax + 1], b[nmax + 1], c[nmax + 1];
    a[0] = b[0] = c[0] = 0;
    for (int k = 0; k < n; ++k)
    {
        a[k + 1] = max(max(a[k]*O(q, k), c[k]), b[k]*O(q, k));
        b[k + 1] = (max(a[k], b[k]) + 1) * O(p, k + 1)*I(q, k);
        c[k + 1] = (max(a[k]*O(q, k), c[k]) + 1) * O(p, k)*I(q, k + 1);
    }

    static char A[] = "./\\";
    string ret;
    int s = 0;
    for (int k = n; k >= 1; --k)
    {
        if (s == 1) s = argmax(a[k], b[k]); else
        if (s == 2) s = argmax(a[k]*O(q, k), -1, c[k]); else
            s = argmax(a[k]*O(q, k), b[k]*O(q, k), c[k]);

        ret = A[s] + ret;
    }
    return ret;
}

int main()
{
    freopen("f.in", "rt", stdin);
    freopen("f.out", "wt", stdout);

    cin >> n >> m;
    if (n > m) swap(n, m), swapped = true;
    C = (2 << n);

    for (int p1 = 0; p1 < C; ++p1)
        for (int p2 = 0; p2 < C; ++p2)
            p[p1][p2] = capacity(p1, p2);

    memset(a, 0, sizeof(a));
    for (int i = 1; i <= m; ++i)
    {
        for (int p1 = 0; p1 < C; ++p1)
            for (int p2 = 0; p2 < C; ++p2)
                if (a[i][p2] < a[i - 1][p1] + p[p1][p2])
                {
                    a[i][p2] = a[i - 1][p1] + p[p1][p2];
                    w[i][p2] = p1;
                }
    }

    int v = 0;
    for (int p1 = 1; p1 < C; ++p1)
        if (a[m][v] < a[m][p1]) v = p1;

    cout << a[m][v] << endl;

    string res[mmax + 1];
    for (int i = m; i >= 1; --i)
    {
        res[i] = line(w[i][v], v);
        v = w[i][v];
    }

    if (swapped)
        for (int i = 1; i <= m; ++i)
            cout << res[i] << endl;
    else
        for (int j = 0; j < n; ++j)
        {
            for (int i = 1; i <= m; ++i)
                cout << res[i][j];
            cout << endl;
        }

    return 0;
}
