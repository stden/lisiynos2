{ XV Всероссийская олимпиада школьников по информатике       }
{ Задача 6. Чайнворд                                         }
{ Автор: Михаил Климов                                       }
{ Решение: Андрей Пестов                                     }

Const MaxN      = 1000;
      MaxLen    = 250;
      _inf      = 100000;
Type integer    = longint;
     TStr       = string[12];
  Var wrd: array[1..MaxN] of TStr;
      lsch: array[1..MaxN] of char;
      len: array[1..MaxN] of integer;

      phrase: string;
      N: integer;


      aminlen: array['a'..'z', 'a'..'z'] of integer;
      aminls: array['a'..'z', 'a'..'z'] of integer;

      bls, lastw, lastd: array[0..MaxLen, 'a'..'z'] of integer;


procedure prefill;
  var i: integer;
      j, k, p: char;

begin
  fillchar(aminlen, sizeof(aminlen), 0);
  fillchar(aminls, sizeof(aminls), 0);
  for j := 'a' to 'z' do
  for k := 'a' to 'z' do aminlen[j, k] := _inf;

  for i := 1 to N do
    if aminlen[wrd[i, 1], lsch[i]] > len[i] - 1  then begin
      aminlen[wrd[i, 1], lsch[i]] := len[i] - 1;
      aminls[wrd[i, 1], lsch[i]] := -i;
    end;

  for j := 'a' to 'z' do
  for k := 'a' to 'z' do
  for p := 'a' to 'z' do
    if aminlen[k, j] + aminlen[j, p] < aminlen[k, p] then begin
      aminlen[k, p] := aminlen[k, j] + aminlen[j, p];
      aminls[k, p] := ord(j);
    end;
end;

function getpos(t, p, nwrd: integer): integer;
  var i, j: integer;
begin
  i := 1;
  if nwrd <> 0 then inc(i);
  j := 0;
  while (i <= length(wrd[t])) and (p <= length(phrase)) do begin
    if phrase[p] = wrd[t, i] then begin inc(j); inc(p); end;
    inc(i);
  end;

  getpos := j;
end;

procedure recwrd(lf, rg: char);
begin
  if lf = rg then exit;
  if aminls[lf, rg] > 0 then begin
    recwrd(lf, chr(aminls[lf, rg]));
    recwrd(chr(aminls[lf, rg]), rg);
  end else writeln(wrd[-aminls[lf, rg]]);
end;

procedure recout(mlen: integer; lsch: char);
begin
  if lastw[mlen, lsch] = 0 then exit;
  if lastw[mlen, lsch] = -1 then begin
    recout(mlen, chr(lastd[mlen, lsch]));
    recwrd(chr(lastd[mlen, lsch]), lsch);
  end else begin
    recout(mlen - lastd[mlen, lsch], wrd[lastw[mlen, lsch], 1]);
    writeln(wrd[lastw[mlen, lsch]]);
  end;
end;

procedure solve;
  var i, t, a: integer;
      j, k: char;
begin
  prefill;

  fillchar(bls, sizeof(bls), 0);
  for i := 1 to length(phrase) do
  for k := 'a' to 'z' do bls[i, k] := _inf;

  fillchar(lastw, sizeof(lastw), 0);
  fillchar(lastd, sizeof(lastd), 0);

  for i := 0 to length(phrase) do begin
    for j := 'a' to 'z' do
    for k := 'a' to 'z' do
      if bls[i, j] + aminlen[j, k] < bls[i, k] then begin
         bls[i, k] := bls[i, j] + aminlen[j, k];
         lastw[i, k] := -1;
         lastd[i, k] := ord(j);
      end;

    for t := 1 to N do begin
      j := wrd[t, 1];

      if bls[i, j] < _inf then
      for a := 1 to getpos(t, i + 1, i) do
      if bls[i, j] + len[t] - 1 < bls[i + a, lsch[t]] then begin
        bls[i + a, lsch[t]] := bls[i, j] + len[t] - 1;
        lastw[i + a, lsch[t]] := t;
        lastd[i + a, lsch[t]] := a;
      end;
    end;
  end;

  t := length(phrase);
  j := 'a';
  for k := 'a' to 'z' do
  if bls[t, k] < bls[t, j] then j := k;


  if bls[t, j] >= _inf then writeln('?')
  else begin
//    writeln('YES');
//    writeln(bls[t, j] + 1);
    recout(t, j);
  end;
end;

procedure readdata;
  var i: integer;
begin
  fillchar(wrd, sizeof(wrd), 0);

    readln(phrase);
    readln(N);
    for i := 1 to N do begin
      readln(wrd[i]);
      lsch[i] := wrd[i, length(wrd[i])];
      len[i] := length(wrd[i]);
    end;
end;

BEGIN
  assign(input, 'chain.in'); reset(input);
  assign(output, 'chain.out'); rewrite(output);
    readdata;
    solve;
  close(input); close(output);
END.