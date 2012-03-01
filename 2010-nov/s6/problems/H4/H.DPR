{$APPTYPE CONSOLE}
var sum,bestSum,allSum,bestx,besty,n,i,j : longint;
    x,y : array [1..100] of longint;
begin
  if ParamCount=1 then begin
    assign(input,ParamStr(1));
    assign(output,ParamStr(1)+'.a');
  end else begin
    assign(input,'h.in');
    assign(output,'h.out');
  end;
  reset(input); rewrite(output);
  {}
  read(n);
  {}
  for i:=1 to n do read(x[i],y[i]);
  { calc bestX }
  bestSum := +maxlongint;
  for i:=1 to n do begin
    sum := 0;
    for j:=1 to n do
      sum := sum + abs(x[i]-x[j]);
    if sum < bestSum then begin
      bestSum := sum;
      bestX := x[i];
    end;
  end;
  allSum := bestSum;
  { calc bestY }
  bestSum := +maxlongint;
  for i:=1 to n do begin
    sum := 0;
    for j:=1 to n do
      sum := sum + abs(y[i]-y[j]);
    if sum < bestSum then begin
      bestSum := sum;
      bestY := y[i];
    end;
  end;
  allSum := allSum + bestSum;
  {}
  writeln(allSum{,' ',bestX,' ',bestY});
end.
