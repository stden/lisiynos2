{$Q-}
program strings;

uses sysutils;

Var
  a,g,u,i,p,j,n : longint;
  R,Rl,K : longint;
  s1,s2 : string;
  c1 : array[1..1000000] of longint;
  c2 : array[1..1000000] of longint;
  st : array[1..1000000] of longint;

  function hash(j:longint):longint;
   begin
    if j=1 then
     begin
      hash:=Rl;
     end
    else
     R:=(R-c1[j-1]*st[1])*43 + c1[j-1+n];
    hash:=R;
   end;

BEGIN

  Assign(input,'substr.in');
  Assign(output,'substr.out');
  Rewrite(output);
  Reset(input);

  Readln(s1);
  Readln(s2);
  n:= length(s2);
  g:= length(s1);

  for p:=1 to g do
   st[p]:=1;

  for p:=1 to n do
     c2[p]:= ord(s2[p]);

  for p:=1 to g do
     c1[p]:= ord(s1[p]);

  For p:=1 to n do
   begin
    For i:=1 to (n-p) do
     st[p]:=st[p]*43;
   end;

  for p:=1 to n do
      R:=R+c1[p]*st[p];

  Rl:=R;

  for p:=1 to n do
      K:=K+c2[p]*st[p];

  For j:=1 to g do
   begin
    if hash(j) = K then
    begin
     write(j,' ');
     u:=1;
    end;
   end;
  If u <> 1 then
   write('none');

  close(output);
  close(input);

END.
