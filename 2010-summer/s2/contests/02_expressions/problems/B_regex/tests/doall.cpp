#include <fstream>
#include <string>

using namespace std;

const int maxNameLength = 100;

ofstream fout;

void open(void) {
	static char outName[maxNameLength];
	static int outNumber;

   outNumber++;
   if( outNumber < 10 ) {
      outName[0] = '0';
      itoa(outNumber, outName+1, 10);
   } else
      itoa(outNumber, outName, 10);

   fout.open(outName, ios_base::out);
}

void close(void) {
      fout.close();
}

void geninput(int len, int ps) {
	
	string s, t;
	int tl, sl, l;

	tl = len;
   t.resize(tl);
   s.resize(0);

	for( int j = 0; j < tl; j++ ) {
		if( rand() % ps == 0 )
			t[j] = '*';
		else
			t[j] = (char) ('a' + (rand() % 26) );
	}

	for( int j = 0; j < tl; j++ ) {
		if( t[j] != '*' ) {
			s.push_back(t[j]);
			continue;
		}
		
		l = rand() % (100 - s.size() - (tl - 1 - j) + 1);

		for( int k = 0; k < l; k++ )
			s.push_back('a' + (rand() % 26));	
			
	}			
		
	open();
	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();
	
}

void badinput(int len, int ps, int wh) {
	
	string s, t;
	int tl, sl, l, flag, loop;

	tl = len;
   t.resize(tl);
   s.resize(0);

	for( int j = 0; j < tl; j++ ) {
		if( rand() % ps == 0 )
			t[j] = '*';
		else
			t[j] = (char) ('a' + (rand() % 26) );
	}

	flag = -1;
	loop = 0;

	for( int i = 0; i < len; i++ ) {
		loop += t[i] != '*';
		if( t[i] != '*' )
			flag = i;

		if( loop == wh ) 
			break;		
	}
		

	for( int j = 0; j < tl; j++ ) {
		if( t[j] != '*' ) {
			if( j != flag )
				s.push_back(t[j]);
			else
				s.push_back((t[j] - 'a' + 1) % 26 + 'a');
			continue;
		}
		
		l = rand() % (100 - s.size() - (tl - 1 - j) + 1);

		for( int k = 0; k < l; k++ )
			s.push_back('a' + (rand() % 26));	
			
	}			
		
	open();
	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();
	
}


void badinputb(int len, int ps, int wh) {
	
	string s, t;
	int tl, sl, l, flag, loop;

	tl = len;
   t.resize(tl);
   s.resize(0);

	for( int j = 0; j < tl; j++ ) {
		if( rand() % ps == 0 )
			t[j] = '*';
		else
			t[j] = (char) ('a' + (rand() % 26) );
	}

	flag = -1;
	loop = 0;

	for( int i = len-1; i >= 0; i-- ) {
		loop += t[i] != '*';
		if( t[i] != '*' )
			flag = i;

		if( loop == wh ) 
			break;		
	}
		

	for( int j = 0; j < tl; j++ ) {
		if( t[j] != '*' ) {
			if( j != flag )
				s.push_back(t[j]);
			else
				s.push_back((t[j] - 'a' + 1) % 26 + 'a');
			continue;
		}
		
		l = rand() % (100 - s.size() - (tl - 1 - j) + 1);

		for( int k = 0; k < l; k++ )
			s.push_back('a' + (rand() % 26));	
			
	}			
		
	open();
	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();
	
}

int main(void) {	

	open();
	fout << "3 3\nabc\na*c\n";
	close();

	open();
	fout << "7 5\nabacaba\na*d*a\n";
	close();

	open();
	fout << "1 1\na\nb\n";
	close();

	open();
	fout << "2 1\naa\n*\n";
	close();

	open();
	fout << "5 5\naabaa\n****b\n";
	close();

	open();
	fout << "5 3\naabaa\n*b*\n";
	close();

	open();
	fout << "5 10\naabaa\na********a\n";
	close();

	srand(239017);

	open();
	fout << "100 1\n";
	for( int i = 0; i < 100; i++ )
		fout << (char) ('a' + (rand() % 26) );
	fout <<"\n*\n";
	close();

	open();
	fout << "1 100\nz\n";
	for( int i = 0; i < 100; i++ )
		fout << '*';
	fout <<"\n";
	close();

	for( int i = 0; i < 10; i++ )
		geninput(50 + 5*i, (i>>2)+2);

	for( int i = 0; i < 5; i++ )
		badinput(90 + 2*i, (i>>1)+2, i+1);

	for( int i = 0; i < 5; i++ )
		badinputb(90 + 2*i, (i>>1)+2, i+1);

// anti greedy

	string s(""), t("");

	s.resize(0);
	t.resize(0);
	open();		
	for( int i = 0; i < 20; i++ ) {
		s += "aaabb";
		t += "*ab*";
	}
	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();

	s.resize(0);
	t.resize(0);
	open();		
	for( int i = 0; i < 25; i++ ) {
		s += "aaa";
		t += "*a";
	}

	for( int i = 0; i < 25; i++ ) t += "aa";

	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();

	s.resize(0);
	t.resize(0);
	open();		
	for( int i = 0; i < 25; i++ ) s += "aaa";
	for( int i = 0; i < 12; i++ ) t += "a*";
	for( int i = 0; i < 25; i++ ) t += "aa";
	for( int i = 0; i < 13; i++ ) t += "*a";

	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();

	s.resize(0);
	t.resize(0);
	open();		
	for( int i = 0; i < 25; i++ ) s += "aa";
	for( int i = 0; i < 12; i++ ) t += "a*";
	for( int i = 0; i < 25; i++ ) t += "aa";
	for( int i = 0; i < 13; i++ ) t += "*a";

	fout << s.size() << " " << t.size() << endl << s << endl << t << endl;
	close();

 
   return 0;
}