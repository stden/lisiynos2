{
  Диаметр множества
  Полный перебор, сложность O(n^2)
                                                         (c)2004 Pan Zverski
}

Const MaxN = 30000;

var p: array[1..MaxN] of record x, y:integer; end;
    n, i, j, best, cur:integer;

begin
   read(n);
   for i := 1 to n do with p[i] do read(x, y);
{}
   best := 0;
   for i := 1 to n - 1 do
      for j := i + 1 to n do begin
         cur := sqr(p[i].x-p[j].x)+sqr(p[i].y-p[j].y);
         if cur > best then best := cur;
      end;
{}
   writeln(sqrt(best):0:2); 
end.