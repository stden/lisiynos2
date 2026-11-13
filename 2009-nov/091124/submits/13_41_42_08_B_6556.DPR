program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var k:int64;
   i,j,n:integer;
    a:array[1..101,1..101] of int64;
    sum:array[1..101] of int64;
begin
   assign(input,'unreal.in');
   reset(input);
   assign(output,'unreal.out');
   rewrite(output);
     read(n);
     k:=1;
      for i:=1 to n do begin sum[i]:=0;
      for j:=1 to (n-1) do begin
        read(a[i,j]);
       sum[i]:=a[i,j]+sum[i];
       {write(sum[i],' ');}
        end; end;
      for i:=1 to n do begin
        if sum[i]<sum[i-1] then k:=i;
         end;
      write(k);
      close(input);
      close(output);
end.

