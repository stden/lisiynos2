{$APPTYPE CONSOLE}

Uses SysUtils;

Const FileName = 'j';

begin
  Reset( input, FileName+'.in' );
  Rewrite( output, FileName+'.out' );
  while ReadData do begin
    Solve;
    SaveData;
  end;
end.
