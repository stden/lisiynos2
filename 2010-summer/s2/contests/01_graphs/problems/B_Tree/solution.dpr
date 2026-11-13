program solution;

{$APPTYPE CONSOLE}

uses
 SysUtils;

var mark:array [0..200] of boolean;
    G:array [0..200,0..200] of integer;
    n,edge,comp,i,j:integer;

procedure dfs(v:integer);
var i:integer;
begin
 mark[v]:=false;
 for i:=1 to n do
  if (G[v,i]=1) and mark[i] then dfs(i)
end;

begin
 reset(input,'tree.in');
 rewrite(output,'tree.out');
 read(n);
 edge:=0;
 for i:=1 to n do
  for j:=1 to n do begin
    read(G[i,j]);
    inc(edge,G[i,j])
   end;
 comp:=0;
 fillchar(mark,sizeof(mark),true);
 for i:=1 to n do
  if mark[i] then begin
    inc(comp);
    dfs(i)
   end;
 if (comp=1) and ((n-comp)=edge div 2) then writeln('YES')
 else writeln('NO')
end.
