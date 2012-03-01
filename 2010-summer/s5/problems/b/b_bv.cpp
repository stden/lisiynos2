#define _CRT_SECURE_NO_DEPRECATE

#include <cstdio>
#include <cassert>

const int n = 31;
const int k = 4;

int main()
{
	freopen("b.in", "rt", stdin);
	freopen("b.out", "wt", stdout);

	int x, s = 0;
	for (int i = 0; i < n; ++i)
	{
		scanf("%d", &x);
		s += x;
	}
	assert(s % (n - k) == 0);
	assert(s / (n - k) >= 1);
    printf("%d\n", s / (n - k));

    return 0;
}
