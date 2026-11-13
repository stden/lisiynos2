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
	int m = 0, p;
    for (p = 4; m < n; p++)
    {
    	static char s[10];
        sprintf(s, "%d", p);
        m += (int)strlen(s);
    }
    assert(m == n);
    printf("%d\n", p - 1);

  	return 0;
}
