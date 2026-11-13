
#include <fstream.h>
#include <string.h>

int main(void)
{
ifstream in("d.in");
ofstream out("d.out");

int n,i,j;
int s[50][50];
int g[50][50];
in >>n;
for(i=0;i<n;i++)
for(j=0;j<n;j++)
{
	in >>s[i][j];
	if((i==(n-1))||(j==(n-1)))g[i][j]=s[i][j]; else	g[i][j]=0;
}
for(j=n-2;j>=0;j--)g[j][n-1]=g[j+1][n-1]+s[j][n-1];
for(j=n-2;j>=0;j--)g[n-1][j]=g[n-1][j+1]+s[n-1][j];

for(j=n-2;j>=0;j--)
for(i=n-2;i>=0;i--)
{
	if(g[i+1][j]>g[i][j+1])g[i][j]=s[i][j]+g[i+1][j]; else g[i][j]=s[i][j]+g[i][j+1];
}

out<<g[0][0];

in.close();
out.close();
return 0;
}