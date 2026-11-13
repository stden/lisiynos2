{$apptype console}

var n,i,j:integer;
    mas,rmas:array [0..50] of array [0..50] of int64;
begin
    assign(input,'d.in'); reset(input);
    assign(output,'d.out'); rewrite(output);
    readln(n);
    for i:=0 To n DO
      for j:=0 To n do mas[i,j]:=0;
    For i:=1 To n Do begin
      For j:=1 To n Do Begin
        read(mas[i,j]);
      end;
      readln;
    end;
    for i:=0 To n DO
      for j:=0 To n do rmas[i,j]:=-1;
    rmas[1,1]:=mas[1,1];
      For i:=1 To N Do Begin
        For j:=1 To N Do Begin
          If (rmas[i-1,j]<>rmas[i,j-1]) and (rmas[i-1,j]<>-1) Then begin
            if (rmas[i-1,j]>rmas[i,j-1]) Then rmas[i,j]:=rmas[i-1,j] + mas[i,j]
            else rmas[i,j]:=rmas[i,j-1] + mas[i,j];
          end else begin
            if (rmas[i-1,j]<>-1) Then rmas[i,j]:=rmas[i-1,j] + mas[i,j];
            if (rmas[i,j-1]<>-1) Then rmas[i,j]:=rmas[i,j-1] + mas[i,j];
          end;
        end;
      end;
    writeln(rmas[n,n]);
end.