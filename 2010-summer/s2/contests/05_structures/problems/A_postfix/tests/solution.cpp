#include<fstream>
#include<iostream>
#include<stack>

using namespace std;

int main()
{
	ifstream in("din.txt");
	ofstream out("dout.txt");
	stack<int> S;
	char c;
	while(in>>c)
	{
		if(c>='0' && c<='9')
		{
			S.push(c-'0');
		}
		else
		{
			if(S.size()<2)
			{
				cerr<<"BAD TEST: run-size check failed"<<endl;
				return 1;
			}
			int d1=S.top();
			S.pop();
			int d2=S.top();
			S.pop();
			if(c=='+')
				S.push(d2+d1);
			else if (c=='-')
				S.push(d2-d1);
			else if (c=='*')
				S.push(d2*d1);
			else
			{
				cerr<<"BAD TEST: wrong operator"<<endl;
				return 2;
			}
			
		}
	}
	if(S.size()!=1)
	{
				cerr<<"BAD TEST: wrong final size"<<endl;
				return 3;
	}
	else
		out<<S.top()<<endl;
	return 0;
}
