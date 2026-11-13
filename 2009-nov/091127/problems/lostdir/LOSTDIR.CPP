#include <fstream.h>
#include <string.h>

ifstream in("input.txt");
ofstream out("output.txt");

void main(void)
{ long N,M,i,j,r=0;
  char str[256], src[256], rem[256];
  for(i=0; i<256; i++) str[i]=rem[i]=0;

  in>>N>>M;
  for(i=0; i<N; i++)
    for(j=0, in>>src; src[j]; j++) str[j]^=src[j];
  for(i=0; i<M; i++)
    { in>>src;
      for(j=strlen(src); src[j]!='\\'; j--);
      if(r!=j || strncmp(rem,src,j))
	for(strncpy(rem,src,(r=j)), rem[j--]=0; j>=0; j--) str[j]^=src[j];
    }
  for(j=strlen(str); str[j]!='\\' && j>=0; j--);
  out<<(str+j+1);

  in.close();
  out.close();
}

