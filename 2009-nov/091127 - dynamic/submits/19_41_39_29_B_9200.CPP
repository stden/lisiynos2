// xxx.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h"
#include <fstream.h>
#include <math.h>
#include <stdlib.h>

int main(void)
{
	ifstream in("b.in");
	ofstream out("b.out");
	int a[15],c[15],b[15],n;
	int i,j;
	in>>n;	
	if(n==1||n==2){out<<1;return 0;}	
	for(i=0;i<15;i++)
	{
	  a[i]=b[i]=c[i]=0;
	}
	a[0]=b[0]=1;
	
	for(i=2;i<n;i++)
	{
	   for(j=0;j<15;j++)
	   {
		c[j]=(a[j]+b[j]);
        a[j]=b[j]; 
	    b[j]=c[j];
	   }
	   
	   for(j=0;j<15;j++)
	   {
		b[j+1]+=b[j]/10;
        b[j]=b[j]%10;
	   }	

	}	
	i=14;	
	while(!b[i])i--;
	for(;i>=0;i--)
	     out<<b[i];	
	in.close();out.close();
	return 0;
}
