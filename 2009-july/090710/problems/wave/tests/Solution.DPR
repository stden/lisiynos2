program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
n,m,x,i,j,u,v:longint;
s:string;
a:array[1..100,1..100] of boolean;
g:array[1..100] of longint;
procedure asd(v,b:longint);
var i:integer;
begin
  if g[v]<=b then exit;
  g[v]:=b;
  inc(b);
  for i:=1 to n do if (a[v,i]) then asd(i,b);
end;
begin
 assign(f,'wave.in');
 assign(t,'wave.out');
 reset(f);
 rewrite(t);
 read(f,n);
 for i:=1 to n do g[i]:=1000000;
 read(f,m);
 read(f,x);
 for i:=1 to m do begin
  read(f,u);
  read(f,v);
  a[u,v]:=True;
  a[v,u]:=True;
 end;
 asd(x,1);
 for i:=1 to n do for j:=1 to n do if g[j]=i then s:=s+inttostr(j);
 writeln(t,length(s));
 for i:=1 to length(s) do begin
 write(t,s[i]);
 if i<>length(s) then write(t,' ');
 end;

 close(f);
 close(t);
end.
