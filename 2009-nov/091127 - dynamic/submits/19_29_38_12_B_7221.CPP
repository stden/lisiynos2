#include <fstream.h>
#include <string.h>

int main(void)
{
ifstream in("a.in");
ofstream out("a.out");

long int a,b;
in >>a;

if (a<=2)
{
	b=1;
	out<<b;
}
else
{
	int i,j;
	int yn=1;
	int m[200],n[200],ml=1,nl=1;
	
	for(i=0;i<200;i++)m[i]=0;
	for(i=0;i<200;i++)n[i]=0;
	m[0]=1;
	n[0]=1;

	for(i=2;i<a;i++)
	{
		if(yn){
			for(j=0;j<200;j++){
				m[j]=m[j]+n[j];
				if(m[j]>9){
					m[j+1]=m[j+1]+(m[j]/10);
					m[j]=m[j]%10;
				}
			}
		}else{
			for(j=0;j<200;j++){
				n[j]=n[j]+m[j];
				if(n[j]>9){
					n[j+1]=n[j+1]+(n[j]/10);
					n[j]=n[j]%10;
				}
			}		
		}
		if(yn) yn=0; else yn=1;
	}

	if(yn){
	i=200;
	do i--; while (n[i]==0);
	for(j=i;j>=0;j--)out << n[j];
	}
	else{
	i=200;
	do i--; while (m[i]==0);
	for(j=i;j>=0;j--)out << m[j];
	}


}

in.close();
out.close();
return 0;
}