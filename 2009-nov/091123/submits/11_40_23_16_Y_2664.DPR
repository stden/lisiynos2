program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i,j:integer;
  stroka: string;

begin
  reset(input, 'y.in');
  rewrite(output, 'y.out');
  read(stroka);
  n:=length(stroka);
  for i := 0 to length(stroka) do
  begin
    j:=length(stroka) - i;
    write(stroka[j]);
    n:=n-1;
    if n=0 then halt;

  end;
end.
