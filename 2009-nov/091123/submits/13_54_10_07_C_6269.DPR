program osnova;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var s:array[0..40] of int64;
i,n:longint;
begin
 reset(input,'c.in');
 rewrite(output,'c.out');
 read(n);
 s[0]:=1;
 s[1]:=1;
 s[2]:=2;
 for I := 3 to n do
 s[i]:=s[i-1]+s[i-2]+s[i-3];


 write(s[n]);

end.
