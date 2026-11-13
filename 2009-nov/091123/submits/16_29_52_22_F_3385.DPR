var q, w, r, t, e, a, y, u, i, n : longint;

begin
 reset(input, 'f.in');
 rewrite(output, 'f.out');
 e := 0;
 a := 0;
 y := 0;
 u := 1;
 readln(n);
 for i := 1 to n do
  begin
   q := e;
   w := a;
   r := y;
   t := u;
   e := q * 2 + w;
   a := r;
   y := t;
   u := w + r + t;
  end;
 writeln(e);
end.
end.
