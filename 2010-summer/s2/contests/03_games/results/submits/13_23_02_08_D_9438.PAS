program new;
var  r,l,m:integer;
begin
     assign(input,'nim.in');
     assign(output,'nim.out');
     reset(input);
     rewrite(output);
     write('First');
     close(input);
     close(output);
end.