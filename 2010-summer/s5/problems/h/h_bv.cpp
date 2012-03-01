#define _CRT_SECURE_NO_DEPRECATE

#include <cstdio>
#include <cassert>
#include <algorithm>

using namespace std;

int power ( int & n, int d )
{
    int r = 0;
    while ( n % d == 0 ) n /= d, r++;
    return r;
}

double fpow ( double a, int c )
{
    double ret = 1;
    while ( c > 0 ) ret *= a, c--;
    return ret;
}

int main()
{
    freopen ( "h.in", "rt", stdin );
    freopen ( "h.out", "wt", stdout );

    int a, n;
    scanf ( "%d%d", &a, &n );
    assert ( 1 <= a && a <= 1000000000 && 1 <= n && n <= 1000000000 );
    int r = 0, index = 0;
    int b = a, k, s;
    for ( int d = 2; n > 1; ++d )
    {
        if ( d*d > n && n > 1 ) d = n;
        if ( ( k = power ( n, d ) ) != 0 )
        {
            if ( ( s = power ( b, d ) ) == 0 ) goto end;
            r = max ( k / s + ( k % s != 0 ), r );
        }
    }

    index++;
    for (double c = 1; c + 1e-9 < r; index++ )
        c = fpow ( a, (int)c );

    end:
    printf ( "%d\n", index );

    return 0;
}
