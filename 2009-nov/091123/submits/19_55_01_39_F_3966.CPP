#include <iostream> // ����.�����
#include <fstream>
using namespace std; // ��������� ������������ ����
///////////////////////////
struct Times
	{
	int hours;
	int mins;
	int secs;
	};
Times buff;
void obmen(Times& a,Times& b)
	{
	
	buff=a;
	a=b;
	b=buff;
	}

int main() // ������� �������
	{
	int N; // �������� ����� N

	/********* ���� �� ����� time.in *******/
	ifstream infile("time.in");
	infile>>N;
	int i,j;
	
	Times* Mas;
	Mas=new Times[N];
	for(i=0;i<N;i++)
		infile>>Mas[i].hours>>Mas[i].mins>>Mas[i].secs;
	/******************************************** ��������� ***/
	Times buff;
	for(i=0;i<N;i++)
		for(j=i;j<N;j++)
		{
		/////////////////////////////////////////
			if(Mas[i].hours>Mas[j].hours)
				{
				obmen(Mas[i],Mas[j]);
				}
			else if(Mas[i].hours==Mas[j].hours)
					{
					if(Mas[i].mins>Mas[j].mins)
						{
						obmen(Mas[i],Mas[j]);
						}
					else if(Mas[i].mins==Mas[j].mins)
								{
								if(Mas[i].secs>Mas[j].secs)
									{
									obmen(Mas[i],Mas[j]);
									}
								}

					}

				
		//////////////////////////////////////////
		};
    /********* ����� � ���� time.out *******/
	ofstream outfile("time.out");
	for(i=0;i<N;i++)
		outfile<<Mas[i].hours<<' '<<Mas[i].mins<<' '<<Mas[i].secs<<endl;
	cout<<"All operations done."<<endl;
	return 0;
} // ����� ������� �������
