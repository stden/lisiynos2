{$O+,Q+,R+}
unit TestSysTime;

interface
uses Windows, Sysutils;

const InvalidDateTime = -1;
      UnknownDateTime = 0;
      MaxTimeError    = 2;    { difference of 2 seconds is fatal! }
var StartDelta, AddDelta  : TDateTime;
    TickDelta             : int64;

type ETimeError = class (Exception);

function GetTimeDiff : TDateTime;
function CheckTime : boolean;

function MyGetTickCount : int64;
function MyNow : TDateTime;
function MyDateTimeToStr (x : TDateTime) : string; {dd.mm.yyyy hh:mm:ss}
function ShortTimeToStr (x : TDateTime) : string;
function MyFixedStrToDateTime (const S : String) : TDateTime;
function MyStrToDateTime (const S : String) : TDateTime;

type PTimedEvent = ^TTimedEvent;
     TTimedEvent = object
                     interval, next  : TDateTime;
                     constructor newCycledEvent (int : TDateTime);
                     function poll : boolean;
                   end;

implementation
const F1 = 86400 * 1000;
      F2 = 1.0 / F1;
      MaxGTI = 10000*60*1000;  {10000 minutes}
      MinT = 365.25 * 80;
      MaxT = 365.25 * 130;

type cumma = array [0..12] of integer;
const
  cummo : cumma = (0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365);
  cumml : cumma = (0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366);

constructor TTimedEvent.newCycledEvent (int : TDateTime);
begin
  next := 0;
  interval := int * (1/86400)
end;

function TTimedEvent.poll : boolean;
var T : TDateTime;
begin
  T := MyNow;
  Result := (T >= next);
  if Result and (interval > 0) then next := T + interval
end;

var PrevGTC : cardinal;

function MyGetTickCount : int64;
var TC, Diff : cardinal; F : boolean;
begin
  TC := GetTickCount;
  if TC >= PrevGTC then begin
    Diff := TC - PrevGTC;
    F := (Diff > MaxGTI)
  end else begin
    F := (TC > MaxGTI) or (PrevGTC < $ffffffff - MaxGTI);
    if not F then begin
      inc (TickDelta, $100000000);
      Diff := ($ffffffff - PrevGTC) + TC + 1;
      F := (Diff > MaxGTI)
    end
  end;
  if F then begin
    raise ETimeError.Create ('Time error: internal timer shifted (?)');
    Result := -1;
    exit
  end;
  PrevGTC := TC;
  MyGetTickCount := TickDelta + TC
end;

function MyNow : TDateTime;
begin
  Result := StartDelta + MyGetTickCount * F2
end;

function GetTimeDiff : TDateTime;
begin
  Result := Now - (StartDelta + AddDelta + MyGetTickCount * F2);
end;

function CheckTime : boolean;
begin
  Result := (abs(GetTimeDiff) < MaxTimeError / 86400)
end;

var keep_d, keep_m, keep_y,
    today_d, today_m, today_y, pred_day, pred_sec   : integer;
    today_str                                       : string;

function iDateToStr (x : integer) : string;
var yp, yc, y, m, d : integer;
begin
  dec (x, 367);
  yp := x div (4*365+1);
  x := x - (4*365+1)*yp;
  yc := x div 365;
  if yc > 3 then yc := 3;
  x := x - 365*yc;
  y := 1901 + yp*4 + yc;
  m := 1;
  if yc < 3 then begin
    while cummo[m] <= x do inc (m);
    d := x - cummo[m-1] + 1
  end else begin
    while cumml[m] <= x do inc (m);
    d := x - cumml[m-1] + 1
  end;
  keep_d := d;  keep_m := m;  keep_y := y;
  Result := format ('%.2d.%.2d.%.4d', [d, m, y])
end;

function iTimeToStr (x : integer) : string;
var h, m, s : integer;
begin
  h := x div 3600;
  x := x - 3600 * h;
  m := x div 60;
  s := x - 60 * m;
  Result := format ('%.2d:%.2d:%.2d', [h, m, s])
end;

procedure CalcToday;
var cd : integer; x : extended;
begin
  x := MyNow;
  cd := trunc (x);
  pred_sec := trunc ((x-cd)*86400);
  if cd = pred_day then exit;
  today_str := iDateToStr (cd);
  today_d := keep_d;
  today_m := keep_m;
  today_y := keep_y;
  pred_day := cd;
end;

function MyDateTimeToStr (x : TDateTime) : string;
var y, z : integer;
begin
  if x = 0  then begin Result := 'undefined'; exit end;
  if x = -1 then begin Result := 'invalid'; exit end;
  if (x < MinT) or (x > MaxT) then
    raise ETimeError.CreateFmt ('Unable to convert time %f', [x]);
  x := x + 1e-10;
  y := trunc (x);
  z := trunc ((x-y)*86400);
  Result := iDateToStr (y) + ' ' + iTimeToStr (z)
end;

function ShortTimeToStr (x : TDateTime) : string;
begin
  if x = 0 then begin Result := '0'; exit end;
  if x = -1 then begin Result := 'invalid'; exit end;
  x := x + 1e-10;
  if abs (x - MyNow) > 0.45 then Result := MyDateTimeToStr (x)
  else Result := iTimeToStr (trunc(frac(x)*86400))
end;

function MyFixedStrToDateTime (const S : String) : TDateTime;
type limarr = array [1..6, 1..2] of integer;
const
  Pattern : string = '11.22.3333 44:55:66';
  Ranges  : limarr = ((1,31),(1,12),(1980,2020),(0,23),(0,59),(0,59));
var
  i, j, x, y, z : integer;
  V             : array [1..6] of integer;
  C, D          : char;
begin
  if S = 'undefined' then Result := UnknownDateTime else
  if S = 'invalid' then Result := InvalidDateTime else begin
    Result := InvalidDateTime;
    if length(S) <> length (Pattern) then exit;
    for i := 1 to 6 do V[i] := 0;
    for i := 1 to length (Pattern) do begin
      C := S[i];  D := Pattern[i];
      if D in ['0'..'9'] then begin
        j := ord(D) - 48;
        if not (C in ['0'..'9']) then exit;
        V[j] := V[j] * 10 + (ord(C) - 48);
      end else if C <> D then exit
    end;
    for i := 1 to 6 do
      if (V[i] < Ranges[i,1]) or (V[i] > Ranges[i,2]) then exit;
    if V[1] > cumml[V[2]]-cumml[V[2]-1] then exit;
    if (V[1] = 29) and (V[2] = 2) and ((V[3] and 3) <> 0) then exit;
    if (V[3] and 3) = 0 then x := cumml[V[2]-1] + V[1] - 1
                        else x := cummo[V[2]-1] + V[1] - 1;
    y := V[3] - 1901;
    z := y shr 2;
    y := y and 3;
    x := (4*365+1)*z + 365*y + x + 367;
    y := V[4]*3600 + V[5]*60 + V[6];
    Result := x + y * (1/86400);
  end
end;

{[[d]d.mm[.[yy]yy] ][h]h:mm[:ss]}

function MyStrToDateTime (const S : String) : TDateTime;
type limarr = array [1..6, 1..2] of integer;
const
  Ranges  : limarr = ((1,31),(1,12),(1980,2020),(0,23),(0,59),(0,59));
var
  i, j, x, y, z : integer;
  V             : array [1..6] of integer;
  C             : char;
begin
  if S = 'undefined' then Result := UnknownDateTime else
  if (S = 'invalid') or (S = '') then Result := InvalidDateTime else begin
    Result := InvalidDateTime;
    for i := 1 to 6 do V[i] := -1;
    x := 0;  y := 0;  j := 1;
    CalcToday;
    if (pos ('.', S) = 0) and (pos ('/', S) = 0) then j := 4;
    for i := 1 to length (S) + 1 do begin
      if i > length(S) then C := ' ' else C := S[i];
      if C = '/' then C := '.';
      if C = #9 then C := ' ';
      if C in ['0'..'9'] then begin
        z := ord(C) - 48;
        x := x * 10 + z;
        inc (y);
        if y > 4 then exit
      end else if y = 0 then begin
        if not (C = ' ') and (j in [1,4,7]) then exit
      end else begin
        if j > 6 then exit;
        V[j] := x;
        case j of
        1:  if (y > 2) or (C <> '.') then exit;
        2:  if y <> 2 then exit else
            if C = ' ' then inc(j) else
            if C <> '.' then exit;
        3:  if C <> ' ' then exit else
            if (y = 2) and (x >= 20) then exit else
            if y = 2 then inc (V[j], 2000) else
            if (y <> 4) or (x < 2000) or (x > 2020) then exit;
        4:  if (y > 2) or (C <> ':') then exit;
        5:  if y <> 2 then exit else
            if C = ' ' then inc (j) else
            if C <> ':' then exit;
        6:  if (y <> 2) or (C <> ' ') then exit;
        else exit
        end;
        inc (j);  x := 0;  y := 0;
      end
    end;
    if j <> 7 then exit;
    if V[6] = -1 then V[6] := 0;
    if V[1] = -1 then j := 4 else begin
      j := 1;
      if V[3] = -1 then V[3] := today_y
    end;
    for i := j to 6 do
      if (V[i] < Ranges[i,1]) or (V[i] > Ranges[i,2]) then exit;
    if j = 1 then begin
      if V[1] > cumml[V[2]]-cumml[V[2]-1] then exit;
      if (V[1] = 29) and (V[2] = 2) and ((V[3] and 3) <> 0) then exit;
      if (V[3] and 3) = 0 then x := cumml[V[2]-1] + V[1] - 1
                          else x := cummo[V[2]-1] + V[1] - 1;
      y := V[3] - 1901;
      z := y shr 2;
      y := y and 3;
      x := (4*365+1)*z + 365*y + x + 367
    end else x := 0;
    y := V[4]*3600 + V[5]*60 + V[6];
    if x = 0 then begin
      x := pred_day;
      if y < pred_sec - 43200 then inc(x);
      if y > pred_sec + 43200 then dec(x)
    end;
    Result := x + y * (1/86400)
  end
end;

begin
  PrevGTC := GetTickCount;
  TickDelta := 0;
  StartDelta := Now - MyGetTickCount * F2;
  AddDelta := 0;
  if (StartDelta < MinT) or (StartDelta > MaxT) then
    raise ETimeError.Create ('Calendar date out of range');
  CalcToday;
end.
