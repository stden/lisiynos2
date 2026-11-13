#include <stdio.h>
#include <string.h>

const int maxn = 1000100;

char s[maxn];
int pi[maxn+2];

void Pi(char * s, int * pi, int size) {
   int i, k;   
   k = pi[0] = 0;
   for( i = 1; i < size; i++ ) {
      while( k && s[i] != s[k] ) 
         k = pi[k-1];

      if( s[i] == s[k] ) k++;
      pi[i] = k;
   }      
}

int main(void) {

	freopen("pi.in", "r", stdin);
	freopen("pi.out", "w", stdout);

	gets(s);

	int n = strlen(s);
	Pi(s, pi, n);

	for (int i = 0; i < n; i++) {
		printf("%d ", pi[i]);
	}

	return 0;
}