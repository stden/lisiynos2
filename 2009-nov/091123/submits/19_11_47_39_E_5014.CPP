#include <iostream> // ����.�����
#include <fstream>
using namespace std; // ��������� ������������ ����
///////////////////////////
int main() // ������� �������
	{
    unsigned long N; // �������� ����� N

	/********* ���� �� ����� sort.in *******/
	ifstream infile("sort.in");
	infile>>N;
	unsigned long i;
	
	unsigned long* Mas;
	Mas=new unsigned long[N];
	for(i=0;i<N;i++)
		infile>>Mas[i];
	/******************************************** ��������� ***/
	unsigned long buff;
	for(i=0;i<N;i++)
		for(int j=i;j<N;j++)
		{
		if(Mas[i]>Mas[j])
			{
			buff=Mas[i];
			Mas[i]=Mas[j];
			Mas[j]=buff;
			};
		};
    /********* ����� � ���� sort.out *******/
	ofstream outfile("sort.out");
	for(i=0;i<N;i++)
		outfile<<Mas[i]<<' ';
	cout<<"All operations done."<<endl;
	return 0;
} // ����� ������� �������
