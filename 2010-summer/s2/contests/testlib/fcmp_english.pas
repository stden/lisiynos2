{$I trans.inc}
{ Universal verifying program for simple cases.
  Compares files' lines, truncating trailing whitespaces (spaces and tabs).
  Blank lines (also lines consisting of whitespaces) are allowed.
  In case of not matching, line number is provided.
  11.02.98. Shafirov Maxim.
}
{URL: http://acm.math.spbu.ru/soft/testlib}

(* modified 08 november 2001 with accordance to new changes in testlib *)
(* modified 29 june     2009 --- translated everything into english *)

uses testlib_english;

var ansWord, oufWord : String;
    i, badpos, tmp:longint;


begin
 repeat
   ouf.SavePosition;
   if ans.eof then break;
   ansWord := StripRightSpaces (ans.ReadString);
   oufWord := StripRightSpaces (ouf.ReadString);
   if (ansWord<>oufWord) then
     begin
       tmp:=min (length (answord), length (oufword));
       badpos:=tmp+1;
       for i:=1 to tmp do
         if oufword[i]<>answord[i] then begin badpos:=i;break;end;
       QUIT(_WA,'Mismatch at position (' + ouf.GetSavedLineCountStr+
                ', '+IntToString (badpos)+').'+#13#10+
                'Contestant  :"'+oufWord+'"'#13#10+
                'Jury        :"'+ansWord+'"');
     end;
   if ouf.eof then
     if not ans.seekeof then
       ouf.UnExpectedEOF;

 until false;

 QUIT (_OK, ouf.GetLineCountStr + ' lines');
end.
