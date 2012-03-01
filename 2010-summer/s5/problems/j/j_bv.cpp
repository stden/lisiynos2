// w^2*h*n

#define _CRT_SECURE_NO_DEPRECATE

#include <algorithm>
#include <cassert>
#include <cstdio>

using namespace std;

const int wmax = 31;
const int hmax = 31;
const int nmax = 901;
const int inf = (int)2e+9;

int w, h, n, t;
int a[hmax][wmax];
int Bp[wmax][wmax][nmax];
int B[wmax][wmax][nmax];

extern "C" void * memset ( void *, int, size_t );
extern "C" void * memcpy ( void *, const void *, size_t );

int getB ( int i, int j, int m )
{
    if ( i < 0 || j > w || i >= j || m < j - i ) return -inf;
    if ( Bp[i][j][m] != -1 ) return Bp[i][j][m];
    int & r = Bp[i][j][m];
    r = max ( getB ( i - 1, j, m ), getB ( i, j + 1, m ) );
    r = max ( r, B[i][j][m - j + i] + a[t][j] - a[t][i] );
    return r;
}

int main()
{
    freopen ( "j.in", "rt", stdin );
    freopen ( "j.out", "wt", stdout );
    
    scanf ( "%d%d%d", &n, &h, &w );
    assert ( 0 < n && n < nmax && 0 < w && w < wmax && 0 < h && h < hmax && n <= w*h );
    for ( int i = h - 1; i >= 0; --i )
    {
        a[i][0] = 0;
        for ( int j = 1; j <= w; ++j )
        {
            scanf ( "%d", &a[i][j] );
            assert ( 1 <= a[i][j] && a[i][j] <= 100000 );
            a[i][j] += a[i][j - 1];
        }
    }
    
    int ans = 0;
    memset ( B, 0, sizeof ( B ) );

    for ( t = 0; t < h; ++t )
    {
        memset ( Bp, -1, sizeof ( Bp ) );
        for ( int i = 0; i < w; ++i )
            for ( int m = 0; m <= n; ++m )
                ans = max ( ans, getB ( i, i + 1, m ) );

        for ( int i = 0; i < w; ++i )
            for ( int j = i; j <= w; ++j )
                for ( int m = 0; m <= n; ++m )
                {
                    B[i][j][m] = (i == j) ? -inf : max ( B[i][j - 1][m], Bp[j - 1][j][m] );
                    if ( B[i][j][m] < 0 ) B[i][j][m] = -inf;
                }
    }

    printf ( "%d", ans );

    return 0;
}
