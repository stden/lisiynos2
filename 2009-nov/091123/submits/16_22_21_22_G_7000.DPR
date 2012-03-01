var t, z, e, q, r, w, n, k, i : longint;

begin
 reset(input, 'g.in');
 rewrite(output,'g.out');
 readln(n, k);
 t := 0;
 z := 0;
 e := k - 1;
 for i := 2 to n do begin
   q := t;
   r := z;
   w := e;
   t := q*k + z;
   z := w;
   e := r * (k - 1) + w * (k - 1);
  end;
 writeln(z + e);
end.
