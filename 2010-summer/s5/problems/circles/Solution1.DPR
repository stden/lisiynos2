program c;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var  n, i, x1, y1, x2, y2, r1, r2 : longint;
s1, s2, d1, x01, x02, y01, y02, x, y : extended;

function ss(q,w, e, r : extended) : extended;
begin
 ss := sqrt(sqr(q - e) + sqr(w - r));
end;

begin
 reset(input, 'circles.in');
 rewrite(output, 'circles.out');
 readln(n);
 for i := 1 to n do begin
  readln(x1, y1, r1);
  readln(x2, y2, r2);
  if ss(x1, y1, x2, y2) > r1 + r2 then writeln('There are no points!!!') else
   if ss(x1, y1, x2, y2) = r1 + r2 then begin
    writeln('There are only 1 of them....');
    s1 := r1 /(r1 + r2) * abs(x1 - x2);
    if x2 >= x1 then x := s1 + x1 else if x1 > x2 then x := x1 - s1;
    s2 := r1 /(r1 + r2) * abs(y1 - y2);
    if y2 >= y1 then y := s2 + y1 else if y1 > y2 then y := y1 - s2;
    writeln(x : 0 : 12);
    writeln(y : 0 : 12);
   end else if (ss(x1, y1, x2, y2) = 0) and (r1 = r2) then writeln('I"can"t count them - too many points :(') else begin
    writeln('There are only 2 of them....');
    s1 := (y2 * y2 + x2 * x2 + r1 * r1 - r2 * r2) / 2;
    s2 := s1 * s1 - y2 * y2 * r1 * r1;
    d1 := x2 * x2 * s1 * s1 - (y2 * y2 + x2 * x2) * s2;
    x01 := (sqrt(d1) - x2 * s1) / (y2 * y2);
    x02 := (0 - sqrt(d1) - x2 * s1) / (y2 * y2);
    y01 := sqrt(r1 * r1 - x01 * x01);
    y02 := sqrt(r1 * r1 - x02 * x02);
    writeln(x01);
    writeln(x02);
    writeln(y01);
    writeln(y02);
   end;
   writeln;
  end;
end.
