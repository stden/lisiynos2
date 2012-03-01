var xmin,xmax,ymin,ymax,sum,bestsum,bestx,besty,n,i,curx,cury : longint;
    x,y : array [1..100] of longint;
begin
   assign(input,'h.in');
   assign(output,'h.out');
   reset(input); rewrite(output);
   {}
   read(n);
   xmax := -maxlongint;  ymax := -maxlongint;
   xmin := +maxlongint;  ymin := +maxlongint;
   bestSum := +maxlongint;
   {}
   for i:=1 to n do begin
     read(x[i],y[i]);
     if x[i]<xmin then xmin := x[i];
     if x[i]>xmax then xmax := x[i];
     if y[i]<ymin then ymin := y[i];
     if y[i]>ymax then ymax := y[i];
   end;
   {}
   for curX:=xmin to xmax do
     for curY:=ymin to ymax do begin
       sum := 0;
       for i:=1 to n do
         sum := sum + abs(x[i]-curX) + abs(y[i]-curY);
       if sum <= bestsum then begin
         bestSum := sum;
         bestX := curX;
         bestY := curY;
       end;
     end;
   {}
 { writeln(bestSum,' ',bestX,' ',bestY); }
  writeln(bestSum);
end.
