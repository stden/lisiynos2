{$apptype console}
Const MaxN = 1000;

Type TPoint = record x, y: integer; end;

var p: array[1..MaxN] of TPoint;
    bestx, besty, bestr2, x, y, r2: extended;
    a, b, c: TPoint;
    d, b1, b2, dx, dy, n, i, j, k: integer;

function Check(x, y, r2: Extended):boolean;
var i : integer;
begin
   Result := true;
   for i := 1 to n do
      if sqr(p[i].x - x) + sqr(p[i].y - y) > r2 then begin
         Result := false;
         break;
      end;
end;

begin
  assign(input,'garden.in'); reset(input);
  assign(output,'garden.out'); rewrite(output);

   read(n);
   for i := 1 to n do with p[i] do read(x, y);
{}
   bestx := 0; besty := 0; bestr2 := 1e+12;
   for i := 1 to n - 1 do 
      for j := i + 1 to n do begin
         x := 0.5 * (p[i].x + p[j].x);
         y := 0.5 * (p[i].y + p[j].y);
         r2 := sqr(x - p[i].x) + sqr(y - p[i].y);
         if (r2 < bestr2) and Check(x, y, r2) then begin
            bestx := x;
            besty := y;
            bestr2 := r2;
         end;
      end;
   { Описываем окружность вокруг треугольника }
   for i := 1 to n - 2 do begin
      a := p[i];
      for j := i + 1 to n - 1 do begin
         b := p[j];
         for k  := j + 1 to n do begin
            c := p[k];
            d := 4*((c.x-a.x)*(c.y-b.y) - (c.x-b.x)*(c.y-a.y));
            if d <> 0 then begin
               b1 := sqr(c.x) + sqr(c.y) - sqr(a.x) - sqr(a.y);
               b2 := sqr(c.x) + sqr(c.y) - sqr(b.x) - sqr(b.y);
               dx := 2*(b1*(c.y-b.y) - b2*(c.y-a.y));
               dy := 2*(b2*(c.x-a.x) - b1*(c.x-b.x));
               x := dx / d;
               y := dy / d;
               r2 := sqr(a.x - x) + sqr(a.y - y);
               If (r2 < bestr2) and Check(x, y, r2) then begin
                  bestx := x;
                  besty := y;
                  bestr2 := r2;
               end;
            end;
         end;
      end;
   end;
{}
   if abs(bestx)<1e-8 then bestx := 0;
   if abs(besty)<1e-8 then besty := 0;
   writeln(sqrt(bestr2):0:5);
   writeln(bestx:0:5);
   writeln(besty:0:5);
end.