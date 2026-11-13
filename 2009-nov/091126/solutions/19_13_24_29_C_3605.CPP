// xxx.cpp : Defines the entry point for the console application.
//#include "stdafx.h"
#include <fstream.h>
int main(void)
{
	ifstream in("light.in");
	ofstream out("light.out");
	int n,m;
	in>>n>>m;
	int *massiv=new int[n];
	int i,j,k;
	for(i=0;i<n;i++)
		massiv[i]=0;
	for(i=0;i<m;i++)	
	{		
		in>>j>>k;	
		massiv[j-1]++;
		massiv[k-1]++;
	}
	for(i=0;i<n;i++)
		out<<massiv[i]<<' ';
	delete massiv;
	out.close();in.close();
	return 0;
}
