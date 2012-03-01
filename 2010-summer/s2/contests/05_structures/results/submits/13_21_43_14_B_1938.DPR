program B;

var
  heap: array [1..100000] of LongInt;
  N, I, F, m: LongInt;
  com: char;

procedure swap(n1,n2:LongInt);
var
  t: LongInt;
begin
  t := heap[n1];
  heap[n1] := heap[n2];
  heap[n2] := t;
end;

procedure shift_up(q:Longint);
begin
while (q div 2>=1) and (heap[q div 2] < heap[q]) do begin
  swap(q,q div 2);
  q:=q div 2;
end;
end;

procedure insert(p:LongInt);
begin
   inc(m);
   heap[m]:=p;
   shift_up(m);
end;

procedure shift_down(q: LongInt);
var
  mi: LongInt;
begin
  while true do
  begin
    mi := q;
    if (2 * q <= N) and (heap[2 * q] > heap[mi]) then
      mi := 2 * q;
    if (2 * q + 1 <= N) and (heap[2 * q + 1] > heap[mi]) then
      mi := 2 * q + 1;
    if mi = q then
      break
    else
      swap(q, mi);
    q := mi;
  end;
end;

function GetMax: LongInt;
begin
  GetMax := heap[m];
  heap[1] := heap[m];
  dec(m);
  shift_down(1);
end;

begin
  reset(input, 'heap.in');
  rewrite(output, 'heap.out');
  readln(N);
  for I := 1 to N do
  begin
    read(com);
    if com = '0' then
    begin
      read(F);
      insert(F);
    end
    else
      writeln(GetMax)
  end;
end.
