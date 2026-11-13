#include <fstream.h>
#include <stdlib.h>

//#define _DEBUG // - режим тестирования алгоритма

#define sqr(x) ((x)*(x))

ifstream in("input.txt");
ofstream out("output.txt");
const int Nmax=5;
const int Smax=520;

#ifndef _DEBUG
// Длинная арифметика (быстрый вариант)
class LongNum
{ private:
    char cif[Smax];
    static char _temp_str[Smax];
    int pos;
  public:
    LongNum(void);
    void calc(LongNum&x, LongNum&y);
    LongNum& operator=(LongNum &t);
    LongNum& operator=(long t);
    int operator>(LongNum &t);
    char* getstr(void);
};
char LongNum::_temp_str[Smax];
#else
#define LongNum long
#endif

LongNum huge* din[2];     // Для минимума и максимума
long ndx[Nmax][Nmax];     // Массив смещений по индексам

long M, N, i, j, k, ct=0;
LongNum r1, r2, tmp;

// Основные вычисления динамики
void check(LongNum &min, LongNum &max, long fl, long x, long y)
{
#ifndef _DEBUG
  r1.calc(din[1][x], din[0][y]);
  r2.calc(din[0][x], din[1][y]);
#else
  r1=labs(sqr(din[1][x])-sqr(din[0][y]));
  r2=labs(sqr(din[0][x])-sqr(din[1][y]));
#endif
  if(r1>r2)
  { tmp=r1;
    r1=r2; r2=tmp;
  }
  if(!fl) min=r1, max=r2;
    else
    { if(min>r1) min=r1;
      if(r2>max) max=r2;
    }
}

long getpos(int i, int j, int di, int dj)
{ return ndx[j][i]+dj*(Nmax-i)+di;
}

// Решение задачи - динамическое
void Solve(void)
{ int dx, dy, x, y, fl, xi, yi;
  LongNum min, max;
  for(dx=0; dx<N; dx++)
    for(dy=0; dy<M; dy++)
      if(dx||dy)
	for(x=0; x<N-dx; x++)
	  for(y=0; y<M-dy; y++)
	    { fl=0;
	      for(xi=0; xi<dx; xi++, fl=1)
		 check(min, max, fl, getpos(x,y,xi,dy),
				     getpos(x+xi+1,y,dx-xi-1,dy));
	      for(yi=0; yi<dy; yi++, fl=1)
		 check(min, max, fl, getpos(x,y,dx,yi),
				     getpos(x,y+yi+1,dx,dy-yi-1));
	      din[0][getpos(x,y,dx,dy)]=min;
	      din[1][getpos(x,y,dx,dy)]=max;
	    }
}

void main(void)
{
  // пересчет индексов, выделение ресурсов
  for(i=0;i<Nmax;i++)
    for(j=0;j<Nmax;j++)
      { ndx[i][j]=ct;
	ct+=(Nmax-i)*(Nmax-j);
      }
  din[0]=new huge LongNum[ct];
  din[1]=new huge LongNum[ct];
  if(!din[0] || !din[1])
    { cout<<"Not enought memory"<<endl;
      return;
    }

  // чтение данных
  in>>M>>N;
  for(i=0;i<M;i++)
    for(j=0;j<N;j++)
      { in>>k;
	din[0][getpos(j,i,0,0)]=din[1][getpos(j,i,0,0)]=k;
      }

  // решение задачи
  Solve();

  // вывод результата
#ifdef _DEBUG
  out<<din[1][(M-1L)*Nmax+N-1L]<<" "<<din[0][(M-1L)*Nmax+N-1L];
#else
  out<<din[1][getpos(0,0,N-1,M-1)].getstr()<<endl;
#endif

  delete []din[0];
  delete []din[1];
  in.close();
  out.close();
}

// -----------------------------------------------------------------------
// Implementation of Long arithmetic
// -----------------------------------------------------------------------
#ifndef _DEBUG
int p,q,r,mx=Smax/2, sz;
LongNum qr1, qr2;

LongNum::LongNum(void)
{ for(p=0; p<Smax; p++) cif[p]=pos=0;
}

LongNum& LongNum::operator=(LongNum &t)
{ for(p=0; p<Smax; p++) cif[p]=t.cif[p];
  pos=t.pos;
  return *this;
};

// считаем что t>=0
LongNum& LongNum::operator=(long t)
{ for(p=0; t; p++)
    cif[p]=t%10L, t/=10L;
  pos=p+1;
  for(; p<Smax; p++) cif[p]=0;
  return *this;
};

int LongNum::operator>(LongNum &t)
{ for(p=(pos>t.pos?pos:t.pos); p>=0; p--)
    if(cif[p]>t.cif[p]) return 1;
    else
    if(cif[p]<t.cif[p]) return 0;
  return 0;
};

char* LongNum::getstr(void)
{ for(p=Smax-1; !cif[p] && p>0; p--);
  for(q=0; p>=0; p--)
    _temp_str[q++]=cif[p]+'0';
  _temp_str[q]=0;
  return _temp_str;
}

// calc the function f(x,y)=labs(x*x-y*y)
void LongNum::calc(LongNum&x, LongNum&y)
{ for(p=0; p<Smax; p++)
    cif[p]=qr1.cif[p]=qr2.cif[p]=0;
  for(p=r=0; p<x.pos; r=++p)
    for(q=0; q<x.pos; q++, r++)
      { qr1.cif[r]+=x.cif[p]*x.cif[q];
	qr1.cif[r+1]+=qr1.cif[r]/10;
	qr1.cif[r]%=10;
      }
  for(p=r=0; p<y.pos; r=++p)
    for(q=0; q<y.pos; q++, r++)
      {	qr2.cif[r]+=y.cif[p]*y.cif[q];
	qr2.cif[r+1]+=qr2.cif[r]/10;
	qr2.cif[r]%=10;
      }
  pos=2*(x.pos<y.pos?y.pos:x.pos)+3;
  if(pos>=Smax) pos=Smax-1;
  for(p=pos; p>=0; p--)
    cif[p]=qr1.cif[p]-qr2.cif[p];
  for(p=0; p<pos; p++)
    { if(cif[p]<0) cif[p+1]-=(-cif[p])/10+1,
		   cif[p]+=(int)((-cif[p])/10+1)*10;
      cif[p+1]+=cif[p]/10;
      cif[p]%=10;
    }

  if(cif[pos]<0) cif[pos]=10+cif[pos];
  if(cif[pos]==9)
    { cif[0]-=1;
      for(p=0; p<=pos; p++)
       { cif[p]=9-cif[p];
	 cif[p+1]-=cif[p]/10;
	 cif[p]%=10;
       }
    }
  while(!cif[pos] && pos>0) pos--;
  if(++pos>=Smax) pos=Smax-1;
}
#endif
