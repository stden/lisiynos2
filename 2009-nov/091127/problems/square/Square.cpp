// 19.12.2001 - Square.cpp
// Задача: Квадрат
//    Кто-то нарисовал квадрат ненулевой площади, на каждой стороне
//    квадрата (включая границы) отметили по одной точке. После этого
//    квадрат стерли. Требуется узнать, можно ли по отмеченным точкам
//    восстановить квадрат, и если да, вывести координаты вершин
//    возможного квадрата в порядке их обхода по или против часовой
//    стрелке, начиная с любой. Отмеченные точки даны в порядке их
//    обхода по или против часовой стрелке. Если существуют несколько
//    правильных ответов, достаточно вывести одно.
// Решение: математическое точное
// Написал: Максимов А.Б.

#include <fstream.h>
#include <math.h>

ifstream in ("input.txt");
ofstream out("output.txt");

#define sqr(x) ((x)*(x))
#define swap(a,b) { double x=a; a=b; b=x; }
const double eps=0.0000001;

struct
  { double x, y;
  } pt[4];

void main(void)
{ int i, j, ndx[]={1,0,2,3,0,2,4,7,5,6,7,5,0,7,2,7,2,5,0,5};
  for(i=0; i<4; i++)
    in >> pt[i].x >> pt[i].y;

  // Start the algorithm
  double A = pt[2].y + pt[1].x - pt[3].x - pt[0].y;
  double B = pt[1].y + pt[0].x - pt[2].x - pt[3].y;
  double wg[8], d = A * A + B * B;
  for(j=0; j<5; ++j)
    { for(i=0; i<4; i++)
        wg[i] = A * pt[i].x + B * pt[i].y, wg[i+4] = A * pt[i].y - B * pt[i].x;
      for(i=0; i<4; i++)
        if((wg[ndx[i*3]]-wg[ndx[i*3+1]])*
           (wg[ndx[i*3]]-wg[ndx[i*3+2]]) > 0) break;
      if( i<4 || fabs(fabs(wg[0] - wg[2]) - fabs(wg[5] - wg[7])) > eps || !d )
        { if(j==0) swap(A,B);
          if(j==1) B -= 2. * ( pt[1].x - pt[3].x ),
                   A -= 2. * ( pt[1].y - pt[3].y ), d = A * A + B * B;
          if(j==2) swap(A,B);
          if(j==3) A=-A;
          if(j<4 ) continue;
          out<<"No solution";
        }
      else
        for(i=0; i<4; i++)
          out << ( A * wg[ndx[12+i*2]] - B * wg[ndx[13+i*2]] ) / d <<" "
              << ( A * wg[ndx[13+i*2]] + B * wg[ndx[12+i*2]] ) / d <<endl;
      break;
    }
  // End of the algorithm

  in.close();
  out.close();
}
