{$DEFINE LANGFUNC}
{$IFNDEF VER70}
function RussianEnding (x : int64; const s1, s2, s3 : string) : string;
var v : int64;
{$ELSE}
function RussianEnding (x : longint; const s1, s2, s3 : string) : string;
var v : longint;
{$ENDIF}

begin
  v := x mod 100;
  if (v div 10 = 1) or not (v mod 10 in [1..4]) then RussianEnding := s3 else
  if v mod 10 = 1 then RussianEnding := s1 else RussianEnding := s2;
end;


