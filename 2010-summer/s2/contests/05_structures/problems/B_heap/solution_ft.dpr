{$apptype console}
uses
  SysUtils, Math;

type
  int = longint;

const
  maxn = 100000;
  
var
  n : int;
  t, x : int;
  heap : array[1..maxn] of int;
  size : int;

procedure swap(var a, b : int);
var
  t : int;
begin
  t := a;
  a := b;
  b := t;
end;

procedure siftDown(i : int);
var
  newI : int;
  max : int;
  j : int;
begin
  while (true) do begin
    max := heap[i];
    newI := i;
    j := 2 * i;
    if (j <= size) then begin
       if (heap[j] > max) then begin
         max := heap[j];
         newI := j;
       end;
    end;
    j := 2 * i + 1;
    if (j <= size) then begin
       if (heap[j] > max) then begin
         max := heap[j];
         newI := j;
       end;
    end;
    if (newI = i) then begin
      break;
    end;
    swap(heap[i], heap[newI]);
    i := newI;
  end;
end;

procedure siftUp(i : int);
var
  j : int;
begin
  while (i > 1) do begin
    j := i div 2;
    if (heap[j] > heap[i]) then begin
      break;
    end;
    swap(heap[i], heap[j]);
    i := j;
  end;
end;

procedure init();
begin
  size := 0;
end;

procedure add(x : int);
begin
  inc(size);
  heap[size] := x;
  siftUp(size);
end;

function extract() : int;
begin
  result := heap[1];
  heap[1] := heap[size];
  dec(size);
  siftDown(1);
end;

var
  i, j : int;

begin
  reset(input, 'heap.in');
  rewrite(output, 'heap.out');
  read(n);
  init();
  for i := 1 to n do begin
    read(t);
    if (t = 0) then begin
      read(x);
      add(x);
    end else begin
      writeln(extract());
    end;
  end;
end.