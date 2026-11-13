#include<fstream>

using namespace std;

int main()
{
	int B[50][50];
	ifstream in("knight.in");
	ofstream out("knight.out");
	int n, m;
	in>>n>>m;
	int i, j;
	for(i=0;i<n;++i)
		for(j=0;j<m;++j)
		{
			B[i][j]=0;
			if( i-1>=0 && j-2>=0)
				B[i][j]+=B[i-1][j-2];
			if( i-2>=0 && j-1>=0)
				B[i][j]+=B[i-2][j-1];
			if(i+j==0)
				B[i][j]=1;
		}
	out<<B[n-1][m-1];
	return 0;
}

