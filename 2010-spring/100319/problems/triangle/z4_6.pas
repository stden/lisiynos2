{$A+,B-,D+,E-,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}

{ $DEFINE DEBUG$}

const
  nMax = 20;
  eps = 0.0000001;

type
  tPoint = record
             x, y : extended;
           end;
  tCircle = record
              c : tPoint;
              r : extended;
            end;
  tLine = record
            A, B, C : extended;
          end;
  tBelongs = set of 1..nMax;

var
  c : array[1..nMax] of tCircle;
  points : array[0..6*nMax*nMax+1] of tPoint;
  belongs : array[0..6*nMax*nMax+1] of tBelongs;
  N, cntPoints, cntGood : integer;
  square : extended;

function Equal(const a, b : extended) : boolean;
begin
  Equal := abs(a-b) < eps
end;

function LEqual(const a, b : extended) : boolean;
begin
  LEqual := (a-b) <= Eps;
end;

procedure init;
var
  i, j : integer;
  fl : boolean;
begin
  assign(input, 'input.txt');
  reSet(input);
{$IFNDEF DEBUG}
  assign(output, 'output.txt');
  reWrite(output);
{$ENDIF}

  read(N);
  i := 1;
  while i <= N do begin
    read(c[i].c.x, c[i].c.y, c[i].r);
    fl := false;
    for j := 1 to i-1 do
      if Equal(c[i].c.x, c[j].c.x) and Equal(c[i].c.y, c[j].c.y) and
         Equal(c[i].r, c[j].r) then
        fl := true;

    if fl then
      dec(N)
    else
      inc(i);
  end;
end;

procedure addPoint(const p : tPoint; const s : tBelongs);
begin
  inc(cntPoints);
  points[cntPoints] := p;

  belongs[cntPoints] := belongs[cntPoints] + s;
end;

function distance(const p1, p2 : tPoint) : extended;
begin
  distance := sqrt(sqr(p1.x-p2.x) + sqr(p1.y-p2.y));
end;

procedure putSegment(c : tPoint; line : tLine; len, len1 : extended;
                     var p1, p2 : tPoint);
var
  line1 : tLine;
  p : tPoint;
  norm : extended;
begin
  p.x := c.x-line.B*len;
  p.y := c.y+line.A*len;

  with line1 do begin
    A := -line.B;
    B := line.A;
    C := -A*p.x-B*p.y;
    norm := sqrt(sqr(A)+sqr(B));
    A := A/norm; B := B/norm; C := C/norm;
  end;

  p1.x := p.x-line1.B*len1;
  p1.y := p.y+line1.A*len1;
  p2.x := p.x+line1.B*len1;
  p2.y := p.y-line1.A*len1;
end;

procedure buildLine(p1, p2 : tPoint; var line: tLine);
var
  norm : extended;
begin
  if Equal(p1.x, p2.x) and Equal(p1.y, p2.y) then begin
    p1.x := p1.x + random+1;
    p1.y := p1.y + random+1;
  end;

  with line do begin
    A := p2.y-p1.y;
    B := p1.x-p2.x;
    C := p2.x*p1.y-p1.x*p2.y;

    norm := sqrt(sqr(A)+sqr(B));
    A := A / norm;
    B := B / norm;
    C := C / norm;
  end;
end;

function intersectCircles(c1, c2 : tCircle; var p1, p2, p3, p4 : tPoint) : boolean;
var
  temp : tCircle;
  cos, dist, proj, proj1 : extended;
  line : tLine;
begin
  if c1.r < c2.r then begin
    temp := c1; c1 := c2; c2 := temp;
  end;

  dist := distance(c1.c, c2.c);
  if (dist > c1.r+c2.r) or (dist+c2.r < c1.r) then
    intersectCircles := false
  else begin
    intersectCircles := true;
    cos := (sqr(dist)+sqr(c1.r)-sqr(c2.r))/(2*dist*c1.r);
    proj := c1.r*cos;
    proj1 := c1.r*sqrt(1-sqr(cos));
    buildLine(c1.c, c2.c, line);
    putSegment(c1.c, line, proj, proj1, p1, p2);
    putSegment(c1.c, line, -proj, proj1, p3, p4);
  end;
end;

procedure intersectLineCircle(const line : tLine; const c : tCircle;
                              var p1, p2 : tPoint);
begin
{$IFDEF DEBUG}
  if not Equal(line.A*c.c.x+line.B*c.c.y+line.C, 0) then
    runError(111);
{$ENDIF}

  p1.x := c.c.x-c.r*line.B;
  p1.y := c.c.y+c.r*line.A;
  p2.x := c.c.x+c.r*line.B;
  p2.y := c.c.y-c.r*line.A;
end;

function onCircle(p : tPoint; k : integer) : boolean;
begin
  onCircle := Equal(sqr(p.x-c[k].c.x)+sqr(p.y-c[k].c.y), sqr(c[k].r))
end;

procedure intersect(var i, j : integer);
var
  p1, p2, p3, p4 : tPoint;
  line : tLine;
begin
  if (i <> j) and intersectCircles(c[i], c[j], p1, p2, p3, p4) then begin
    if onCircle(p1, i) and onCircle(p1, j) then
      addPoint(p1, [i, j]);
    if onCircle(p2, i) and onCircle(p2, j) then
      addPoint(p2, [i, j]);
    if onCircle(p3, i) and onCircle(p3, j) then
      addPoint(p3, [i, j]);
    if onCircle(p4, i) and onCircle(p4, j) then
      addPoint(p4, [i, j]);
  end;

  buildLine(c[i].c, c[j].c, line);
  intersectLineCircle(line, c[i], p1, p2);
  addPoint(p1, [i]);
  addPoint(p2, [i]);
  intersectLineCircle(line, c[j], p1, p2);
  addPoint(p1, [j]);
  addPoint(p2, [j]);
end;

function goodPoint(const p : tPoint) : boolean;
var
  i : integer;
begin
  for i := 1 to N do
    if not LEqual(sqr(p.x-c[i].c.x) + sqr(p.y-c[i].c.y), sqr(c[i].r)) then begin
      goodPoint := false;
      exit;
    end;
  goodPoint := true;
end;

function Angle(const x, y : extended) : extended; assembler;
asm
  fld y
  fld x
  fpatan
  fwait
end;

procedure Sort;
var
  med, temp : tPoint;
  tempB : tBelongs;
  i, j : integer;
begin
  med.x := 0; med.y := 0;
  for i := 1 to cntGood do begin
    med.x := med.x+points[i].x;
    med.y := med.y+points[i].y;
  end;
  med.x := med.x/cntGood;
  med.y := med.y/cntGood;

  for i := 1 to cntGood-1 do
    for j := i+1 to cntGood do
      if Angle(points[i].x-med.x, points[i].y-med.y) > Angle(points[j].x-med.x, points[j].y-med.y) then begin
        temp := points[i];
        points[i] := points[j];
        points[j] := temp;
        tempB := belongs[i];
        belongs[i] := belongs[j];
        belongs[j] := tempB;
      end;
end;

function squareArc(const c : tCircle; const p1, p2 : tPoint) : extended;
var
  alpha : extended;
begin
  alpha := abs(Angle(p1.x-c.c.x, p1.y-c.c.y)-Angle(p2.x-c.c.x, p2.y-c.c.y));
  if alpha > pi then
    alpha := 2*pi-alpha;

  squareArc := c.r*c.r*alpha/2;
end;

procedure Delete;
var
  i, j : integer;
begin
  i := 1;
  while i <= cntGood-1 do begin
    if Equal(points[i].x, points[i+1].x) and Equal(points[i].y, points[i+1].y) then begin
      belongs[i] := belongs[i] + belongs[i+1];
      for j := i+1 to cntGood-1 do begin
        points[j] := points[j+1];
        belongs[j] := belongs[j+1];
      end;
      dec(cntGood)
    end
    else
      inc(i);
  end;

  if Equal(points[1].x, points[cntGood].x) and Equal(points[1].y, points[cntGood].y) then
    dec(cntGood);
end;

function squareTriangle(const p1, p2, p3 : tPoint) : extended;
begin
  squareTriangle := abs(p1.x*(p2.y-p3.y)+p2.x*(p3.y-p1.y)+p3.x*(p1.y-p2.y))/2;
end;

procedure findSquare;
var
  i, j, k : integer;
  sec : tBelongs;
begin
  points[cntGood+1] := points[1];
  belongs[cntGood+1] := belongs[1];
  square := 0;
  for i := 1 to cntGood-1 do
    square := square+squareTriangle(points[1], points[i], points[i+1]);

  for i := 1 to cntGood do begin
    sec := belongs[i]*belongs[i+1];
    if sec = [] then
      runError(112);
    k := 0;
    for j := 1 to N do
      if (j in sec) then begin
{$IFDEF DEBUG}
        if k <> 0 then
          runError(113);
{$ENDIF}
        k := j;
{$IFNDEF DEBUG}
        Break;
{$ENDIF}
      end;

    square := square + squareArc(c[k], points[i], points[i+1]) -
              squareTriangle(c[k].c, points[i], points[i+1]);
  end;
end;

procedure solve;
var
  i, j : integer;
begin
  randomize;
  fillChar(points, sizeOf(points), 0);
  fillChar(belongs, sizeOf(belongs), 0);

  cntPoints := 0;
  for i := 1 to N do
    for j := 1 to N do
      intersect(i, j);

  cntGood := 0;
  for i := 1 to cntPoints do
    if goodPoint(points[i]) then begin
      inc(cntGood);
      points[cntGood] := points[i];
      belongs[cntGood] := belongs[i];
    end;

  if cntGood = 0 then
    writeLn(0)
  else begin
    Sort;
    Delete;
    findSquare;

    writeLn(square:0:8);
  end;
end;

Begin
  init;
  solve;
End.
