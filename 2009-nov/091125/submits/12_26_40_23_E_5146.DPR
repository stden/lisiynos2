program e;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[-16..16,-16..16]of longint;
    x,y,k,x1,y1,k1:integer;

procedure dfs(x,y,k,g:integer);
    begin
    if g<k then
    begin
    dfs(x-1,y,k,g+1);
    dfs(x+1,y,k,g+1);
    dfs(x,y+1,k,g+1);
    dfs(x,y-1,k,g+1);
    end
    else
    a[x,y]:=a[x,y]+1;
    end;

begin
    assign(input,'e.in');
    reset(input);
    read(input,k1,x1,y1);
    close(input);
    if (x1+y1)>k then a[x1,y1]:=0 else dfs(0,0,k1,0);
    assign(output,'e.out');
    rewrite(output);
    write(output,a[x1,y1]);
    close(output);
end.
 