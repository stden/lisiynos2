program f;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  name='Vasiliy Pupkin';
var
  i,j,c,n:integer;
  s:string;
begin
 reset(input,'papiros.in');
 rewrite(output,'papiros.out');
 readln(n);
 c:=-1;
 for i:=1 to n do begin
   readln(s);
   if s=name then inc(c);
 end;
 writeln(c);

end.
 