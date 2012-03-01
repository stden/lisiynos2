program connect;

var a:ARRAY[1..100,1..100] of integer;
    b:array[1..100] of boolean;
    j,n,m,x,y,s:integer;

procedure dfs(v:integer);
  var i:integer;
  begin
    b[v]:=true;
    for i:=1 to n do
      begin
        if (b[i]=false) and (a[v,i]=1) then
          dfs(i);
      end;
  end;

  begin
  s:=0;
  assign(input,'connect.in');
  reset(input);
  readln(input,n,m);
    for j:=1 to m do
      begin
        readln(input,x,y);
        a[y,x]:=1;
        a[x,y]:=1;
      end;
    close(input);
    for j:=1 to n do
      begin
        if b[j]=false then
        begin
        dfs(j);
        inc(s);
        end;
      end;
   if (n=0) and (m=0) then s:=1;
   assign(output,'connect.out');
   rewrite(output);
   write(output,s);
   close(output);
end.

