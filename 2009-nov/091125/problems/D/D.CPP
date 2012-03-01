#include <fstream.h>

void main(void) {
  ifstream in("input.txt");
  ofstream out("output.txt");
  long N,Pos=0;
  long S=1,K=1;
  in>>N;
  while(Pos<N) {
    if ((0<K)&&(K<10)) Pos++;
    if ((9<K)&&(K<100)) Pos+=2;
    if ((99<K)&&(K<1000)) Pos+=3;
    if ((999<K)&&(K<10000)) Pos+=4;
    if ((9999<K)&&(K<100000)) Pos+=5;
    if (Pos>=N) break;
    if (K==S) {
      S++;
      K=1;
    } else { K++; }
  }
  int i=Pos-N+1;
  int dig=0;
  while (i!=0) {
    dig=K%10;
    K/=10;
    i--;
  }
  out<<dig;
}