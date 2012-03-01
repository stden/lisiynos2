// xxx.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h"
#include <fstream.h>
/*struct m
{
  int i;
  int j;
  struct m* left;
  struct m* down;
}*/
int main(void)
{
	ifstream in ("d.in");
	ofstream out("d.out");    
	int matrix[50][50],n,i,k,j;
	int matrix2[50][50];
	in>>n;
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
		{
			in>>matrix[i][j];
			matrix2[i][j]=0;
		}	
	matrix2[0][0]=matrix[0][0];
	for(i=0;i<2*n-1;i++)
		for(j=0;j<=i&&j<n;j++)
			for(k=0;k<=i&&k<n;k++)			
				if((k+j)==i)				
				{
					if(k+1<n)
						if(matrix2[k+1][j]<matrix2[k][j]+matrix[k+1][j])
							matrix2[k+1][j]=matrix2[k][j]+matrix[k+1][j];
					if(j+1<n)
						if(matrix2[k][j+1]<matrix2[k][j]+matrix[k][j+1])
							matrix2[k][j+1]=matrix2[k][j]+matrix[k][j+1];
				}
	out<<matrix2[n-1][n-1];
	out.close();in.close();
	return 0;
}
