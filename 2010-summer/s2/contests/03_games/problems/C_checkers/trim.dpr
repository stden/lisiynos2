{$APPTYPE CONSOLE}

type
	int = longint;

const
	infile = 'checkers.pre';
	outfile = 'checkers.in';

var
	n, m: int;

procedure init();
begin
	assign(input, infile);
	reset(input);
	assign(output, outfile);
	rewrite(output);
end;

procedure solve();
var
	l, r: int;
begin
	read(n, m);
	read(l, r);

	writeln(m);
	writeln(l, ' ', r);
end;

begin
	init();
	solve();
end.
