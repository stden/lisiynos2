{$APPTYPE CONSOLE}

type
	int = longint;

const
	infile = 'candy.in';
	outfile = 'candy.out';

const
	MAXN = 510;
	MAXK = 110;

var
	dp: array [0..MAXN, 1..MAXK] of int;
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

	for i := 1 to k do begin
		dp[0][i] := 0;
	end;

	for i := 1 to n do begin
		for j := 1 to k do begin
			dp[i][j] := 0;
			for t := 1 to j do if (i >= t) then begin
				if (dp[i - t][t] = 0) then begin
					dp[i][j] := 1;
				end;	
			end;
		end;
	end;

	
	t := 0;

	for j := k downto 1 do begin
		if (dp[n-j][j] = 0) then begin
			if (t > 0) then write(' ');
			write(j);			
			inc(t);
		end;
	end;

	if (t = 0) then begin
		write('0');
	end;
end;

begin
	init();
	solve();	
end.