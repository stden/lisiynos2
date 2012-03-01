uses SysUtils;

type integer = longint;

function str( x: integer ): string;

  begin
    if ( x <= 9 ) then str := '0' + intToStr( x )
    else str := intToStr( x );
  end;

var test, a: integer;
  s: string;

begin
  assign( input, 'tests' ); reset( input );
  test := 1;
  while ( not seekEOF ) do begin
    assign( output, str( test ) ); rewrite( output );
    inc( test );
    readln( s ); writeln( s ); readln;
    close( output );
  end;
end.
