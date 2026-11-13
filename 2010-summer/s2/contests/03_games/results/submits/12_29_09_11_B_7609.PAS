program checkers;
var m, l:longint;
begin
     assign(input, 'candy.in');
     assign(output, 'candy.out');
     reset(input);
     rewrite(output);
     readln(m,l);
     if m mod 2 = 1 then writeln('1')
     else
     if m mod 4 =2 then
        if l=1 then writeln('0')
        else
               writeln('2')
     else writeln('0');
     close(input);
     close(output)
end.