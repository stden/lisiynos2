{$APPTYPE CONSOLE}

Uses SysUtils;

Const FileName = 'h1';

procedure ReadData;
begin
end;

procedure WriteAnswer;
begin
end;

procedure Solve;
begin
end;

begin
  Reset( input, FileName+'.in' );
  Rewrite( output, FileName+'.out' );
  while ReadData do begin
    Solve;
    WriteAnswer;
  end;
end.
