#include <iostream>

using namespace std;

extern "C" void * memset ( void *, int, size_t );

const int MAXN = 200;

int e[MAXN][MAXN];
int u[MAXN], pr[MAXN];
int m, n, k, t;

int dfs(int v)
{
    if (u[v]) return 0;
    u[v] = 1;
    for (int i = 0; i < m + k - n; ++i)
        if (e[v][i])
        {
            if (pr[i] < 0 || dfs(pr[i]))
            {
                pr[i] = v;
                return 1;
            }
        }
    return 0;
}

int main()
{
  freopen("c6.in", "rt", stdin);
  freopen("c6.out", "wt", stdout);
    cin >> m >> k >> n >> t;
    for (int i = 0; i < m+k-n; ++i)
        for (int j = 0; j < m+k-n; ++j)
            e[i][j] = 1;
    for (int i = m; i < m + k - n; ++i)
        for (int j = k; j < m + k - n; ++j)
            e[i][j] = 0;
    for (int i = 0; i < t; ++i)
    {
        int x, y;
        cin >> x >> y;
        x--; y--;
        y -=  m;
        e[x][y] = 0;
    }
    int q;
    cin >> q;
    for (int i = 0; i < q; ++i)
    {
        int x;
        cin >> x;
        x--;
        if (x < m)
            for (int i = k; i < m + k - n; ++i)
                e[x][i] = 0;
        else
            for (int i = m; i < m + k - n; ++i)
                e[i][x-m] = 0;
    }   
    for (int i = 0; i < m + k - n; ++i)
        pr[i] = -1;
    for (int i = 0; i < m + k - n; ++i)
    {
        memset(u, 0, sizeof(u));
        dfs(i);
    }
    int f = 1;
    for (int i = 0; i < m + k - n; ++i)
        f &= pr[i] >= 0;
    if (!f)
        cout << "NO\n";
    else
    {
        cout << "YES\n"; 
        for (int i = 0; i < k; ++i)
            if (pr[i] >= 0 && pr[i] < m)
                cout << pr[i] + 1 << ' ' << i + m + 1 << endl;
    }
    return 0;
}
