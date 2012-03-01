#include <iostream> // ввод.вывод
#include <fstream>
using namespace std; // заполняем пространство имен
///////////////////////////
struct Times
	{
	int hours;
	int mins;
	int secs;
	};

int main() // главная функция
	{
	int N; // заданные числа N

	/********* ввод из файла time.in *******/
	ifstream infile("time.in");
	infile>>N;
	int i,j;
	
	Times* Mas;
	Mas=new Times[N];
	for(i=0;i<N;i++)
		infile>>Mas[i].hours>>Mas[i].mins>>Mas[i].secs;
	/******************************************** обработка ***/
	Times buff;
	for(i=0;i<N;i++)
		for(j=i;j<N;j++)
		{
		if(Mas[i].hours>Mas[j].hours)
			{
			buff=Mas[i];
			Mas[i]=Mas[j];
			Mas[j]=buff;
			};
		};
    /********* вывод в файл time.out *******/
	ofstream outfile("time.out");
	for(i=0;i<N;i++)
		outfile<<Mas[i].hours<<' '<<Mas[i].mins<<' '<<Mas[i].secs<<endl;
	cout<<"All operations done."<<endl;
	return 0;
} // конец главной функции
