{$APPTYPE CONSOLE}
uses SysUtils;


var i, s : integer;
n : array [1..4] of integer;
z : array [0..16] of char;
c : char;
begin
 reset(input,'code.in');
 rewrite(output,'code.out');

 z[0] := '0';
 z[1] := '1';
 z[2] := '2';
 z[3] := '3';
 z[4] := '4';
 z[5] := '5';
 z[6] := '6';
 z[7] := '7';
 z[8] := '8';
 z[9] := '9';
 z[10] := 'A';
 z[11] := 'B';
 z[12] := 'C';
 z[13] := 'D';
 z[14] := 'E';
 z[15] := 'F';

 i := 0;

 while not eoln(input) do begin
  inc(i);
  read(c);
  n[i] := (ord(c) and 1) shl (4 - i);
  if i = 4 then begin
   s := n[1] + n[2] + n[3] + n[4];
   write(z[s]);
   i := 0;
   end;
  end;

end.
