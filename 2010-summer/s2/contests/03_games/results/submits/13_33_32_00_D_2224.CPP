#include <stdio.h>

int main(void) {
	freopen("nim.in", "r", stdin);
	freopen("nim.out", "w", stdout);
	int n;
	scanf("%d", &n);
	int t = 0, tt;
	for (int i = 0; i < n; i++) {
		scanf("%d", &tt);
		t = t ^ tt;
	}

	printf("%s\n", t == 0 ? "Second" : "First");
	return 0;
}
