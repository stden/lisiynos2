{$APPTYPE CONSOLE}

Uses SysUtils;

Const FileName = 'handshakes';

var n,m,r: LongInt;
begin
  Reset( input, FileName+'.in' );
  Rewrite( output, FileName+'.out' );
  Read(N,M);
  r := n * (n - 1);
  r := r div 2;
  Writeln(r - m);
end.
