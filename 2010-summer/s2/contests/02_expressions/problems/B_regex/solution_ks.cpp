#include <stdio.h>

const int maxn = 101;

int n, m;
char S[maxn+2], T[maxn+2];
int d[maxn][maxn];

int main(void) {

	freopen("regex.in", "r", stdin);
	freopen("regex.out", "w", stdout);

	scanf("%d%d\n", &n, &m);

	scanf("%s\n", S);
	scanf("%s", T);

	d[0][0] = 1;
	if( T[0] == '*' )
		d[0][1] = 1;

	for( int i = 1; i <= n; i++ ) {
		for( int j = 1; j <= m; j++ ) {
			if( S[i-1] == T[j-1] ) 
				d[i][j] = d[i-1][j-1];
			
			if( T[j-1] == '*' ) 
				d[i][j] = d[i-1][j] || d[i-1][j-1] || d[i][j-1];			
//			printf("%d", d[i][j]);
		}
//		printf("\n");
	}

   if( d[n][m] )
   	printf("YES\n"); 
   else
   	printf("NO\n");

	return 0;
}