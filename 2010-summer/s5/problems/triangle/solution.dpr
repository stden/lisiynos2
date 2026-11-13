{$apptype console}

{$ASSERTIONS ON}
uses SysUtils;

const TaskName = 'triangle';

type
  Point = record
    x, y : extended;
  end;
  Triangle = record
    p1,p2,p3 : Point;
  end;

function Area( P,P1,P2 : Point ):extended;
begin
  Area := (P.x-P1.x)*(P1.y-P2.y)-(P1.x-P2.x)*(P.y-P1.y);
end;

function in_triangle( T : Triangle; P : Point ):Boolean;
var A1,A2,A3 : Extended;
begin
  A1 := Area(P,T.p1,T.p2);
  A2 := Area(P,T.p2,T.p3);
  A3 := Area(P,T.p3,T.p1);
  in_triangle := ((A1 >= 0) and (A2 >= 0) and (A3 >= 0)) or
                 ((A1 <= 0) and (A2 <= 0) and (A3 <= 0));
end;

var
  T : Triangle;
  P : Point;

procedure ReadData;
begin
  read(T.p1.x,T.p1.y);
  read(T.p2.x,T.p2.y);
  read(T.p3.x,T.p3.y);
  read(p.x,p.y);
end;

procedure WriteAnswer;
begin
  if in_triangle(T,P) then
    writeln('YES')
  else
    writeln('NO');
end;

procedure TestArea;
const P1 : Point = ( x:0; y:0 );
      P2 : Point = ( x:1; y:0 );
      P3 : Point = ( x:0; y:1 );
begin
  assert( Area(P1,P2,P3) = 1 );
  assert( Area(P1,P3,P2) = -1 );
  assert( Area(P3,P1,P2) = 1 );
end;

var Tests,Test : integer;
begin
  TestArea;
  Reset(input,TaskName+'.in');
  Rewrite(output,TaskName+'.out');
  Readln(Tests);
  for Test := 1 to Tests do begin
    ReadData;
    WriteAnswer;
  end;
end.
