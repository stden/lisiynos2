{$APPTYPE CONSOLE}

Uses SysUtils;

const FileName = 'a6';

procedure ReadData;
begin
  Reset( input, FileName+'.in' );
end;

procedure WriteAnswer;
begin
  Rewrite( output, FileName+'.out' );
end;

procedure Solve;
begin
end;

begin
  ReadData;
  Solve;
  WriteAnswer;
end.
