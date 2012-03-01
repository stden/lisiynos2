program new;
var  r,l,m:longint;
begin
     assign(input,'checkers.in');
     assign(output,'checkers.out');
     reset(input);
     rewrite(output);
     readln(m);
     read(l,r);
     if r-1=l then write('Second') else write('First');
     close(input);
     close(output);
end.