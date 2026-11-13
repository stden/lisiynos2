{
  Решение к задаче "C. Сумма простых"
  Автор: Степуленок Д.О.
}

{$APPTYPE CONSOLE}

uses SysUtils;

const MaxN = 1000000;

var
  a : array [2..MaxN] of boolean;
  i,q : integer;
  T1 : TTimeStamp;
begin
  assign(output,'simple.txt'); rewrite(output);
  T1 := DateTimeToTimeStamp(Now);
  {}
  fillChar(a,sizeOf(a),true);
  for i:=2 to MaxN do
    if a[i] then begin
{      writeln(i);}
      q:=i+i;
      while q<=MaxN do begin
        a[q]:=false;
        q:=q+i;
      end;
    end;
  {}
  for i:=4 to MaxN do
    if a[i-2] and a[i] then
      writeln(2,' ',i);
  close(output);
  Writeln( ((DateTimeToTimeStamp(Now).Time - T1.Time)/1000):0:2 );
end.