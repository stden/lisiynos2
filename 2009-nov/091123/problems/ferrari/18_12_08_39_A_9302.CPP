#include <iostream> // ����.�����
#include <conio.h> // ��� getch()
#include <fstream>
using namespace std; // ��������� ������������ ����
class Troiki
	{
	public:
	int mas[3]; //mas[0] - 1-�� ����� mas[1] - 2- ����� mas[2] - ����� ������
	};
class IN_OUT
	{
	public:
	int in;
	int out;
	};
///////////////////////////
int main() // ������� �������
	{
    int N,M,K; // �������� ����� N,M � K
	int sum=0;
	/********* ���� �� ����� ferrrari.in *******/
	ifstream infile("ferrari.in");
	infile>>K>>N>>M;
/*	if(infile.good())
		{
		if(N>800 && N<1)
			{
			cout<<"N zadano neverno"<<endl;
			getch();
			exit(-1);
			}
		if(M>4000 && M<1)
			{
			cout<<"M zadano neverno"<<endl;
			getch();
			exit(-1);
			}
		if(K>40 && K<1)
			{
			cout<<"K zadano neverno"<<endl;
			getch();
			exit(-1);
			}
		} else {"Error opening file ferrari.in";getch();exit(-1);}
	*/		
	Troiki* T;
	T=new Troiki[M];
	int i;
	for(i=0;i<M;i++)
			for(int j=0;j<3;j++)
				infile>>T[i].mas[j];	

	/******************************************** ��������� ***/
	for(i=0;i<M;i++)
		{
		sum+=T[i].mas[2];
		}
				
    /********* ����� � ���� ferrrari.out *******/
	ofstream outfile("ferrari.out");
	outfile<<sum;
	if(outfile.good())
		{
		cout<<"All operations done."<<endl;
		}else {cout<<"Error writing file ferrari.out";getch();exit(-1);}

	getch(); // ���� ������� �������
	return 0;
} // ����� ������� �������
