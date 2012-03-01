program connect;

Var a:ARRAY[1..100,1..100] of integer;
    b:array[1..100] of boolean;
    j,n,m,x,y,s:integer;

Procedure dfs(v:integer);
  Var i:integer;
  Begin
    b[v]:=true;
    For i:=1 to n do
      Begin
        If (b[i]=false) and (a[v,i]=1) then
          dfs(i);
      End;
  End;

  Begin
  s:=0;
  assign(input,'connect.in');
  reset(input);
  readln(input,n,m);
    For j:=1 to m do
      Begin
        readln(input,x,y);
        a[y,x]:=1;
        a[x,y]:=1;
      End;
    close(input);
    For j:=1 to n do
      Begin
        If b[j]=false then
        Begin
        dfs(j);
        inc(s);
        End;
      End;
   If (n=0) and (m=0) then s:=1;
   assign(output,'connect.out');
   rewrite(output);
   write(output,s);
   close(output);
End.

