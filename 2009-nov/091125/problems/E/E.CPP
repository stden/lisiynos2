#include <fstream.h>

unsigned long Func(unsigned long a)
{
 unsigned long i=0;
 while(a!=0)
 {
  i++;
  a/=10;
 }
 return i;
}

void main(void)
{
 ifstream in("input.txt");
 ofstream out("output.txt");
 unsigned long N,Pos=0;
 unsigned long S=1,K=0;
 in>>N;
 while(Pos<N)
 {
  K+=Func(S);
  if ((Pos+K)>=N) break;
  Pos+=K;
  S++;
 }
 K=1;
 S--;
 while(Pos<N)
 {
  if ((0<K)&&(K<10)) Pos++;
  if ((9<K)&&(K<100)) Pos+=2;
  if ((99<K)&&(K<1000)) Pos+=3;
  if ((999<K)&&(K<10000)) Pos+=4;
  if ((9999<K)&&(K<100000)) Pos+=5;
  if (Pos>=N) break;
  if (K==S)
  {
   S++;
   K=1;
  }
  else
  {
   K++;
  }
 }
 unsigned long i=Pos-N+1;
 unsigned long dig=0;
 while (i!=0)
 {
  dig=K%10;
  K/=10;
  i--;
 }
 out<<dig;
}