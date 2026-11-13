/******************************************************************************
 * This algorithm calculate Z-function of                                     *
 * given string                                                               *
 ******************************************************************************/

#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))

const int maxn = 1000100;

char s[maxn];
int z[maxn+2];

void Z(char * s, int * z, int size) {   
   int i, l = 0, r = 0;
   
   for( i = 1; i < size; i++ ) {
      z[i] = r < i ? 0 : min(z[i-l], r+1-i);
      while( s[z[i]] == s[i+z[i]] )
         z[i]++;
  
      if( z[i] + i - 1 > r ) {
         r = i + z[i] - 1;
         l = i;
      }
   }
}

int main(void) {

	freopen("z.in", "r", stdin);
	freopen("z.out", "w", stdout);

	gets(s);

	int n = strlen(s);
	Z(s, z, n);

	for (int i = 1; i < n; i++) {
		printf("%d ", z[i]);
	}

	return 0;
}
