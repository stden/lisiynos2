// xxx.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h"
#include <fstream.h>
#include <stdio.h>
int main(void)
{
	ifstream in("c.in");
	ofstream out("c.out");
	int n,i,j;
	in>>n;
	++n;
   	__int64 b[41];
	for(i=0;i<n;i++)b[i]=0;
	b[0]=1;
	for(i=0;i<n;i++)
	{
	   for(j=1;j<4&&(i+j)<n;j++)
	   {
	     b[i+j]=b[i]+b[i+j]; 
	   }
	}
	
	long double bb = b[n-1];
	char buf[1024];
	sprintf(buf,"%0.0Lf",bb);
	out << buf;		
	in.close();out.close();
	return 0;
}
