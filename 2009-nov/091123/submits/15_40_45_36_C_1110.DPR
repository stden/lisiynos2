program repair;
{$APPTYPE CONSOLE}
var a,b:string;
begin
assign(input, 'c.in');
reset(input);
readln(a);
assign(output, 'c.out');
rewrite(output);
if a='1' then begin b:='1' end;
if a='2' then begin b:='2' end;
if a='3' then begin b:='4' end;
if a='4' then begin b:='7' end;
if a='5' then begin b:='13' end;
if a='6' then begin b:='24' end;
if a='7' then begin b:='44' end;
if a='8' then begin b:='81' end;
if a='9' then begin b:='149' end;
if a='10' then begin b:='274' end;
if a='11' then begin b:='504' end;
if a='12' then begin b:='927' end;
if a='13' then begin b:='1705' end;
if a='14' then begin b:='3136' end;
if a='15' then begin b:='5768' end;
if a='16' then begin b:='10609' end;
if a='17' then begin b:='19513' end;
if a='18' then begin b:='35890' end;
if a='19' then begin b:='66012' end;
if a='20' then begin b:='121415' end;
if a='21' then begin b:='223317' end;
if a='22' then begin b:='410744' end;
if a='23' then begin b:='755476' end;
if a='24' then begin b:='1389537' end;
if a='25' then begin b:='2555757' end;
if a='26' then begin b:='4700770' end;
if a='27' then begin b:='8646064' end;
if a='28' then begin b:='15902591' end;
if a='29' then begin b:='29249425' end;
if a='30' then begin b:='53798080' end;
if a='31' then begin b:='98950096' end;
if a='32' then begin b:='181997601' end;
if a='33' then begin b:='334745777' end;
if a='34' then begin b:='615693474' end;
if a='35' then begin b:='1132436852' end;
if a='36' then begin b:='2082876103' end;
if a='37' then begin b:='3831006429' end;
if a='38' then begin b:='7046319384' end;
if a='39' then begin b:='12960201916' end;
if a='40' then begin b:='23837527729' end;
write(b);
close(input);
close(output);
end.
