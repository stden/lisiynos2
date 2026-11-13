#include <fstream.h>

const int Nmax=20;

void main(void)
{ long i1,j1,i2,j2,ct=0;
  for(i1=0;i1<Nmax;i1++)
    for(j1=0;j1<Nmax;j1++)
      for(i2=i1;i2<Nmax;i2++)
	for(j2=j1;j2<Nmax;j2++)
	  ct++;
  cout<<ct<<endl;
}

