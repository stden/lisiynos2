{$I trans.inc}

uses testlib;

var Jury, User : String;
begin
  Jury := StripSpaces (ans.ReadString);
  User := StripSpaces (ouf.ReadString);
  if Jury<>User then 
       QUIT(_WA,'Jury: "' + Jury + '" '+
                'User: "' + User + '"');
 QUIT(_OK,'');
end.

