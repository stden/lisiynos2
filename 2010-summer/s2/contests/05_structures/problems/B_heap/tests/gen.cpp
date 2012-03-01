#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N (100000)

int main() {
	int added = 0;

	printf("%d\n", N);
	srand(time(NULL));

	for (int i = 0; i < N; i++) {
		if (rand() % 2) {
			printf("%d %d\n", 0, rand() % N);
			added++;
		} else {
			if (0 < added) {
				puts("1");
				added--;
			}
		}
	}
	return 0;
}
