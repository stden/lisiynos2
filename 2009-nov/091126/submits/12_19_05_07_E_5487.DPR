program Rim;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var n,i,t:integer;
  function perevod(a: Cardinal): String;
const
  max = 13;
  val: array [1..max] of word = (1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000);
  rom: array [1..max] of string[2] = ('I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M');
Var
  b: 1..max;
begin
  Result:='';
  b := max;
  While a > 0 do
  begin
      while  val[b] > a do  dec(b);
      dec (a, val[b]);
      result := result + rom[b];
  end;
end;

begin
 assign(input,'roman.in');reset(input);
 assign(output,'roman.out');rewrite(output);
  read(t);
  for i:=1 to t do begin

  read(n);
  writeln(perevod(n));
  end;
 close(input);
 close(output);
end.
