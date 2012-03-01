program c;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
    b:array[1..70] of int64;
    n,i:integer;
begin
    assign(input,'c.in');
   reset(input);
   assign(output,'c.out');
   rewrite(output);
    read(n);
     b[1]:=1;
     b[2]:=2;
     b[3]:=4;
    for i:=4 to n do begin
      b[i]:=b[i-3]+b[i-2]+b[i-1];
      end;
         write(b[n]);
            close(input);
      close(output);
end.
