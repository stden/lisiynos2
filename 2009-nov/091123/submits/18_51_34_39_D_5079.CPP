#include <iostream> // ввод.вывод
#include <fstream>
using namespace std; // заполняем пространство имен
struct Ment
	{
	int post; //mas[0] - 1-ый город mas[1] - 2- город mas[2] - длина дороги
	};
///////////////////////////
int main() // главная функция
	{
    int N,mesto; // заданные числа N

	/********* ввод из файла ferrrari.in *******/
	ifstream infile("road.in");
	infile>>N;
	int i;
	Ment* M;
	M=new Ment[N];
	for(i=0;i<N;i++)
		infile>>M[i].post;
	infile>>mesto;
	/******************************************** обработка ***/
	int Number;
	int Max=20002;
	for(i=0;i<N;i++)
		{
		if(abs(M[i].post-mesto)<abs(Max-mesto))
			{
			Max=M[i].post;
			Number=i;
			}
		}
    /********* вывод в файл ferrrari.out *******/
	ofstream outfile("road.out");
	outfile<<(Number+1);
	cout<<"All operations done."<<endl;
	return 0;
} // конец главной функции
