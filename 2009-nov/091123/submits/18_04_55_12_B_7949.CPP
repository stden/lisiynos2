#include <fstream.h>
int main (void)
{
	ifstream in ("hopper.in");
	ofstream out("hopper.out");

	int s,x,y,dx,dy;
	in >>s>>x>>y>>dx>>dy;
		
	while(!(x==0 && y==0 && dx==0 &&dy==0)){	
		if( ((x % (2*s) > s)&&(y % (2*s) < s)) ||
			((x % (2*s) < s)&&(y % (2*s) > s)) )
		{
			out << "0";
		}else{
			if( (dx % s == 0) || (dy % s==0) ){
				out <<"-1";
			}else{
				int kol=0;
				do{
					x+=dx;
					y+=dy;
					kol++;
				}while(!(((x%(2*s)>s)&&(y%(2*s)<s)&&(y%(2*s)>0))||((x%(2*s)<s)&&(y%(2*s)>s)&&(x%(2*s)>0))));
				out<<kol;
			}
		}		
		out<<endl;
		in >>s>>x>>y>>dx>>dy;	
	};
	in.close();
	out.close();
	return 0;
}
