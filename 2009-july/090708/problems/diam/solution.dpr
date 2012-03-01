{
  Диаметр множества
  Эвристическое решение, сложность O(n)
                                                         (c)2004 Pan Zverski
}

{$apptype console}

Const MaxN = 30000;

var p: array[1..MaxN] of record x, y:integer; end;
    n, i, a, b, best, cur, res, k: integer;

begin
  assign(input,'diam.in'); reset(input);
  assign(output,'diam.out'); rewrite(output);

   randomize;
   read(n);
   for i := 1 to n do with p[i] do read(x, y);
{}
   res := 0;
   for k := 1 to 100 do begin
      a := random(n)+1; b := random(n)+1;
      best := sqr(p[a].x - p[b].x) + sqr(p[a].y - p[b].y);
      for i := 1 to n do begin
         cur := sqr(p[a].x - p[i].x) + sqr(p[a].y - p[i].y);
         if cur > best then begin
            best := cur;
            b := i;
         end else begin
            cur := sqr(p[i].x - p[b].x) + sqr(p[i].y - p[b].y);
            if cur > best then begin
               best := cur;
               a := i;
            end;
         end;
      end;
      if best > res then res := best;
   end;
{}
   writeln(sqrt(res):0:2); 
end.