program f;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[0..1,1..30]of integer;
    i,n:integer;

begin
    assign(input,'f.in');
    reset(input);
    read(input,n);
    a[0,1]:=1;
    a[1,1]:=1;
    close(input);
    for i:=2 to n-1 do
    begin
    a[0,i]:=a[0,i-1]+a[1,i-1];
    a[1,i]:=a[0,i-1];
    end;
    assign(output,'f.out');
    rewrite(output);
    write(output,(a[0,n-1]+a[1,n-1]));
    close(output);
end.
 