{$I trans.inc}
program macro;
uses testlib, sysutils;
var jury, cont, i : integer;
	
begin
	i := 1;
  	while not ans.seekeof do begin  	
	   jury := ans.readinteger;
   	cont := ouf.readinteger;
    	if jury<>cont then quit(_wa, 'Difference in : '+ IntToStr(i) +'th position.');
    	inc(i);
  	end;
  	if not ouf.seekeof then quit (_pe, 'EOF expected');
  	quit (_ok, '');
end.