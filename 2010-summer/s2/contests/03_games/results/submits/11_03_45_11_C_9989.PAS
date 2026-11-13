program checkers;
var m, l, r:integer;
begin
     assign(input, 'checkers.in');
     assign(output, 'checkers.out');
     reset(input);
     rewrite(output);
     readln(m,l,r);
     if r-1=l then
        writeln('Second')
     else
         writeln('First');
     close(input);
     close(output)
end.