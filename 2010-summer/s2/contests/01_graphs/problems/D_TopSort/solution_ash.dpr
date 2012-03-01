{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O-,P+,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $02000000}
{$s+}
program topsort_ash;

{$APPTYPE CONSOLE}

const
  maxn = 100100;

type
  PNode  =^Node;
  Node = record
    next:PNode;
    v:integer;
  end;

var
  n,m,v,i:integer;
  a:array [1..maxn] of pnode;     // списки смежных вершин
  col:array [1..maxn] of integer; // цвета вершин, 0- белая, 1-серая, 2-черная
  dep:array [1..maxn] of integer; // глубина вершины в дереве
  time:integer;
  f:array [1..maxn] of integer;
  nom:array [1..maxn] of integer;
  stack: array [1..maxn] of integer; // массив со стеком для вершин
procedure  add(u,v:integer);
var
  t:pnode;
begin
  new(t);
  t.next:=a[u];
  t.v:=v;
  a[u]:=t;
end;

procedure init;
var
  i,u,v:integer;
begin
  assign(input,'topsort.in');reset(input);
  assign(output,'topsort.out');rewrite(output);
  read(n,m);
  for i:=1 to n do begin
    nom[i]:=i;
  end;
  for i:=1 to m do begin
    read(u,v);
    add(u,v);
  end;
end;

procedure print(a,b:integer);
var
  i:integer;
begin
  writeln('YES');
  for i:=a to b do begin
    write(stack[i],' ');
  end;
  close(output);
  halt(0);
end;

procedure DFS(u:integer);
var
  t:pnode;
begin
  t:=a[u];
  inc(time);
  col[u]:=1;
  while t<>nil do begin
    v:=t.v;
    if col[v]=0 then begin
      DFS(v); 
    end else if (col[v]=1) then begin
      // нашли цикл
      writeln(-1);
      halt;
    end;
    t:=t.next;
  end;
  inc(time);
  f[u]:=time;
  col[u]:=2;
end;

procedure swap(var a,b:integer);
var
  t:integer;
begin
  t:=a;a:=b;b:=t;
end;

procedure qsort(l,r:integer);
var
  i,j,x:integer;
begin
  i:=l;j:=r;x:=f[(l+r) div 2];
  repeat
    while f[i]>x do inc(i);
    while f[j]<x do dec(j);
    if i<=j then begin
      swap(f[i],f[j]);
      swap(nom[i],nom[j]);
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<r then qsort(i,r);
  if j>l then qsort(l,j);
end;

begin
  init;
  for i:=1 to n do begin
    if col[i]=0 then begin
      DFS(i);
    end;
  end;
  qsort(1,n);
  for i:=1 to n do write(nom[i],' ');
  close(output);
end.
