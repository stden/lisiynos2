#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	if (2 != argc) {
		printf("Usage:\n %s N\n", argv[0]);
		return 1;
	}
	int N = atoi(argv[1]);
	printf("%d %d\n", N + 1, N);
	for (int i = 0; i < N; i++) {
		printf("%d %d\n", i + 1, i + 2);
	}
	return 0;
}
