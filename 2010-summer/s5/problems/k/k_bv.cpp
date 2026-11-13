#define _CRT_SECURE_NO_DEPRECATE

#include <algorithm>
#include <cassert>
#include <cstdio>

using namespace std;

const int nmax = 100001;

char p[2*nmax + 1];
int z[2*nmax];
int n;

extern "C" size_t strlen ( const char * );

int main()
{
    freopen ( "k.in", "rt", stdin );
    freopen ( "k.out", "wt", stdout );

    scanf ( "%s", p );
    n = (int)strlen ( p );
    scanf ( "%s", p + n );
    assert ( 2*n == (int)strlen ( p ) );

    z[0] = 2*n;
    int l = -1, r = -1;
    for ( int i = 1; i < 2*n; ++i )
    {
        z[i] = max ( min ( z[i - l], r - i ), 0 );
        if ( i + z[i] >= r )
        {
            while ( p[i + z[i]] == p[z[i]] ) z[i]++;
            l = i, r = l + z[l];
        }
    }

    int res = n;
    for ( int i = n; i < 2*n; ++i )
        if ( i + z[i] == 2*n )
        {
            res = i - n;
            break;
        }

    printf ( "%d", res );

    return 0;
}
