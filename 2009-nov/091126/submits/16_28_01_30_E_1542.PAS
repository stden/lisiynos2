const
Tab_per: array[1..13] of record
                        ar: word;
                        rm: string[2];
                        end = ((ar: 1000; rm:'M'), (ar: 900; rm: 'CM'), (ar: 500; rm: 'D'),
                        (ar: 400; rm: 'CD'), (ar: 100; rm: 'C'), (ar: 90; rm: 'XC'),
                        (ar: 50; rm: 'L'), (ar: 40; rm: 'XL'), (ar: 10; rm: 'X'),
                        (ar: 9;rm: 'IX'), (ar: 5; rm: 'V'), (ar: 4; rm: 'IV'),(ar: 1; rm: 'I'));
var
rimch: string;
arch: longint;
num: byte;
symb: string[2];
znch: word;
begin
assign(input,'romam.in');
reset(input);
assign(output,'roman.out');
rewrite(output);
ReadLn(arch);
rimch := '';
num := 1;
repeat
symb := Tab_per[num].rm;
znch := Tab_per[num].ar;
while znch <= arch do
begin
rimch := rimch + symb;
Dec(arch, znch);
end;
Inc(num);
until arch <= 0;
WriteLn(rimch);
end.
