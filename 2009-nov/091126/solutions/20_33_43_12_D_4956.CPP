#include <fstream.h>
#include <stdio.h>
#include <string.h> 

ifstream in ("numtostr.in");
ofstream out("numtostr.out");

void printletter(int l)
{
if(l==1)out<<"один ";
if(l==2)out<<"два ";
if(l==3)out<<"три ";
if(l==4)out<<"четыре ";
if(l==5)out<<"пять ";
if(l==6)out<<"шесть ";
if(l==7)out<<"семь ";
if(l==8)out<<"восемь ";
if(l==9)out<<"девять ";
}

void printletterCh(int l)
{
if(l==1)out<<"одна ";
if(l==2)out<<"две ";
if(l==3)out<<"три ";
if(l==4)out<<"четыре ";
if(l==5)out<<"пять ";
if(l==6)out<<"шесть ";
if(l==7)out<<"семь ";
if(l==8)out<<"восемь ";
if(l==9)out<<"девять ";
}

void printletterdec(int l)
{
if(l==2)out<<"двадцать ";
if(l==3)out<<"тридцать ";
if(l==4)out<<"сорок ";
if(l==5)out<<"пятьдесят ";
if(l==6)out<<"шестьдесят ";
if(l==7)out<<"семьдесят ";
if(l==8)out<<"восемьдесят ";
if(l==9)out<<"девяносто ";
}

void printletterSot(int l)
{
if(l==1)out<<"сто ";
if(l==2)out<<"двести ";
if(l==3)out<<"триста ";
if(l==4)out<<"четыреста ";
if(l==5)out<<"пятьсот ";
if(l==6)out<<"шестьсот ";
if(l==7)out<<"семьсот ";
if(l==8)out<<"восемьсот ";
if(l==9)out<<"девятьсот ";
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
			if(a[6]==0)out<<"десять ";
			if(a[6]==1)out<<"одиннадцать ";
			if(a[6]==2)out<<"двенадцать ";
			if(a[6]==3)out<<"тринадцать ";
			if(a[6]==4)out<<"четырнадцать ";
			if(a[6]==5)out<<"пятнадцать ";
			if(a[6]==6)out<<"шестнадцать ";
			if(a[6]==7)out<<"семнадцать ";
			if(a[6]==8)out<<"восемнадцать ";
			if(a[6]==9)out<<"девятнадцать ";
			out<<"миллионов ";
		}else {
			printletterdec(a[7]);
			printletter(a[6]); 
			if(a[6]==1)out<<"миллион ";
			if(a[6]==2 || a[6]==3 || a[6]==4)out<<"миллиона ";
			if(a[6]>4 || a[6]==0)out<<"миллионов ";
		}
	}

	if(a[5]>0 || a[4]>0 || a[3]>0){
		printletterSot(a[5]);		
		if(a[4]==1){
			if(a[3]==0)out<<"десять ";
			if(a[3]==1)out<<"одиннадцать ";
			if(a[3]==2)out<<"двенадцать ";
			if(a[3]==3)out<<"тринадцать ";
			if(a[3]==4)out<<"четырнадцать ";
			if(a[3]==5)out<<"пятнадцать ";
			if(a[3]==6)out<<"шестнадцать ";
			if(a[3]==7)out<<"семнадцать ";
			if(a[3]==8)out<<"восемнадцать ";
			if(a[3]==9)out<<"девятнадцать ";
			out<<"тысяч ";
		}else {
			printletterdec(a[4]);
			if(a[3]==1 || a[3]==2)printletterCh(a[3]); else printletter(a[3]); 
			if(a[3]==1)out<<"тысяча ";
			if(a[3]==2 || a[3]==3 || a[3]==4)out<<"тысячи ";
			if(a[3]>4 || a[3]==0)out<<"тысяч ";
		}
	}
		printletterSot(a[2]);		
		if(a[1]==1){
			if(a[0]==0)out<<"десять ";
			if(a[0]==1)out<<"одиннадцать ";
			if(a[0]==2)out<<"двенадцать ";
			if(a[0]==3)out<<"тринадцать ";
			if(a[0]==4)out<<"четырнадцать ";
			if(a[0]==5)out<<"пятнадцать ";
			if(a[0]==6)out<<"шестнадцать ";
			if(a[0]==7)out<<"семнадцать ";
			if(a[0]==8)out<<"восемнадцать ";
			if(a[0]==9)out<<"девятнадцать ";
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