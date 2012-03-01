{$APPTYPE CONSOLE}
var
 X: array[1..10000] of real;
 Y: array[1..10000] of real;

function R(X1, Y1, X2, Y2: real): real;
begin
 R:=sqrt(sqr(X2-X1)+sqr(Y2-Y1));
end;

var
 J: longint;
 N, I: longint;
 Temp, Max: real;

begin
assign(input, 'diam.in');
assign(output, 'diam.out');
reset(input);
rewrite(output);
readln(N);
for i:=1 to N do readln(X[i], Y[i]);
for i:=1 to N do begin
 for j:=1 to N do begin
  temp:=R(X[I], Y[I], X[J], Y[J]);
  if Max<Temp then Max:=Temp;
 end;
end;
writeln(Max:0:2);
close(input);
close(output);
end.
