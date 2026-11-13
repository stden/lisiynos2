#include <stdio.h>

const int maxn = 100;

int A[maxn+2];

int main(void) {

	freopen("nim.in", "r", stdin);
	freopen("nim.out", "w", stdout);

	int n;

	scanf("%d", &n);

	int t = 0;

	for (int i = 0; i < n; i++) {
		scanf("%d", A+i);
		t = t ^ (A[i]);
	}

	if (t == 0) 
		printf("Second\n");
	else
		printf("First\n");

	return 0;
}
