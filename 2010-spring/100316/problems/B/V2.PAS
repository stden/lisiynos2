{Volodya Umnov. Solution 2}
CONST maxl=50;
      maxp=100;
VAR n, m                : integer;
    a                   : array [1..maxp, 1..maxl] of boolean;
    b                   : array [1..maxp] of integer;

    i, j, k             : integer;

procedure proc(o : integer);
var i, j, p : integer;
begin
  for p := 1 to n do if b[p] = o then
    for i := 1 to maxl do
      if a[p, i] then
        for j := 1 to n do if (b[j] = 0) and a[j, i] then
          b[j] := o + 1;
end;

BEGIN

  fillchar(a, sizeof(a), false);
  fillchar(b, sizeof(b), 0);

  b[1] := 1;

  assign(input, 'b.in');
  reset(input);
  read(n);
  for i := 1 to n do begin
    read(m);

    if (i = 1) and (m = 0) then
      b[1] := 0;

    for j := 1 to m do begin
      read(k);
      a[i, k] := true;
    end;
  end;
  close(input);



  for i := 1 to n do
    proc(i);


  assign(output, 'b.out');
  rewrite(output);
  k := 0;
  for i := 1 to n do
    if b[i] > 0 then inc(k);
  write(k);
  close(output);

END.