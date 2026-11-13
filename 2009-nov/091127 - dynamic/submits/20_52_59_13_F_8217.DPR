
{$apptype console}
var n,i:integer;
    a:int64;

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
    read(n); dec(n);
    a:=0;
    For i:=2 To n Do begin
      a:=2*a+step(i-3);
    end;
    writeln(a);
end.