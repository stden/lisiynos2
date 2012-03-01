#include <cstdio>

const int INF = 1 << 29;

const int N = 901;
const int W = 31;
const int H = 31;

int t[H][W];
int a[2][N][W][W];
int b[2][N][W][W];

int main()
{
    freopen("j.in", "r", stdin);
    freopen("j.out", "w", stdout);

    int n, w, h;

    scanf("%d%d%d", &n, &h, &w);

    int i, j, k, l, len, i1, i2;

    for (i = h - 1; i >= 0; --i)
        for (j = 0; j < w; ++j)
            scanf("%d", &t[i][j]);

    for (int i = 0; i < 2; ++i)
        for (int j = n; j >= 0; --j)
            for (int k = w - 1; k >= 0; --k)
                for (int l = w - 1; l >= 0; --l)
                    a[i][j][k][l] = b[i][j][k][l] = -INF;

    for (i = w - 1; i >= 0; --i)
        b[0][0][i][i] = 0;

    int res = 0;

    int tmp1, tmp2;

    for (i = 1, i1 = i & 1, i2 = i1 ^ 1; i <= h; ++i)
    {
        for (j = n; j > 0; --j)
            for (k = w-1; k >= 0; --k)
                a[i1][j][k][k] = b[i2][j-1][k][k] + t[i-1][k];

        for (len = 1; len < w; ++len)
            for (j = n; j > 0; --j)
                for (l = w - 1, k = l - len; k >= 0; --k, --l)
                {
                    tmp1 = a[i1][j-1][k+1][l] + t[i-1][k];
                    tmp2 = a[i1][j-1][k][l-1] + t[i-1][l];
                    if (tmp1 < tmp2)
                        tmp1 = tmp2;
                    a[i1][j][k][l] = tmp1;
                }

        for (len = w - 1; len >= 0; --len)
            for (j = n; j >= 0; --j)
                for (l = w - 1, k = l - len; k >= 0; --k, --l)
                {
                    tmp1 = a[i1][j][k][l];
                    if (res < tmp1)
                        res = tmp1;

                    if (k != 0)
                    {
                        tmp2 = b[i1][j][k-1][l];
                        if (tmp1 < tmp2)
                            tmp1 = tmp2;
                    }
                    if (l != w - 1)
                    { 
                        tmp2 = b[i1][j][k][l+1];
                        if (tmp1 < tmp2)
                            tmp1 = tmp2;
                    }   

                    b[i1][j][k][l] = tmp1;
                }

        i1 ^= i2 ^= i1 ^= i2;
    }

    printf("%d\n", res);

    return 0;
}