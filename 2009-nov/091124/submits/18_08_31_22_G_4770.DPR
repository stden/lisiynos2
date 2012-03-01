var
 st : array[1..1000] of boolean;
 e, i, y : integer;
 c : char;
 q : boolean;
 tx : text;
 //s : string;

begin
 assign(input,'holiday.in');
 reset(input);
 assign(output,'holiday.out');
 rewrite(output);

 read(c);
 if c = 'T' then st[1] := true
            else st[1] := false;


 e := 1;

 while not eoln(input) do begin
  read(c);

  if c = '|' then begin
   read(c);

   if c = 'T' then st[e + 1] := true
              else st[e + 1] := false;
   inc(e);
   end       else
             read(c);
             if c = 'T' then st[e + 1] := true
                        else st[e + 1] := false;
             st[e] := st[e] and st[e + 1];
  end;

 q := false;

 for i := 1 to e do
  q := q or st[i];


 if (q) then writeln('YES') else writeln('NO');
 close(input);
 close(output);
end.



