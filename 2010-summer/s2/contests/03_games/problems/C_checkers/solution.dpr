{$APPTYPE CONSOLE}

type
	int = longint;

const
	infile = 'checkers.in';
	outfile = 'checkers.out';

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
	i, l, r, sum: int;
begin
	read(m);
	read(l, r);
		
	if (r-l-1) = 0 then
		writeln('Second')
	else
		writeln('First');
end;

begin
	init();
	solve();
end.
