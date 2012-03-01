{$APPTYPE CONSOLE}

Uses SysUtils;

var N,K : Integer;
begin
  assign(input,'a.in'); rewrite(output);
  assign(output,'a.out'); rewrite(output);
  Read(N,K);
  writeln( N div K );
end.
