{$APPTYPE CONSOLE}

{ Разложение по степеням b и сборка по степеням 2 }
function Count( Z,b : longint ):longint;
var sb,s2,res,k,kk : longint;
  t : extended;
begin
  if b=1 then begin
    Count := Z;
    exit;
  end;
  {}
  t:=1; s2:=1;
  for k:=0 to maxLongint do begin
    t := t * b;
    s2 := s2 * 2;
    if t > Z then begin
      kk := k;
      break;
    end;
  end;
  sb:=trunc(t/b);
  s2:=s2 div 2;
  {}
  res := 0;
  for k := kk downto 0 do begin
    if Z>=sb then begin
      Z:= Z - sb;
      res := res + s2;
    end;
    sb := sb div b;
    s2 := s2 div 2;
  end;
  {}
  Count := res;
end;

var X,Y,b : longint;
begin
  if ParamCount=1 then begin
    assign(input,ParamStr(1));
    assign(output,ParamStr(1)+'.a');
  end else begin
    assign(input,'g.in');
    assign(output,'g.out');
  end;
  reset(input); rewrite(output);
  {}
  read(X,Y,b);
  {}
  write(Count(Y,b)-Count(X-1,b));
end.
