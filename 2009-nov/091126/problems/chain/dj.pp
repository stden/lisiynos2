{ XV Всероссийская олимпиада школьников по информатике       }
{ Задача 6. Чайнворд                                         }
{ Автор: Михаил Климов                                       }
{ Решение: Павел Маврин                                      }

const
  maxn = 1000;
  maxm = 250;
  maxl = 10;

  inf = maxm * (ord('z') - ord('a') + 1) * maxl;

var
  di, frn, frw: array[0..maxm,'a'..'z'] of longint;
  d: array[1..maxn] of string;
  z: array[0..maxm, 'a'..'z'] of boolean;
  frc: array[0..maxm, 'a'..'z'] of char;
  n, m: longint;
  w: string;

procedure writesol(n: longint; c: char);
begin
  if frn[n, c]>=0 then begin
    writesol(frn[n, c], frc[n, c]);
    write(d[frw[n, c]],' ');
{    writeln(n,' ',c);}
  end;
end;

function getcom(q: longint; s2: string): longint;
var
  i, j, k: longint;
begin
{  write(copy(w, q, 1000),' ',s2,' ');}
  j:=q;
  k:=0;
  for i:=2 to length(s2) do begin
    if s2[i] = w[j] then begin
      inc(k);
      inc(j);
      if j>m then break;
    end;
  end;
{  writeln(k);}
  getcom:=k;
end;

var
  i, j, k, l: longint;
  c: char;
  com: array[0..1000,0..1000] of longint;
  nn, min, minn: longint;
  nc, minc: char;



begin
  assign(input,'chain.in');
  reset(input);
  assign(output,'chain.out');
  rewrite(output);

  readln(w);
  readln(n);


  for i:=1 to n do readln(d[i]);

  m:=length(w);

  for i:=1 to maxm do begin
    for c:='a' to 'z' do begin
      di[i, c] := inf;
    end;
  end;

  for c:='a' to 'z' do begin
    di[0, c]:=0;
    frn[0, c]:=-1;
  end;
  di[1, w[1]]:=0;
  frn[1, w[1]]:=-1;

  for i:=0 to m-1 do begin
    for j:=1 to n do begin
      com[i, j] := getcom(i+1, d[j]);
    end;
  end;


  while true do begin

    min:=inf;
    for i:=0 to m-1 do begin
      for c:='a' to 'z' do if not z[i, c] then begin
        if di[i, c] < min then begin
          min := di[i, c];
          minn := i;
          minc := c;
        end;
      end;
    end;

    if min = inf then break;

    z[minn, minc] := true;
    for i:=1 to n do if d[i][1] = minc then begin
      nn := minn + com[minn, i];
      nc := d[i][length(d[i])];
      if di[nn, nc] > di[minn, minc] + length(d[i]) - 1 then begin
        di[nn, nc] := di[minn, minc] + length(d[i]) - 1;
        frn[nn, nc] := minn;
        frc[nn, nc] := minc;
        frw[nn, nc] := i;
      end;
    end;

  end;

  min := inf;

  for c := 'a' to 'z' do begin
    if di[m, c] < min then begin
      minc := c;
      min := di[m, c];
    end;
  end;

  if min = inf then begin
    writeln('?');
    close(output);
    halt;
  end;

  writesol(m, minc);
  close(output);
end.
