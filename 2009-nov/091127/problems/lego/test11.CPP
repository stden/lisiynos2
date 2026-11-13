#include <fstream.h>

ofstream out("11.");

void main(void)
{ out<<1000<<endl;
  for(int i=0;i<1000;i++)
    out<<1000<<" "<<0<<endl;
  out.close();
}