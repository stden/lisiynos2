{$APPTYPE CONSOLE}

Uses SysUtils, Classes;

Const FileName = 'a2';

var
  S : string;

function LoadFile(const FileName: TFileName): string;
begin
  with TStringList.Create do
    try
      LoadFromFile(FileName);
      Result := Text;
    finally
      Free;
    end;
end;

function M( i,j : integer ):boolean;
begin
  M := S[i] = S[j];
end;

procedure ReadData;
begin
  S := LoadFile(FileName+'.in');
end;

procedure WritePos( pos : integer );
var line,col,i : integer;
begin
  assert( pos >= 1 );
  assert( pos <= Length(S) );
  line := 1;
  col := 1;
  for i := 1 to pos-1 do begin
    inc( col );
    if S[i] = #10 then begin
      inc( line );
      col := 1;
    end;
  end;
  writeln(line,' ',col);
end;

procedure Solve;
var
  i,j,L,P,StrLen,Cnt,k : integer;
  F : string;
begin
  StrLen := Length(S);
  for L:=StrLen-1 downto 1 do
    for i:=StrLen-L+1 downto 1 do begin
      F := Copy(S,i,L);
      P := Pos(F,S);
      if (P<>i) and (P<>0) then begin
//        Writeln(L);
//        WritePos(i);
//        WritePos(P+i);
        { —читаем, сколько раз встречаетс€ }
        Cnt := 0;
        for k := 1 to StrLen do
          if Copy(S,k,L) = F then
            Inc(Cnt);
        Writeln(Cnt);
        Writeln(Trim(F));
        exit;
      end;
    end;
end;

begin
  Reset( input, FileName+'.in' );
  Rewrite( output, FileName+'.out' );
  ReadData;
  Solve;
end.
