{$APPTYPE CONSOLE}
USES TestLib;
const
  MaxWords   = 10000;
  MaxWordLen = 100;
  MaxMsgLen  = 1000;
  _inf = 50000000;


type 
  string = ansistring;
  char = ansichar;


var
   wrd: array [1..MaxWords] of string;
   N: integer;
   msg: array [1..MaxMsgLen] of char;
   pos: array [0..MaxMsgLen] of boolean;
   cnt: integer;

   curlen, anslen: longint;

function int2Str(p: integer): string;
  var s : string;
begin
  str(p, s);
  int2Str := s;
end;

function isnext(const a, b: string): boolean;
begin
  isnext := (a[length(a)] = b[1]);
end;

procedure readdata;
  var i: integer;
begin
  fillchar(msg, sizeof(msg), 0);
  inf.Skip(Blanks);

  cnt := 0;
  while not inf.Eoln do begin
    inc(cnt);
    msg[cnt] := inf.NextChar; // .ReadChar;
  end;
  inf.Skip(Blanks);
  N := inf.readlongint;
  for i := 1 to N do
    wrd[i] := inf.ReadWord(NumberBefore, NumberAfter,false);

  anslen := ans.ReadLongint;
  fillchar(pos, sizeof(pos), 0);
  pos[0] := true;
end;

function found(const s: string): boolean;
  var lf, rg, cc: integer;
begin
  lf := 1; rg := N;
  while lf < rg do begin
    cc := (lf + rg) shr 1;
    if wrd[cc] < s then lf := cc + 1
       else rg := cc;
  end;

  found := wrd[lf] = s;
end;

function howgeneral(const s: string; k: integer; ppfs: boolean): integer;
  var i, j: integer;
begin
  i := 1;
  if not ppfs then i := 2;  
  j := 0;
  while (i <= length(s)) and (k <= cnt) do begin
    if s[i] = msg[k] then begin inc(j); inc(k); end;
    inc(i);
  end;
  howgeneral := j;
end;

procedure tryadd(const s: string; const k: integer; ppfs: boolean);
  var
      i, j, p: integer;
begin
  if not found(s) then QUIT(_wa, 'Слово N ' + int2Str(k) + ' ("' + s + '") неизвестно');
  curlen := curlen + length(s) - 1;

  for i := cnt downto 0 do
    if pos[i] then begin
      j := howgeneral(s, i + 1, ppfs);
      for p := 1 to j do pos[i + p] := true;
    end;
  if curlen > anslen*10 then QUIT(_wa, 'Даже часть чайнворда в 10 раз больше оптимума, ' +  int2Str(anslen));  
end;

procedure check;
  var i: integer;
      lsch: char;
      s: string;
begin

  s := ouf.ReadWord(NumberBefore, NumberAfter,false);
  if s = '?' then begin
    if anslen = -1 then QUIT(_OK, 'Решения не существует')
       else QUIT(_wa, 'Решение существует');
  end;

  if s = '' then QUIT(_pe, 'Пустой файл');
  if anslen = - 1 then anslen := _inf;

  i := 1;
  tryadd(s, i, true);
  lsch := s[length(s)];
  curlen := length(s);

  while not ouf.SeekEof do begin
    inc(i);
    s := ouf.ReadWord(NumberBefore, NumberAfter,false);
    if s[1] <> lsch then QUIT(_wa, 'Неправилен переход со слова N' + int2str(i - 1));
    tryadd(s, i, false);
    lsch := s[length(s)];
  end;

  if not pos[cnt] then QUIT(_wa, 'Участник так и не сконструировал слоган');
  if curlen = anslen then QUIT(_ok, 'Ответ: ' + int2Str(anslen));
  if anslen = _inf then QUIT(_FAIL, 'Странно, найдено решение:' + int2Str(curlen));
  if curlen < anslen then QUIT(_FAIL, 'Решение участника лучше:' + int2Str(curlen) + ' < ' + int2Str(anslen));
  if curlen > anslen then QUIT(_wa, 'длина неоптимальна: ' + int2Str(curlen) + ' > ' + int2Str(anslen));  
end;

var md: string = '';
    tm: string = '';

procedure qsort(lf, rg: integer);
  var i, j: integer;
begin
  if lf >= rg then exit;
  i := lf; j := rg; md := wrd[(lf + rg) shr 1];
  repeat
    while (md > wrd[i]) do inc(i);
    while (md < wrd[j]) do dec(j);
    if i <= j then begin
      tm := wrd[i]; wrd[i] := wrd[j]; wrd[j] := tm; 
      inc(i); dec(j);
    end;
  until i > j;
  
  qsort(lf, j);
  qsort(i, rg);
end;

BEGIN
  readdata;
  qsort(1, N);
  check;
END.
