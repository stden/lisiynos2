{ XV Всероссийская олимпиада школьников по информатике       }
{ Задача 6. Чайнворд                                         }
{ Автор: Михаил Климов                                       }
{ Решение: Дмитрий Павлов                                    }

{$Q+,R+,H+}
const
  maxlen = 250;
  inf = 1000000000;
  separator = #13#10;
type int = longint;
var
  s, t, w : string;
  ch, c1, c2, c3, m : char;
  i, j, k, n, wn, nw : int;
  a, b : array[0..maxlen, 'a'..'z'] of int;
  c : array[0..maxlen, 'a'..'z'] of string;
  f : array['a'..'z', 'a'..'z'] of int;
  g : array['a'..'z', 'a'..'z'] of string;
  word : array[1..1000] of string;
begin
  assign(input, 'chain.in');
  reset(input);
  readln(s);
  readln(nw);
  for wn := 1 to nw do
    readln(word[wn]);
  close(input);

  for c1 := 'a' to 'z' do
    for c2 := 'a' to 'z' do
      f[c1][c2] := inf;
  for wn := 1 to nw do
  begin
    w := word[wn];
    k := length(w);
    c1 := w[1];
    c2 := w[k];
    if f[c1][c2] > k - 1 then
    begin
      f[c1][c2] := k - 1;
      g[c1][c2] := separator + w;
    end;
  end;

  for c1 := 'a' to 'z' do
    for c2 := 'a' to 'z' do
      for c3 := 'a' to 'z' do
        if f[c2][c3] > f[c2][c1] + f[c1][c3] then
        begin
          f[c2][c3] := f[c2][c1] + f[c1][c3];
          g[c2][c3] := g[c2][c1] + g[c1][c3];
        end;

  n := length(s);
  for ch := 'a' to 'z' do
    a[0][ch] := 1;
  for i := 1 to n do
    for ch := 'a' to 'z' do
      a[i][ch] := inf;
  a[1][s[1]] := 1;
  b[1][s[1]] := 0;
  c[1][s[1]] := separator + '@';
  for i := 0 to n - 1 do
  begin
    for wn := 1 to nw do
    begin
      w := word[wn];
      j := i + 1;
      for k := 2 to length(w) do
        if j > n then
          break
        else if w[k] = s[j] then
          inc(j);
      dec(j);
      k := a[i][w[1]] + length(w) - 1;
      ch := w[length(w)];
      if a[j][ch] > k then
      begin
         a[j][ch] := k;
         b[j][ch] := i;
         c[j][ch] := separator + w;
      end;
    end;
    for c1 := 'a' to 'z' do
      for c2 := 'a' to 'z' do
      begin
        k := a[i + 1][c1] + f[c1][c2];
        if a[i + 1][c2] > k then
        begin
          a[i + 1][c2] := k;
          b[i + 1][c2] := i + 1;
          c[i + 1][c2] := g[c1][c2];
        end;
      end;
  end;
  m := 'a';
  for ch := 'a' to 'z' do
    if a[n][m] > a[n][ch] then
      m := ch;
  if a[n][m] = inf then
  begin
    assign(output, 'chain.out');
    rewrite(output);
    writeln('?');
    close(output);
    exit;
  end;
  while n > 0 do
  begin
    if c[n][m][length(separator) + 1] <> '@' then
      t := c[n][m] + t;
    ch := c[n][m][length(separator) + 1];
    n := b[n][m];
    m := ch;
  end;
  delete(t, 1, length(separator));
  assign(output, 'chain.out');
  rewrite(output);
  write(t);
  close(output);
end.

