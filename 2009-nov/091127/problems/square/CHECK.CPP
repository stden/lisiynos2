#include <fstream.h>
#include <math.h>
#include <string.h>
#include <stdio.h>

#define sqr(x) ((x)*(x))
#define len(a,b) sqrt(sqr(a.x-b.x)+sqr(a.y-b.y))
const double eps =0.001;    // Точность ответа
const double eps2=0.000001; // Точность нуля

struct point
  { double x,y;
  } pti[4], pto[4];

int belongs(point &x, point &a, point &b)
{ if(fabs(len(a,x)+len(b,x)-len(a,b))>eps2) return 0;
  return 1;
}

void main(int n, char**p)
{
  if(n!=5)
    { printf("Problem : Square  (C)2001 by Maximov Alexander\r\n"
             "Checker Usage: check.exe <INPUT> <OUTPUT> <ANSWER> <REPORT>\r\n");
      return;
    }
  ifstream in (p[1]);
  ifstream out(p[2]);
  ifstream ans(p[3]);
  ofstream res(p[4]);


  char str[256], mess[256];
  int resc=0, j;
  strcpy(mess, "Все хорошо :)");

  ans>>str;
  if(str[0]=='N')
    { str[0]=0;
      out>>str;
      if(str[0]=='N') resc=0; //OK
        else resc=1, strcpy(mess,"Ожидалось No solution вместо набора точек");
      if(!str[0]) resc=3, strcpy(mess,"Ожидалось 'No solution' или список точек");
    }
  else
   { for(int i=0;i<4;i++)
      { in >>pti[i].x>>pti[i].y;
        out>>pto[i].x>>pto[i].y;
      }
     double l=len(pto[0], pto[3]), s;
     for(i=0;i<3;i++)
       if(fabs((s=len(pto[i],pto[i+1]))-l)>eps) break;
     if(i<3)
       { resc=1, sprintf(mess,"Длины ребер квадрата не одинаковы %lf!=%lf",l,s);
       }
       else
       { for(i=0;i<4;i++)
          if(fabs((pto[(i+2)%4].x-pto[(i+1)%4].x)*(pto[i].x-pto[(i+1)%4].x)+
                  (pto[(i+2)%4].y-pto[(i+1)%4].y)*(pto[i].y-pto[(i+1)%4].y))>eps2)
          break;
         if(i<4)
           { resc=1, strcpy(mess,"Кривой квадрат - не прямые углы");
           }
           else
           { for(i=0;i<4;i++)
               { for(j=0;j<4;j++)
                   if(belongs(pti[i], pto[j], pto[(j+1)%4])) break;
                 if(j==4)
                   { resc=1, strcpy(mess,"Входная точка не находится на ребре полученного квадрата");
                     break;
                   }
               }
           }
       }
   }

  res<<".Testlib Result Number = "<<resc<<endl;
  res<<".Check Comments = "<<mess<<endl;
  cout<<resc;

  in.close();
  out.close();
  ans.close();
  res.close();
}


