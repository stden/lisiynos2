// xxx.cpp : Defines the entry point for the console application.
//
//#include "stdafx.h"
#include <fstream.h>
int main(void)
{
	ifstream in("a.in");
	ofstream out("a.out");

	int n,m=0;
	in>>n;
	int **ms=new int * [n];
	int i,j;
	for(i=0;i<n;i++)
	{
		ms[i]=new int [n];
		for(j=0;j<n;j++)
			in>>ms[i][j];	
	}
	int *massiv=new int [n];
	for(i=0;i<n;i++)
		in>>massiv[i];

	for(i=0;i<n;i++)
		for(j=i;j<n;j++)		
			if(ms[i][j])			
				if(massiv[i]!=massiv[j])m++;
	
	for(i=0;i<n;i++)	
		delete ms[i];
	delete ms;
	delete massiv;
	out<<m;
	out.close();in.close();
	return 0;
}
