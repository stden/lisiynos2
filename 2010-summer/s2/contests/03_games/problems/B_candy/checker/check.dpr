{ Copyright(c) SPb-IFMO CTD Developers, 2000 }
{ Copyright(c) Roman Elizarov, 1997 }

{ $Id: fcmp.dpr 448 2004-10-28 15:51:40Z AndrewStankevich $ }

(*
   FILE COMPARE (VERSION WITH LONG LINES SUPPORT)
   Test program for exact comparision of files.
   (all trailing spaces are ignored only if lines are short).
*)

program FCMP2;

uses
  testlib, sysutils;

var
  ja, pa: longint;
  f : textfile;

begin 

  pa := ouf.readlongint;

  while not ans.eof do begin
    ja := ans.readlongint;    
    if (ja = pa) then begin
    	quit(_ok, 'Ok');
    end;
  end;
  QUIT (_WA, IntToStr(pa) + ' is not in list of correct answers.');
end.