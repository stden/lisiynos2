#include <fstream.h>
#include <stdio.h>
#include <string.h> 

int main(void)
{
ifstream in ("light.in");
ofstream out("light.out");

int n,m,i,j;
in >>n>>m;
int a[101];
for(i=0;i<=100;i++)a[i]=0;

for(i=0;i<m;i++){
	in>>j;
	a[j]=a[j]+1;
	in>>j;
	a[j]=a[j]+1;
}
for(i=1;i<=n;i++)out<<a[i]<<" ";
in.close();
out.close();
return 0;
}
