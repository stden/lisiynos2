program f;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
 b,c:array[0..30] of int64;
    n,i,l,k:integer;
begin
    assign(input,'f.in');
   reset(input);
   assign(output,'f.out');
   rewrite(output);
    read(n);
     b[0]:=0;
     b[2]:=3;
     b[1]:=2;
     b[3]:=5;
     b[4]:=8;
if n<5 then begin
        if n=1 then begin  write(0); end;
        if n=2 then begin  write(1); end;
        if n=3 then begin  write(3); end;
        if n=4 then begin  write(8); end;
            end
       else begin
     for i:=5 to n do begin
        b[i]:=b[i-1]+b[i-2]+b[i-3];  end;
       c[0]:=1;
     for i:=1 to n do
      c[i]:=c[i-1]*2;
        k:=c[n]-b[n];
         write(k);
            end;
          close(input);
      close(output);
end.
