#include <iostream> // ����.�����
#include <fstream>
using namespace std; // ��������� ������������ ����
struct Troiki
	{
	int mas[3]; //mas[0] - 1-�� ����� mas[1] - 2- ����� mas[2] - ����� ������
	};
struct IN_OUT
	{
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

	Troiki* T;
	T=new Troiki[M];
	int i,j;
	for(i=0;i<M;i++)
		for(j=0;j<3;j++)
			infile>>T[i].mas[j];	

	/******************************************** ��������� ***/
	for(i=0;i<M;i++)
		sum+=T[i].mas[2];
				
    /********* ����� � ���� ferrrari.out *******/
	ofstream outfile("ferrari.out");
	outfile<<sum;
	cout<<"All operations done."<<endl;
	return 0;
} // ����� ������� �������
