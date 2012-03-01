program f;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
 b:array[1..30] of int64;
    n,i:integer;
begin
    assign(input,'f.in');
   reset(input);
   assign(output,'f.out');
   rewrite(output);
    read(n);
     {b[1]:=1;
     b[2]:=2;
     b[3]:=4; }
       n:=n-1;
       b[1]:=2;
        for i:=2 to n do begin
      b[i]:=b[i-1]*2;
      end;
         write(b[n]);
            close(input);
      close(output);
end.
