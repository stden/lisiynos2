var  x, y, vx, vy, q, w, a, b, s   :single;

begin
 reset(input,'airgun.in');
 rewrite(output,'airgun.out');

 readln(y, vy, vx, x, q, w);

 a := sqrt(vy * vy + 2 * 9.8 * y);
 b := (a - vy) / 9.8;

 s := x + vx * b;
 if (s < (q + w)) and (s > (q - w)) then write('YES')
                                  else write('NO');


end.

