{$APPTYPE CONSOLE}
uses
  SysUtils;

var
 i, n, j, dd, mm, u, gg : longint;
 a : array [1..500000, 1..2] of extended;
 res : array[1..100000] of longint;
 m, d, day : array [1..100000] of byte;
 me : array [1..12] of byte;
 nm, wday : array [1..100000] of string;
 s : string;
 ddmm : TDateTime;
begin
 reset(input,'hb.in');
 rewrite(output,'hb.out');
 readln(dd, mm, gg);
 readln(n);
 for i := 1 to n do
  readln(d[i], m[i], nm[i]);

 me[1] := 31;
 me[2] := 28;
 me[3] := 31;
 me[4] := 30;
 me[5] := 31;
 me[6] := 30;
 me[7] := 31;
 me[8] := 31;
 me[9] := 30;
 me[10] := 31;
 me[11] := 31;
 me[12] := 31;

 for i := 1 to n do
  if m[i] < mm then begin
   for j := m[i] + 1 to mm - 1 do
    inc(res[i], me[j]);
   inc(res[i], dd);
   inc(res[i], (me[m[i]] - d[i]));
   res[i] := 365 - res[i];

  end else if m[i] > mm then begin
   for j := mm + 1 to m[i] - 1 do
    inc(res[i], me[j]);
   inc(res[i], me[m[i]] - dd);
   inc(res[i], dd);

  end else begin
   res[i] := abs(dd - d[i]);
   if d[i] < dd then res[i] := 365 - res[i];
  end;

  for i := 1 to n do
   for j := 1 to n - 1 do
    if res[j] > res[j + 1] then begin
     u := res[j];
     res[j] := res[j + 1];
     res[j + 1] := u;
     s := nm[j];
     nm[j] := nm[j + 1];
     nm[j + 1] := s;
    end;

 s := '';
 s := s + inttostr(dd) + '.' + inttostr(mm) + '.' + inttostr(gg);
 ddmm := strtodate(s);

 u := DayOfWeek(ddmm);


 for i := 1 to n do begin
  day[i] := u + res[i] mod 7;
  if day[i] <> 7 then day[i] := day[i] mod 7;
  dec(day[i]);
  //writeln(day[i]);
 end;
 for i := 1 to n do begin
  if day[i] = 1 then wday[i] := 'пн';
  if day[i] = 2 then wday[i] := 'вт';
  if day[i] = 3 then wday[i] := 'ср';
  if day[i] = 4 then wday[i] := 'чт';
  if day[i] = 5 then wday[i] := 'пт';
  if day[i] = 6 then wday[i] := 'сб';
  if day[i] = 7 then wday[i] := 'вс';
 end;

 for i := 1 to n do
  writeln(res[i], ' ', wday[i], nm[i]);

 close(input);
 close(output);
end.
