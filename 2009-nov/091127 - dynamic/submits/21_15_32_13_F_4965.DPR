
{$apptype console}
var n,i:integer;
    a:int64;
    mas:array [0..30] of int64;

Function Step(a:int64):int64;
var k:integer;
    t:int64;
begin
  t:=1;
  For k:=1 To a Do Begin
    t:=t*2;
  end;
  Step:=t;
end;

begin
    assign(input,'f.in'); reset(input);
    assign(output,'f.out'); rewrite(output);
    read(n);
    mas[0]:=0;
    mas[1]:=0;
    mas[2]:=0;
    mas[3]:=1;
    mas[4]:=3;
    For i:=5 To n Do begin
      mas[i]:=2*mas[i-1]+(step(i-4)-mas[i-4]);
    end;
    writeln(mas[n]);
end.