program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const vas='Vasiliy Pupkin';
var s1,s2,owner:string;
i,n,k:integer;
begin
  reset(input,'papiros.in');
  rewrite(output,'papiros.out');
  readln(n);
  k:=0;
  readln(s1);
  owner:=vas;
  for i:=2 to n do begin
   readln(s2);
   if (s1=owner) and (s2=vas) then inc(k);
   if s1=owner then owner:=s2;
   s1:=s2;
  end;
  writeln(k);
end.
 