program pi;

{$APPTYPE CONSOLE}
var
 p:array [1..1000000] of integer;
 i,k,n:integer;
 S:string;
begin
 assign(input,'pi.in');
 assign(output,'pi.out');
 reset(input);
 rewrite(output);
 readln(S);
 N:=length(S);
 for i := 1 to N do
  p[i]:=0;
 k:=0;
 for I := 2 to N do
  begin
   while (k>0) and (S[k+1]<>s[i]) do
    k:=p[k];
   if s[k+1]=s[i] then inc(k);
   p[i]:=k;
  end;
 for i := 1 to N do
  write(p[i],' ');
close(input);
close(output);
end.
