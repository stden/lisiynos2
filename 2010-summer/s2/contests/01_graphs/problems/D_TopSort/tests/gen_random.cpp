#include <stdio.h>
#include <stdlib.h>

#define MAXN (100000)

int main(int argc, char** argv) {
	if (4 != argc) {
		printf("Usage:\n %s randseed N maxNum\n", argv[0]);
		return 1;
	}
	srand(atoi(argv[1]));
	int N = atoi(argv[2]);
	int maxNum = atoi(argv[3]);
	printf("%d %d\n", maxNum, N);
	for (int i = 0; i < N; i++) {
		printf("%d %d\n", rand() % maxNum + 1, rand() % maxNum + 1);
	}
	return 0;
}
