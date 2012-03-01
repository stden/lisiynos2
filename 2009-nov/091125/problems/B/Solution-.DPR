program Bred;

{$APPTYPE CONSOLE}

var M, N, i, j, zu : integer;

begin

  assign( input, 'b.in' ); Reset(input);
  assign( output, 'b.out'); Rewrite(output);

  Read( N, M );

  zu := 0;
  for i := 1 to N do
  begin
    for j := 1 to i do
    begin
      Write( i );
      inc( zu );
      if zu = M then
      begin
        zu := 0;
        Writeln;
      end;
    end;
  end;

end.
 