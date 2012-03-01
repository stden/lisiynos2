#include <fstream.h>

ofstream out("10.");

void main(void)
{ out<<1000<<endl;
  for(int i=0;i<1000;i++)
    out<<2<<" "<<(999-i)<<endl;
  out.close();
}