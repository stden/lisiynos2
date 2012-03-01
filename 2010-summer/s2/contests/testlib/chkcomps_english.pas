{Checker: standard}
{Checker details: compare any number of 64-bit integers}
{Origin: testlib-kitten, chkcomps_english.pas}
{URL: http://acm.math.spbu.ru/soft/testlib}
{$I trans.inc}
program macro;
uses testlib_english;
var jury, cont:extended;
    count:longint;
begin
  count:=0;
  while not ans.seekeof do begin
    if ouf.seekeof then quit (_Wa, 'Unexpected end of contestant''s file');
    ans.sp;
    jury:=ans.readreal;
    cont:=ouf.readreal;
    inc (count);
    if int (jury)<>jury then quit (_fail, 'Not an integer: '+r2s (jury));
    if int (cont)<>cont then quit (_pe, 'Not an integer: '+r2s (cont));
    if jury<>cont then quit (_wa, 
      'Error in number #'+i2s (count)+' (jury position '+
        ans.spp +') ' +
      'Required '+cp2s (jury)+', got '+cp2s (cont));
  end;
  if not ouf.seekeof then quit (_wa, 'Extra information in contestant''s output');
  QUIT (_OK, i2s (count) + ' ' + RussianEnding (count, 'number', 'numbers', 'numbers'));
end.
