#define _CRT_SECURE_NO_DEPRECATE

#include <cstdio>
#include <cassert>
#include <cstring>

int main()
{
	freopen("c.in", "rt", stdin);
	freopen("c.out", "wt", stdout);

	int n;
	scanf("%d", &n);
	assert(n >= 1 && n <= 10000);
	int m = 0, p , r = 3, power = 1;
	for (p = 1;;p++)
	{
		int q = power*10 - ((p == 1) ? 4 : power);
		if (m + q*p >= n) break;
		m += p*q;
		r += q;
		power *= 10;
    }
    printf("%d\n", r + (n - m)/p);

  	return 0;
}
