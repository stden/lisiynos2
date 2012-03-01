{$APPTYPE CONSOLE}

type
	int = longint;

const
	infile = 'b.in';
	outfile = 'b.out';

const
	MAXN = 510;
	MAXK = 110;

var
	dp: array [0..MAXN, 0..MAXK] of int;
	n, k: int;

procedure init();
begin
	assign(input, infile);
	reset(input);
	assign(output, outfile);
	rewrite(output);
end;

procedure solve();
var
	i, j, t: int;
begin
	readln(n, k);

	for i := 1 to n do begin
		for j := 1 to k do begin
			dp[i][j] := 0;
			for t := 1 to j do if (i >= t) then begin
				if (dp[i - t][t] = 0) then
					dp[i][j] := 1;
			end;
		end;
	end;

	
	dp[n][0] := 1;
	for j := k downto 0 do begin
		if (dp[n][j] = 1) then begin
			writeln(j);
			break;
		end;
	end;
end;

begin
	init();
	solve();	
end.