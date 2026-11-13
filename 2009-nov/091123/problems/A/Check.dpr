{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{-$M 16384,0,655360}

uses testlib;

var
  i,j,N:longint;
  A : array [1..100,1..100] of integer;
  user_sum : integer;
  jury_sum : integer;
begin
  N:=inf.readlongint;
  for i:=1 to N do
    for j:=1 to N do
      A[i,j] := inf.readlongint;
  user_sum := 0;
  jury_sum := 0;
  while not ouf.seekeof do begin
    user_sum := user_sum + ouf.readlongint;
  end;
  while not ans.seekeof do begin
    jury_sum := jury_sum + ans.readlongint;
  end;
  if user_sum<>jury_sum then quit(_WA,' expected '+IntTostr(jury_sum)+' '+intTostr(user_sum))
  else quit(_Ok,'');
end.
