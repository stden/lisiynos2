#include <fstream.h>
#include <stdio.h>
#include <string.h> 

int main(void)
{
ifstream in ("color.in");
ofstream out("color.out");

int n,i,j;
in >>n;
int a[100][100]; //!!!!!!!!!!!!!!!!!
int c[100];     //!!!!!!!!!!!!!!!!
for(i=0;i<n;i++){
	for(j=0;j<n;j++){
		in>>a[i][j];
	}
}

for(i=0;i<n;i++)in >>c[i];

unsigned long kol=0;
for(i=0;i<n;i++){
	for(j=0;j<n;j++){
		if(a[i][j]==1){
			if(c[i]!=c[j])kol++;
		}
	}
}
out<<kol/2;
in.close();
out.close();
return 0;
}