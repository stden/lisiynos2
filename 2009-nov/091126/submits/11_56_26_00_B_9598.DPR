{$apptype console}
const maxn=100;

var N,i,j,otv :integer;
    mas : array [1..maxn] of array [1..maxn] of integer;
    col : array [1..maxn] of integer;
begin
  assign(input,'color.in'); reset(input);
  assign(output,'color.out'); rewrite(output);
  readln(N);
  For i:=1 To N Do begin
    For j:=1 To N Do Read(mas[i,j]);
    readln;
  end;
  For i:=1 To N Do Read(col[i]);
  otv:=0;
  For i:=1 To N Do
    For j:=i+1 To N Do
      if (mas[i,j]=1) and (col[i]<>col[j]) Then inc(otv);
  WriteLn(otv);
end.