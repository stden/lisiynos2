{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses dorand;


procedure ttt (x1, y1, r1, x2, y2, r2:integer);
var cx1, cy1, cr1, cx2, cy2, cr2, t:integer;
    i, j, k, l, m, n, dx, dy, sx, sy:integer;
begin
  for i:=0 to 3 do
    for j:=0 to 3 do
      for k:=0 to 1 do
        for l:=0 to 1 do
          for m:=0 to 1 do
            for n:=0 to 1 do begin
              case i of
              0: dx := 0;
              1: dx := 999;
              2: dx := -999;
              3: dx := random(1999)-999
              end;
              case j of
              0: dy := 0;
              1: dy := 999;
              2: dy := -999;
              3: dy := random(1999)-999
              end;
              sx := 2*k-1;
              sy := 2*l-1;
              cx1:=sx*(x1+dx);
              cy1:=sy*(y1+dy);
              cr1:=r1;
              cx2:=sx*(x2+dx);
              cy2:=sy*(y2+dy);
              cr2:=r2;
              if m=1 then begin t:=cx1; cx1:=cy1; cy1:=t;
                                t:=cx2; cx2:=cy2; cy2:=t
              end;
              if n=1 then begin
                t:=cx1; cx1:=cx2; cx2:=t;
                t:=cy1; cy1:=cy2; cy2:=t;
                t:=cr1; cr1:=cr2; cr2:=t;
              end;
              writeln (cx1, ' ', cy1, ' ', cr1);
              writeln (cx2, ' ', cy2, ' ', cr2);

            end;
end;

begin
  regint (18);
  writeln (256*3);
  ttt (0, 0, 1000, 0, 0, 999);
  ttt (0, 0, 1000, 1, 0, 999);
  ttt (0, 0, 1000, 1, 1, 999);
end.