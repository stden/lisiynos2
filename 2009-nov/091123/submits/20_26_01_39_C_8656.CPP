#include <iostream> // ����.�����
#include <fstream>
using namespace std; // ��������� ������������ ����
///////////////////////////

int main() // ������� �������
	{
    int D,G;
	int Times=0; // �����, ������� ����������� ����
	/********* ���� �� ����� well.in *******/
	ifstream infile("well.in");
	infile>>D>>G;
	int i; 
	int* T;
	T=new int[G];
	int* F;
	F=new int[G];
	int* H;
	H=new int[G];

	for(i=0;i<G;i++)
		infile>>T[i]>>F[i]>>H[i];
	/******************************************** ��������� ***/
	for(i=0;i<G;i++)
		{
		Times+=H[i];
		}
	/********* ����� � ���� well.out *******/
	ofstream outfile("well.out");
	if(Times>=D)
		outfile<<T[G-1];
		else
			outfile<<F[G-1];
	cout<<"All operations done."<<endl;
	return 0;
} // ����� ������� �������
