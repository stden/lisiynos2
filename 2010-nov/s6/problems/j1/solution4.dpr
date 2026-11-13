uses SysUtils;

const
  cross = 10000;

var
  b, c, d, i, j, n, m, z, edp, carry, dl, e, w: integer;
  a, res: array [0 .. cross] of integer;
  s, s1, st, st1: string;

procedure f(s: string; b: integer);
var
  i, j, carry: integer;
begin
  carry := 0;
  j := 0;
  for i := 1 to cross do
    a[i] := 0;
  for i := length(s) downto 1 do
  begin
    j := j + 1;
    val(s[i], a[j], d);
  end;
  for i := 1 to length(s) + 1 do
  begin
    a[i] := a[i] * b + carry;
    if a[i] > 9 then
    begin
      carry := a[i] div 10;
      a[i] := a[i] mod 10;
    end
    else
      carry := 0;
  end;
end;

begin

  assign(input, 'mul.in');
  reset(input);
  assign(output, 'mul.out');
  rewrite(output);

  readln(st);
  read(st1);
  if (st = '0') or (st1 = '0') then
    write(0)
  else
  begin
    if length(st) > length(st1) then
      dl := length(st)
    else
      dl := length(st1);
    for e := length(st1) downto 1 do
    begin
      val(st1[e], n, d);
      f(st, n);
      for j := (length(st1) + 1 - e) to length(st) + length(st1) do
      begin
        inc(w);
        res[j] := res[j] + a[w];
        if res[j] > 9 then
        begin
          inc(res[j + 1]);
          res[j] := res[j] mod 10;
        end;
      end; {
        for i:=1 to length(st)+1 do
        write(a[i]);
        writeln; }
      w := 0;
    end;
    if res[length(st) + length(st1)] <> 0 then
      for i := (length(st) + length(st1)) downto 1 do
        write(res[i])
      else
        for i := (length(st) + length(st1)) - 1 downto 1 do
          write(res[i]);
  end;

end.
