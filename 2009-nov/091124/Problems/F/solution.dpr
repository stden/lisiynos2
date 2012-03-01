{$APPTYPE CONSOLE}
program z;
var n,i,k:longint;
    s:string;
begin
 assign(input,'papiros.in');
 reset(input);
 assign(output,'papiros.out');
 rewrite(output);
 readln(n);
 k:=-1;
  for i:=1 to n do begin
   readln(s);
    if s='Vasiliy Pupkin' then inc(k);
  end;
 writeln(k);
 readln;
End.

