#include <stdio.h>
#include <stdlib.h>

#define MAXN (100000)

const int maxn = 110;
int a[maxn][maxn];

int main(int argc, char** argv) {
	if (4 != argc) {
		printf("Usage:\n %s randseed N maxNum\n", argv[0]);
		return 1;
	}
	srand(atoi(argv[1]));
	int N = atoi(argv[2]);
	int M = atoi(argv[3]);
	printf("%d\n", N);
	int k = 0;
	int i,j;
	while (k<M)
	{
	  for (i=0;i<N;i++)
	    for (j=i+1;j<N;j++)
	     if (!a[i][j] && !rand()%7 && k<M)
	     {
	       a[i][j] = a[j][i] = 1;
	       k++;
	     }                
	}
	for (i=0;i<N;i++)
	 {
	    printf("%d",a[i][0]);
	 	for (j=1;j<N;j++)        
	 	  printf(" %d",a[i][j]);
	 	printf("\n");
	 }
	return 0;
}
