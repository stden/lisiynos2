program komponenty;
var a: array[1..100, 1..100] of integer;
    m,n,i,j,k:INTEGER;
    L: REAL;
begin
assign(input,'MATRIX.in');
assign(output,'MATRIX.out');
reset(input);
rewrite(output);
read(n);  K:=0;
for i:=1 to n do
  for j:=1 to n do
  read(a[i,j]);
for i:=1 to n do begin
  for j:=1 to n do begin
  if ((a[j,i]=a[i,j])and(a[i,j]=1)) then
  K:=K+1;  end; end;
  write(output,K);
  END.