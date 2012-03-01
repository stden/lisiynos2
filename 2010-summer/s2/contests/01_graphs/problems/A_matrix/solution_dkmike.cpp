#include <stdio.h>

const int MAXN = 110;

int N = 0;
int A[MAXN][MAXN] = {{0}};
int color[MAXN] = {0};
int c = 1;

void dfs(int v) {
	color[v] = c;
	for (int i = 0; i < N; i++) {
		if (!color[i] && A[v][i]) {
			dfs(i);
		}
	}
}

int main(void) {
	freopen("matrix.in", "rt", stdin);
	freopen("matrix.out", "wt", stdout);

	scanf("%d", &N);
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			scanf("%d", &A[i][j]);
		}
	}

	for (int i = 0; i < N; i++) {
		if (!color[i]) {
			c++;
			dfs(i);
		}
	}

	printf("%d", c - 1);

	return 0;
}
