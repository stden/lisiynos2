#include <iostream> // ввод.вывод
#include <fstream>
using namespace std; // заполняем пространство имен
struct Troiki
	{
	int mas[3]; //mas[0] - 1-ый город mas[1] - 2- город mas[2] - длина дороги
	};
struct IN_OUT
	{
	int in;
	int out;
	};
///////////////////////////
int main() // главная функция
	{
    int N,M,K; // заданные числа N,M и K
	int sum=0;
	/********* ввод из файла ferrrari.in *******/
	ifstream infile("ferrari.in");
	infile>>K>>N>>M;

	Troiki* T;
	T=new Troiki[M];
	int i,j;
	for(i=0;i<M;i++)
		for(j=0;j<3;j++)
			infile>>T[i].mas[j];	

	/******************************************** обработка ***/
	for(i=0;i<M;i++)
		sum+=T[i].mas[2];
				
    /********* вывод в файл ferrrari.out *******/
	ofstream outfile("ferrari.out");
	outfile<<sum;
	cout<<"All operations done."<<endl;
	return 0;
} // конец главной функции
