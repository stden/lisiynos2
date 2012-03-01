{$apptype console}
const maxn=100;

var N,M,i,a,b :integer;
    mas : array [1..maxn] of integer;

begin
  assign(input,'light.in'); reset(input);
  assign(output,'light.out'); rewrite(output);
  readln(N,M);
  For i:=1 To m Do Begin
    readln(a,b);
    inc(mas[a]);
    inc(mas[b]);
  End;
  For i:=1 To N-1 Do Write(mas[i],' ');
  Write(mas[N]);
end.