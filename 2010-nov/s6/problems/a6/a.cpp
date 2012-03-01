#include <fstream>
#include <cstdlib>
#include <cstdio>
using namespace std;

int Solve(int N) {
    int res = 0;
    while (N != 0) {
        res += (N + 1) / 2;
        N /= 4;
    }
    return res;
}

int main(void) {
    freopen ( "a.in", "rt", stdin );
    freopen ( "a.out", "wt", stdout );
    int n;
    scanf ( "%d", &n );
    printf ( "%d", Solve ( n ) );

    return 0;
}
