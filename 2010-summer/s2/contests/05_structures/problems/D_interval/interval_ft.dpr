{$apptype console}
{$o-,r+,q+}
uses
  SysUtils, Math;

const
  maxn = 150000;
  inf = 1000000000;
  size = 262144 * 4;

type
  int = longint;

var
  n : int;
  a : array[1..maxn] of int;
  tree : array[1..size] of int;
  shift : int;
  i : int;

function get(l, r : int) : int;
begin
  if (l > r) then begin
    result := inf;
    exit;
  end;
  if (l + 1 = r) then begin
    result := min(tree[l], tree[r]);
  end else begin
    result := min(min(tree[l], tree[r]), get((l + 1) div 2, (r - 1) div 2));
  end;
end;

function getMin(l, r : int) : int;
begin
  result := get(shift + l, shift + r);
end;

var
  k : int;

begin
  reset(input, 'interval.in');
  rewrite(output, 'interval.out');
  read(n, k);
  for i := 1 to n do begin
    read(a[i]);
  end;
  shift := size div 2 - 1;
  for i := 1 to shift + 1 do begin
    tree[shift + i] := inf;
  end;
  for i := 1 to n do begin
    tree[shift + i] := a[i];
  end;
  for i := shift downto 1 do begin
    tree[i] := min(tree[2 * i], tree[2 * i + 1]);
  end;
  for i := 1 to n - k + 1 do begin
    writeln(getMin(i, i + k - 1));
  end;
end.