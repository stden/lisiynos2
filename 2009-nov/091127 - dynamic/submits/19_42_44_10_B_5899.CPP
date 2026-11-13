// FIB.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h" //Erase before submition!!!
#include "fstream.h"
const m=16;
struct lng
{
	int dig[m],sz;
};
int max(int a, int b)
{
	return (a>b)?a:b;
}

void add(lng& c,lng a,lng b)
{
	int i,msz,p=0;
	msz=max(a.sz,b.sz);
	for (i=m-1;i>m-1-msz;i--)
	{
		c.dig[i]=p+a.dig[i]+b.dig[i];
		p=c.dig[i]/10;
		c.dig[i]%=10;
	}
	if (p>0)
	{
		c.dig[m-msz-1]=p;
		msz++;
	}
	c.sz=msz;
}
void minus(lng& c,lng a,lng b)
{
	int i,msz,p=0;
	msz=max(a.sz,b.sz);
	for (i=m-1;i>m-1-msz;i--)
	{
		c.dig[i]=a.dig[i]-b.dig[i]-p;
		if (c.dig[i]<0)
		{
			c.dig[i]+=10;
			p=1;
		}
		else 
			p=0;
	}
	for (i=m-1-msz;i<m && c.dig[i]==0;i++);
	c.sz=m-i-1;
}
void init(lng& a)
{
	a.dig[m-1]=1;
	a.sz=1;
	for (int i=0;i<m-1;i++)
		a.dig[i]=0;
}
int main(int argc, char* argv[])
{
	int n,i;
	ifstream in("fib.in");
	ofstream out("fib.out");
	in>>n;
	lng a,b;
	init(a);
	init(b);
	if (n==1)
	{
		out<<1;
		return 0;
	}
	else
		if (n==2)
		{
			out<<1;
			return 0;
		}

	for(i=3;i<=n;i++)
	{
		add(a,a,b);
		minus(b,a,b);
	}
	for (i=m-a.sz;i<m;i++)
		out<<a.dig[i];
	return 0;
}