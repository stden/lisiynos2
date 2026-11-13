program b;
var f1,f2:text;
    i,j,n:integer;
    s:string;
    p:array [1..1000000] of integer;

begin
 assign(f1, 'pi.in'); reset(f1);
 assign(f2, 'pi.out'); rewrite(f2);
 readln(f1, s);
 fillchar(p, sizeof(p), 0);
 n:=0;
 for i:=2 to length(s) do
  begin
   while (n>0) and (s[n+1]<>s[i]) do
    n:=p[n];
   if s[n+1]=s[i] then
    inc(n);
   p[i]:=n;
  end;
 For i:=1 to length(s) do
  write(f2, p[i], ' ');
 close(f1);
 close(f2);
end.
