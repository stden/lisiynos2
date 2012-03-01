{$DEFINE LANGFUNC}
{$IFNDEF VER70}
function RussianEnding (x : int64; const s1, s2, s3 : string) : string;
{$ELSE}
function RussianEnding (x : longint; const s1, s2, s3 : string) : string;
{$ENDIF}

begin
  if x = 1 then RussianEnding := s1 else RussianEnding := s3;
end;


