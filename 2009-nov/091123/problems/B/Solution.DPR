program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
    a:array[1..70] of int64;
    n,i:integer;
begin
    assign(input,'b.in');
   reset(input);
   assign(output,'b.out');
   rewrite(output);
    read(n);
     a[1]:=1;
     a[2]:=1;
    for i:=3 to n do begin
      a[i]:=a[i-2]+a[i-1];
      end;
         write(a[n]);
            close(input);
      close(output);
end.
