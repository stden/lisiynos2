#include <fstream.h>
#include <string.h>

int main(void)
{
ifstream in("g.in");
ofstream out("g.out");

int n,k,i,yn,kol=0;
in >>n>>k;
int y[20];
for(i=0;i<20;i++)y[i]=0;
y[n-1]=1;
while(y[n]==0){
yn=1;
for(i=1;i<n && yn;i++)if (y[i]==0 && y[i-1]==0) yn=0;
if (yn) kol++;
y[0]=y[0]+1;
for(i=0;i<n;i++){
	if(y[i]>=k){
		y[i+1]=y[i+1]+1;
		y[i]=y[i]-k;
	}
}

}
out<<kol;
in.close();
out.close();
return 0;
}