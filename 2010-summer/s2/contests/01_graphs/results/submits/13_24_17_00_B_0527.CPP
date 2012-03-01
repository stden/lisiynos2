#include <stdio.h>

const int MAXN = 110;
int a[MAXN][MAXN];
bool was[MAXN];
int n, count = 0;
int edgCnt = 0;


void rec(int q)
{
	was[q]=true;
	int i;
	for (i=0;i<n;i++)
		if (a[q][i] && !was[i]) rec(i);
}                 

int main()
{
	freopen("tree.in","r",stdin);
	freopen("tree.out","w",stdout);
	scanf("%d",&n);
	int i,j;
	for (i=0;i<n;i++)
	  for (j=0;j<n;j++)
	  {
	     scanf("%d",&a[i][j]);
	     if (a[i][j]) edgCnt++;
	  }
	for (i=0;i<n;i++)
		if (!was[i])
		{
			count++;
			rec(i);
		}
	if ((edgCnt/2 == n - 1) && count == 1) printf("YES");
	else printf("NO");
	return 0;           
}