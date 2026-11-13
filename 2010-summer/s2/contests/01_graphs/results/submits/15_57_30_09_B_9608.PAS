program tree;
var
 A:array [1..100,1..100] of integer;
  N,k,i,j:integer;
 B:array [1..100] of integer;
begin
 assign(input,'tree.in');
 assign(output,'tree.out');
 reset(input);
 rewrite(output);
 readln(N);
 for i:=1 to N do
  for j:=1 to N do
    read(A[i,j]);
{ for i:=1 to N do B[i]:=0; }
 for i:=1 to N do
  for j:=1 to N do
   if A[i,j]=1 then k:=k+1;
               { begin
                 B[i]:=1;
                 B[j]:=1;
                end;
 for i:=1 to N do
  if B[i]=0 then k:=1; }
 if (N-k div 2=1) or (N=1) then writeln('YES')
         else writeln('NO');
close(input);
close(output);
end.



