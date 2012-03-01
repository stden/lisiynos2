program cicle_ash_bad;

{$APPTYPE CONSOLE}

const
  maxn = 100000;

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
  assign(input,'cycle.in');reset(input);
  assign(output,'cycle.out');rewrite(output);
  read(n,m);
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

procedure DFS(u:integer;d:integer);
var
  t:pnode;
begin
  t:=a[u];
  dep[u]:=d;
  stack[d]:=u;
  col[u]:=1;
  while t<>nil do begin
    v:=t.v;
    if col[v]=0 then begin
      DFS(v,d+1);
    end else if (col[v]<>0) then begin
      // нашли цикл
      print(dep[v],dep[u]);
    end;
    t:=t.next;
  end;
  col[u]:=1;
end;

begin
  init;
  for i:=1 to n do begin
    if col[i]=0 then begin
      DFS(i,1);
    end;
  end;
  writeln('NO');
  close(output);
end.
