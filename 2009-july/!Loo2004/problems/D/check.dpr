{$I trans.inc}
program macro;
uses testlib;

var jury, cont:String;
begin
  jury := ans.ReadWord(testlib.Blanks,testlib.Blanks,false);
  cont := ouf.ReadWord(testlib.Blanks,testlib.Blanks,false);
  if jury<>cont then quit (_wa, 'Требовалось '+jury+', а получено '+cont);
  quit (_ok, '');
end.