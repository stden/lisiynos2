program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var x1, y1, x2, y2, x3, y3, x4, y4, s : extended;
x, y : array [1..50] of extended;
 jjtz, s1, s2, s3 : string;
n, i, l, k, j : longint;
function ss(q,w, e, r : extended) : extended;
begin
 ss := sqrt(sqr(q - e) + sqr(w - r));
end;

function ger(a, s, d , f, g, h : extended) : extended;
var p, p1, p2, p3 : extended;
begin
 p1 := ss(a, s, d , f);
 p2 := ss(d , f, g, h);
 p3 := ss(a, s, g, h);
 p := (p1 + p2 + p3) / 2;
 ger := sqrt(p * (p - p1) * (p - p2) * (p - p3));
end;

begin
 reset(input, 'triangles.in');
 rewrite(output, 'triangles.out');
 readln(n);
 for i :=1 to n do
  readln(x[i], y[i]);

 s := 99999999999;
 for i := 1 to n do
  for j := 1 to n do
   for k := 1 to n do
    if (ss(x[i], y[i], x[j], y[j]) + ss(x[i], y[i], x[k], y[k]) + ss(x[j], y[j], x[k], y[k]) < s) and (i <> j) and (i <> k) and(k <> j)
     then begin s := ss(x[i], y[i], x[j], y[j]) + ss(x[i], y[i], x[k], y[k]) + ss(x[j], y[j], x[k], y[k]);
       str(i, s1);
       str(j, s2);
       str(k, s3);
       jjtz := s1 + ' ' + s2 + ' ' + s3;
     end;
  writeln(jjtz);

end.
