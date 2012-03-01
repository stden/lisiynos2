// C.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <fstream.h>
int main()
{
	int n,m,i,j,a[101][101],c[101],k;
	ifstream in("light.in");
	ofstream out("light.out");
	in>>n>>m;
	/*
	{
		c[i]=0;
		c[j]
		for(j=0;j<n;j++)
			a[i][j]=0;
	}*/
	for(i=0;i<n;i++)
		c[i]=0;
	for(k=0;k<m;k++)
	{
		in>>i>>j;
		c[i-1]++;
		c[j-1]++;
	}
	for(i=0;i<n;i++)
		out<<c[i]<<" ";
	in.close();
	out.close();
	return 0;
}
