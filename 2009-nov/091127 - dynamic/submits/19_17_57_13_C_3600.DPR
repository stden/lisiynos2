{$apptype console}
var mas:array [1..40] of int64;
    i,n:integer;
begin
    assign(input,'c.in'); reset(input);
    assign(output,'c.out'); rewrite(output);
    read(n);
    mas[1]:=1;
    mas[2]:=2;
    mas[3]:=4;    
    For i:=4 To n Do Begin
      mas[i]:=mas[i-1] + mas[i-2] + mas[i-3];
    end;
    writeln(mas[n]);
end.