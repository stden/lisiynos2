uses SysUtils;

type integer = longint;

function str( x: integer ): string;

  begin
    if ( x <= 9 ) then str := '0' + intToStr( x )
    else str := intToStr( x );
  end;

var test, a, i: integer;
  s, sb, se: string;

begin
  assign( input, 'tests' ); reset( input );
  test := 1;
  while ( not seekEOF ) do begin
    assign( output, str( test ) ); rewrite( output );
    inc( test );
    readln( s );
    i := 1;
    while ( s[i] <> ' ' ) do inc(i);
    sb := copy(s, 1, i-1);
    se := copy(s, i+1, length(s));
    writeln( sb ); 
    writeln( se ); readln;
    close( output );
  end;
end.
