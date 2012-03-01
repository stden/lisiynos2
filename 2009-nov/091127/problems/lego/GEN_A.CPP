#include <fstream.h>
#include <stdlib.h>

ofstream out("lego.in");

void main(void)
{ randomize();
  out<<1000<<endl;
  long l,x;
  for(int i=0;i<1000;i++)
    { l=rand()%1000+1;
      x=rand()%(1001-l);
      out<<l<<" "<<x<<endl;
    }
  out.close();
}