{$I trans.inc}
uses testlib, sysutils;


var ansWord, oufWord : String;
    i, badpos, tmp:longint;

  Jury, Contestant : string;
begin
 DisablePE;

 Jury := '';
 while not ans.eof do
   Jury := Jury + ans.ReadString;

 Contestant := '';
 while not ouf.eof do
   Contestant := Contestant + ouf.ReadString;

 Jury := stringReplace(Jury, #32, '', [rfReplaceAll]);
 Jury := stringReplace(Jury, #9, '', [rfReplaceAll]);
 Jury := stringReplace(Jury, #13, '', [rfReplaceAll]);
 Jury := stringReplace(Jury, #10, '', [rfReplaceAll]);

 Contestant := stringreplace(Contestant, #32, '', [rfReplaceAll]);
 Contestant := stringreplace(Contestant, #9, '', [rfReplaceAll]);
 Contestant := stringreplace(Contestant, #13, '', [rfReplaceAll]);
 Contestant := stringreplace(Contestant, #10, '', [rfReplaceAll]);

 Jury := Trim(Jury);
 Contestant := Trim(Contestant);

 if Jury <> Contestant then
   QUIT(_WA,'Jury = "'+ Jury+'" Contestant = "'+Contestant+'"');

 QUIT(_OK,'');
end.

