{$APPTYPE CONSOLE}

Uses SysUtils;

Const FileName = 'c';

begin
  Reset( input, FileName+'.in' );
  Rewrite( output, FileName+'.out' );
  while ReadData do begin
    Solve;
    SaveData;
  end;
end.
