// xxx.cpp : Defines the entry point for the console application.
//#include "stdafx.h"
#include <fstream.h>
int main(void)
{
	ifstream in("roman.in");
	ofstream out("roman.out");
	int t;
	in>>t;	
	int i,j,k=0;
 	char *m1[10]={"","I","II","III","IV","V","VI","VII","VIII","IX"};
	char *m2[10]={"","X","XX","XXX","XL","L","LX","LXX","LXXX","XC"};
	char *m3[10]={"","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"};
	char *m4[4]={"","M","MM","MMM"};				
	int mass[4];
	for(i=0;i<t;i++)	
	{		
		in>>k;
		for(j=3;j>=0;j--)
			mass[j]=k%10,k=k/10;	
		out<<m4[mass[0]];
		out<<m3[mass[1]];
		out<<m2[mass[2]];
		out<<m1[mass[3]]<<endl;
	}	
	out.close();in.close();
	return 0;
}
