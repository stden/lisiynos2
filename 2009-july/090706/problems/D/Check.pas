{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

uses testlib;

var i,j:longint;

begin
  i:=ouf.readlongint;
  j:=ans.readlongint;
  if i<>j then quit(_WA,'')
  else quit(_Ok,'');
end.
