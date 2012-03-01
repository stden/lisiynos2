#define _CRT_SECURE_NO_DEPRECATE

#include <cstdio>
#include <cassert>

using namespace std;

int main()
{
	freopen("a.in", "rt", stdin);
	freopen("a.out", "wt", stdout);

	int k;
	scanf("%d", &k);
	assert(k >= 1 && k <= 100);
    if (k <= 2) printf("%d\n", k);
    else printf("%d\n", 3*(k - 2));
    
	return 0;
}
