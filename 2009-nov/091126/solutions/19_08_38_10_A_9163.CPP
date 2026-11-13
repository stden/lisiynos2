// A.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h"
#include <fstream.h>
int main()
{
	int n,i,j,a[101][101],c[101],k=0;
	ifstream in("color.in");
	ofstream out("color.out");
	in>>n;
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			in>>a[i][j];
	for(i=0;i<n;i++)
		in>>c[i];
	for(i=0;i<n;i++)
		for(j=i+1;j<n;j++)
			if (a[i][j] && c[i]!=c[j])
				k++;
	out<<k;
	in.close();
	out.close();
	return 0;
}
