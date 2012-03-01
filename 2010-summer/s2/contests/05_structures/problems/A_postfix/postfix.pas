
type
	int = longint;

const
	taskid = 'postfix';
	infile = taskid + '.in';
	outfile = taskid + '.out';
	MAXN = 1000;
	
type
	stack = record
	  data: array [1..MAXN] of int;
	  size: int;
	end;

var
	s: string;
	st: stack;

procedure init;
begin
	assign(input, infile);
	reset(input);
	assign(output, outfile);
	rewrite(output);
end;

procedure push(var st: stack; x: int);
begin
	inc(st.size);
	st.data[st.size] := x;
end;

function pop(var st: stack): int;
begin
	pop := st.data[st.size];
	dec(st.size);
end;

function calc(x, y: int; ch: char): int;
begin
	if (ch = '+') then
		calc := x + y;
	if (ch = '-') then
		calc := y - x;
	if (ch= '*') then
		calc := x * y;
end;

procedure solve;
var
	x, y, i: int;
begin
	readln(s);
	for i := 1 to length(s) do begin
		if (s[i] = ' ') then
			continue;
		if (s[i] in ['0'..'9']) then begin
			push(st, ord(s[i]) - ord('0'));			
		end;
		if (s[i] in ['+', '-', '*']) then begin
			x := pop(st);
			y := pop(st);
			push(st, calc(x, y, s[i]));
		end;
	end;
	writeln(pop(st));
end;

begin
	init;
	solve;
end.
