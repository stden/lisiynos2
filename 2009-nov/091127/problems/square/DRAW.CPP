#include <fstream.h>
#include <graphics.h>
#include <conio.h>
#include <stdlib.h>

ifstream in("output.txt");

void main(void)
{ struct
    { double x,y;
    } pt[4];
  char str[256];
  in>>str;
  if(str[0]=='N')
    { cout<<"No solution"<<endl;
      return;
    }
  pt[0].x=atof(str);
  in>>pt[0].y;
  for(int i=1; i<4; i++)
    in>>pt[i].x>>pt[i].y;
  in.close();

  int gm, gd=DETECT;
  initgraph(&gd, &gm, ".");
  cleardevice();

  int cx=200, cy=300, mx=20, my=20, num=10;

  for(i=0;i<num;i++)
    { line(cx+i*mx, 0, cx+i*mx, cy);
      line(cx, cy-my*i, cx+mx*num, cy-my*i);
    }

  setlinestyle(0,0,3);

  for(i=0;i<4;i++)
    line(cx+pt[i].x*mx, cy-pt[i].y*my,
	 cx+pt[(i+1)%4].x*mx, cy-pt[(i+1)%4].y*my);
  in.open("input.txt");
  for(i=0; i<4; i++)
    in>>pt[i].x>>pt[i].y;
  in.close();

  setcolor(GREEN);
  setfillstyle(SOLID_FILL,GREEN);

  for(i=0;i<4;i++)
    { sector(cx+pt[i].x*mx, cy-pt[i].y*my, 0, 360, 5, 5);
    }

  getch();
  closegraph();
}

