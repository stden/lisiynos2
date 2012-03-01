{$APPTYPE CONSOLE}

uses
  SysUtils;
var j, i, n, y, u, t : longint;
s, q : string;

function f(k : longint) : longint;
var h : string;
begin
 str(k, h);
 if k = 1 then f := 1 else f := f(k - 1) + length(h);
end;



begin
 reset(input,'e.in');
 rewrite(output,'e.out');
 readln(n);
 i := 1;
 u := 0;

 while n > u do begin
  u := u + f(i);
   inc(i);
 end;

 u := f(i);

//теперь йа знаю номер последовательности (u) и еЄ пор€дковый номер (i). „о мне делать?

  //for j := 1 to t do begin

   t := i;
  for j := 1 to t do
   for i := 1 to j do begin
   str(i, q);
   s := s + q;
  end;

 writeln(s[n]);
end.
