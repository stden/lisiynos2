#include <fstream.h>

ifstream in ("input.txt");
ofstream out("output.txt");

const int max=402;
const int Smax=130;

// --------------------------------------------------------------
// Длинная арифметика, обыкновенная
// --------------------------------------------------------------
class LongNum
{ private:
    static char _temp_buf[Smax];
  public:
    char cif[Smax];
    LongNum();
    void operator *=(long p);
    void operator -=(LongNum &t);
    char * getstr();
};
char LongNum::_temp_buf[Smax];

LongNum::LongNum()
{ for(int i=0;i<Smax; i++) cif[i]=0; }

void LongNum::operator *=(long p)
{ for(int i=0;i<Smax-1; i++) cif[i]*=p;
  for(i=0;i<Smax-1; i++)
    cif[i+1]+=cif[i]/10, cif[i]%=10;
}

void LongNum::operator -=(LongNum &t)
{ for(int i=0; i<Smax; i++)
    { cif[i]-=t.cif[i];
      if(cif[i]<0) cif[i+1]-=(-cif[i])/10+1, cif[i]+=(int)((-cif[i])/10+1)*10;
      cif[i+1]+=cif[i]/10, cif[i]%=10;
    }
}

char * LongNum::getstr()
{ for(int i=Smax-1; i>0 && !cif[i]; i--);
  for(int j=0; i>=0; i--)
    _temp_buf[j++]=cif[i]+'0';
  _temp_buf[j]=0;
  return _temp_buf;
}
// { LongNum }
// --------------------------------------------------------------

LongNum buf[max];
int pos=0;

void main(void)
{ long N,K,i;
  LongNum sum;
  in>>N>>K;

  buf[pos++].cif[0]=1; // 0-ая ячейка
  buf[pos++].cif[0]=1; // 1-ая ячейка
  for(i=1; i<K; i++, pos++)
    { buf[pos]=buf[pos-1];
      buf[pos]*=2;
    }

  sum=buf[pos-1];
  for(i=N-K; i>=0; i--)
    { sum*=2;
      sum-=buf[(pos-K-1+max)%max];
      buf[pos++]=sum;
      pos%=max;
    }

  out<<buf[(pos-1+max)%max].getstr()<<endl;

  in.close();
  out.close();
}
