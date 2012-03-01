program z_a;
var s,d,k:string;
    i:integer;
begin
		reset(input, 'palin.in');
		rewrite(output, 'palin.out');
        readln(s);

        for i:=1 to length(s) do
                if s[i]<>' ' then k:=k+s[i];


        for i:=1 to length(k) do d:=k[i]+d;

        if d=k then writeln('YES')
        else writeln('NO');
end.