program f;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[0..2,1..30]of int64;
    i,n:longint;
    x:int64;
begin
    assign(input,'f.in');
    reset(input);
    read(input,n);
    a[0,1]:=1;
    a[1,1]:=1;
    a[2,1]:=0;
    close(input);
    x:=2;
    for i:=2 to n do
    begin
    a[0,i]:=a[0,i-1]+a[1,i-1]+a[2,i-1];
    a[1,i]:=a[0,i-1];
    a[2,i]:=a[1,i-1];
    x:=x*2;
    end;
    assign(output,'f.out');
    rewrite(output);
    write(output,x-(a[0,n]+a[1,n]+a[2,n]));
    close(output);
end.
 