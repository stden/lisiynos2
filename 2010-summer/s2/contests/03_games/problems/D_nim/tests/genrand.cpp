#include <stdio.h>
#include <stdlib.h>

const int maxn = 100;

int main(int argc, char ** argv) {
    
    int n;
    int parity;
    int A[maxn];

    srand(239239);

    if (argc < 3) return 0;

    n = atoi(argv[1]);
    parity = atoi(argv[2]);

    printf("%d\n", n);

    for (int i = 0; i < n + parity; i++) {
    	rand();
    }

    int t = 0;

    for (int i = 0; i < n; i++) {
        do {
        	A[i] = rand() & 1023;
        } while(A[i] == 0);

        t = t ^ A[i];
    }

    if (parity == 1) {
    	do {
    		t = t ^ A[n-1];
        	A[n-1] = rand() & 1023;
        	t = t ^ A[n-1];
        } while(t == 0);
    } else {
    	t = t ^ A[n-1];
    	A[n-1] = t;    	
    }

    for (int i = 0; i < n; i++) {
    	printf("%d ", A[i]);
    }
    
    return 0;
}
