#include <stdio.h>

const int MAXN = 110;
int a[MAXN][MAXN];
bool was[MAXN];
int n, count = 0;


void rec(int q)
{
	was[q]=true;
	int i;
	for (i=0;i<n;i++)
		if (a[q][i] && !was[i]) rec(i);
}                 

int main()
{
	freopen("matrix.in","r",stdin);
	freopen("matrix.out","w",stdout);
	scanf("%d",&n);
	int i,j;
	for (i=0;i<n;i++)
	  for (j=0;j<n;j++)
	   scanf("%d",&a[i][j]);
	for (i=0;i<n;i++)
		if (!was[i])
		{
			count++;
			rec(i);
		}
	printf("%d",count);
	fclose(stdin);
	fclose(stdout);
	return 0;           
}
