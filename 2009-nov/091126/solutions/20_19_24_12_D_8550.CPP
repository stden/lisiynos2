#include <fstream.h>
#include <stdio.h>
#include <string.h> 

ifstream in ("numtostr.in");
ofstream out("numtostr.out");

void printletter(int l)
{
if(l==1)out<<"���� ";
if(l==2)out<<"��� ";
if(l==3)out<<"��� ";
if(l==4)out<<"������ ";
if(l==5)out<<"���� ";
if(l==6)out<<"����� ";
if(l==7)out<<"���� ";
if(l==8)out<<"������ ";
if(l==9)out<<"������ ";
}

void printletterCh(int l)
{
if(l==1)out<<"���� ";
if(l==2)out<<"��� ";
if(l==3)out<<"��� ";
if(l==4)out<<"������ ";
if(l==5)out<<"���� ";
if(l==6)out<<"����� ";
if(l==7)out<<"���� ";
if(l==8)out<<"������ ";
if(l==9)out<<"������ ";
}

void printletterdec(int l)
{
if(l==2)out<<"�������� ";
if(l==3)out<<"�������� ";
if(l==4)out<<"����� ";
if(l==5)out<<"��������� ";
if(l==6)out<<"���������� ";
if(l==7)out<<"��������� ";
if(l==8)out<<"����������� ";
if(l==9)out<<"��������� ";
}

void printletterSot(int l)
{
if(l==1)out<<"��� ";
if(l==2)out<<"������ ";
if(l==3)out<<"������ ";
if(l==4)out<<"��������� ";
if(l==5)out<<"������� ";
if(l==6)out<<"�������� ";
if(l==7)out<<"������� ";
if(l==8)out<<"��������� ";
if(l==9)out<<"��������� ";
}


int main(void)
{

int t,i,j;
int a[10];
unsigned long n;
in >>t;

for(i=0;i<t;i++){
	in>>n;
	for(j=0;j<10;j++)a[j]=0;
	for(j=0;j<10;j++)
	{
		a[j]=n%10;
		n=n/10;
	}
	//ANALYS
//million
	if(a[6]>0 || a[7]>0 || a[8]>0){
		printletterSot(a[8]);		
		if(a[7]==1){
			if(a[3]==0)out<<"������ ";
			if(a[6]==1)out<<"����������� ";
			if(a[6]==2)out<<"���������� ";
			if(a[6]==3)out<<"���������� ";
			if(a[6]==4)out<<"������������ ";
			if(a[6]==5)out<<"����������� ";
			if(a[6]==6)out<<"����������� ";
			if(a[6]==7)out<<"���������� ";
			if(a[6]==8)out<<"������������ ";
			if(a[6]==9)out<<"������������ ";
			out<<"��������� ";
		}else {
			printletterdec(a[7]);
			printletter(a[6]); 
			if(a[6]==1)out<<"������� ";
			if(a[6]==2 || a[6]==3 || a[6]==4)out<<"�������� ";
			if(a[6]>4 || a[6]==0)out<<"��������� ";
		}
	}

	if(a[5]>0 || a[4]>0 || a[3]>0){
		printletterSot(a[5]);		
		if(a[4]==1){
			if(a[3]==0)out<<"������ ";
			if(a[3]==1)out<<"����������� ";
			if(a[3]==2)out<<"���������� ";
			if(a[3]==3)out<<"���������� ";
			if(a[3]==4)out<<"������������ ";
			if(a[3]==5)out<<"����������� ";
			if(a[3]==6)out<<"����������� ";
			if(a[3]==7)out<<"���������� ";
			if(a[3]==8)out<<"������������ ";
			if(a[3]==9)out<<"������������ ";
			out<<"����� ";
		}else {
			printletterdec(a[4]);
			if(a[3]==1 || a[3]==2)printletterCh(a[3]); else printletter(a[3]); 
			if(a[3]==1)out<<"������ ";
			if(a[3]==2 || a[3]==3 || a[3]==4)out<<"������ ";
			if(a[3]>4 || a[3]==0)out<<"����� ";
		}
	}
		printletterSot(a[2]);		
		if(a[1]==1){
			if(a[0]==0)out<<"������ ";
			if(a[0]==1)out<<"����������� ";
			if(a[0]==2)out<<"���������� ";
			if(a[0]==3)out<<"���������� ";
			if(a[0]==4)out<<"������������ ";
			if(a[0]==5)out<<"����������� ";
			if(a[0]==6)out<<"����������� ";
			if(a[0]==7)out<<"���������� ";
			if(a[0]==8)out<<"������������ ";
			if(a[0]==9)out<<"������������ ";
		}
			else{

			printletterdec(a[1]);
			printletter(a[0]); 
		}





	out<<'\n';
}
in.close();
out.close();
return 0;
}