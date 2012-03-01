unit testlib;

{NPC 1.0 Copyright (c) ��⮭ ��堭��, 1996}
{TESTLIB: ������⥪� ��� �஢������ �ணࠬ�}

{��� ��᫥����� ��������� ���஬: 17/03/96}
(* modified: kitten computing *)
(* modified: 22/10/01 *)
(* modified: 29/10/01 *)
(* 08/11/01: added support for seekeof function;
             added support for requirenewline;
             added support for *eoln;
             added support for read*withstring;
             added support for *tostring;
             added support for symbol&line counting;
             added support for get*;
             added support for disablepe&stricteof;
             file error reporting improved;
             added support for testjury mode;
             improved number reading
       some functions updated *)
(* 10/11/01: fixed bug with range check error in readint on 32-bit ints *)
(* 02/12/01: added support for nonewline method
             added support for assert
             added support for require?eof *)
(* 30/01/02: added support for output file *)
(* 16/03/02: added support for reopen *)
(* 17/11/02: added min&max; fixed bug in fcwa with missed symbols *)
{$ifdef VER70}
{$A+,B-,D+,E-,F+,G+,I-,L+,N+,O-,P+,Q-,R+,S+,T-,V+,X+,Y+}
{$M 65520, 0, 0}
{$else}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P-,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE CONSOLE}
{$endif}

(* ================================================================= *)
                              interface
(* ================================================================= *)

type trueint = integer;

{$ifndef VER70}
type integer = smallint;
const maxint = 32767;
{$endif}

const EofChar      = #$1A;
      Blanks       = [#10,#13,' ',#09];
      CRS          = [#10,#13];
      OnlyBlanks   = [' ',#09];
      NumberBefore = Blanks;
      NumberAfter  = Blanks;
      AllChars     = [#0..#255];
      AfterInteger = AllChars-['0'..'9','-'];
      AfterUnsigned= AllChars-['0'..'9'];
      AfterReal    = AllChars-['0'..'9','.','e','E','+','-'];
      AfterPReal   = AllChars-['0'..'9','.','-'];
      Accept       = true;
      Reject       = false;
      Accept_EOF   = Accept;
      Reject_EOF   = Reject;
      Accept_Empty = Accept;
      Reject_Empty = Reject;

type REAL = EXTENDED; {!!!!!!!!}

type CharSet = set of char;
     TMode   = (_Input, _Output, _Answer);
     TResult = (_OK, _WA, _PE,  _Fail(*, _Dirt*));
               {_OK - �� ��୮, _WA - ������ �⢥�, _PE - �ଠ� �뢮��,
                _Fail - ����� �� ᫮������}
               {P_Dirt - ��� ����७���� �ᯮ�짮�����}

     InStream = object
                    cur: char; {⥪�騩 ᨬ���, =EofChar, �᫨ �����}
                    f: TEXT; {䠩�}
                    name: string; {��� 䠩��}
                    mode: TMode;
                    opened: boolean;
                    linecount, linepos:longint;
                    curstring:string;
                    savedlinecount, savedlinepos:longint;

                    {��� ���७���� �ᯮ�짮�����}
                    constructor init (fname: string; m: TMode);

                    function  CurChar: char; {�뤠�� cur}
                    function  NextChar:char;     {���室�� �� ᫥�. ᨬ���}

                    function  eof : boolean;  { == cur = EofChar}
                    {�஢���� ����� 䠩��, �������� �஡��� � ��ॢ���
                     ��ப�}
                    function  seekeof:boolean;

                    {�ய�᪠�� ᨬ���� ��������� ������⢠}
                    {�� ��ࠡ��뢠�� �訡��}
                    procedure skip (setof: CharSet);

                    {�뤠�� �訡�� �� ���� 䠩��}
                    procedure RequireNotEof;

                    {��⠥� ᫮�� (�� ᨬ�����). ��। ᫮��� �ய�᪠����
                     �� ᨬ���� �� Before. �ਧ����� ���� ᫮�� ����
                     ���� ����� 䠩��, ���� ᨬ��� �� After. �᫨ ReadWord
                     ���몠���� �� ����� 䠩�� ��� ᫮�� ���⮥, � �� �
                     ����蠥��� � �訡��� _PE}
                    {�᫨ ᫮�� ��⮨� �����, 祬 �� 255 ᨬ����� =>
                     ��室�� � �訡��� _PE}
                    function  ReadWord (Before, After: CharSet; EmptyPossible:boolean): string;

                    {���ᨨ *String ⠪�� �������� ��室��� �᫮ � ����
                     ��ப� ��� 㤮��⢠ �뢮�� �訡�� �� ��ᮢ�������}
                    {���ᨨ *AndSets �ਭ����� �ந������ ������⢠
                     ᨬ����� Before � After}
                    {���ᨨ *Only* ���� �᫮ ����� ⥪��, � �筮��
                     � ⥪�饩 ����樨, ������ᨬ� �� �।������� �
                     ��᫥����� ᨬ�����}

                    {��⠥� 楫�� integer}
                    {�� �訡�� ��室�� � _PE}
                    function  ReadIntegerWithStringAndSets (var save:string;
                    Before, After:CharSet):integer;
                    function  ReadIntegerWithString (var save:string):integer;
                    function  ReadInteger: integer;

                    {��᫮ ����� ⥪��}
                    function  ReadOnlyIntegerWithString (var save:string):integer;
                    function  ReadOnlyInteger:integer;
                    function  ReadOnlyUnsignedWithString (var save:string):integer;
                    function  ReadOnlyUnsigned:integer;

                    {��⠥� ������� 楫��}
                    {�� �訡�� ��室�� � _PE}
                    function  ReadLongintWithStringAndSets (var save:string;
                    Before, After:CharSet):longint;
                    function  ReadLongintWithString (var save:string):longint;
                    function  ReadLongint: longint;
                    {����� � �������� �।����, ���� _PE}
                    function  ReadIntegerRange (fromn, ton:longint):longint;
                    {��᫮ ����� ⥪��}
                    function  ReadOnlyLongintWithString (var save:string):longint;
                    function  ReadOnlyLongint:longint;
                    function  ReadOnlyUnsignedLongWithString (var save:string):longint;
                    function  ReadOnlyUnsignedLong:longint;

                    {��⠥� ����⢥����}
                    {�� �訡�� ��室�� � _PE}
                    function  ReadRealWithStringAndSets (var save:string;
                    Before, After:CharSet):real;
                    function  ReadRealWithString (var save:string):real;
                    function  ReadReal: real;

                    {��⠥� ��ப� (�� ᨬ����� #13, #10),
                     ⥪�饩 ����樥� �⠭������ ���� ᨬ��� ᫥�. ��ப�}
                    {�᫨ ��ப� ��⮨� �����, 祬 �� 255 ᨬ����� =>
                     ��室�� � �訡��� _PE}
                    function  ReadString: string;

                    {�ॡ�� ������ ��ॢ��� ��ப� � ⥪�饩 ����樨 䠩��}
                    procedure RequireNewLine (EOFAcceptable:boolean);

                    {���⨣��� �� ����� ��ப�?}
                    function  eoln:boolean;
                    {� �� ᠬ��, �� � �����஢����� �஡����}
                    function  seekeoln:boolean;

                    {����砥� ����� ⥪�饩 ��ப�}
                    function  GetLineCountStr:string;
                    function  ReadableLineCountStr:string;
                    {����砥� ���� (⥪��� ��ப�, ⥪��� ������)}
                    function  GetPosPair:string;
                    function  ReadablePosPair:string;
                    {��࠭�� ������ ��� ��᫥��� �८�ࠧ������ �
                     ��ப� �� �訡��}
                    procedure SavePosition;
                    {����砥� ��࠭���� ����� ��ப�}
                    function  GetSavedLineCountStr:string;
                    function  ReadableSavedLineCountStr:string;
                    {����砥� ���� (��࠭����� ��ப�, ��࠭����� ������)}
                    function  GetSavedPosPair:string;
                    function  ReadAbleSavedPosPair:string;
                    {�뢮��� �訡�� "�������� ����� 䠩��", ��祣�
                     �� �஢����}
                    procedure UnExpectedEOF;

                    {����砥� ⥪���� ��ப� ��������� ��� �뢮�� �訡��}
                    function  GetCurString:string;
                    {�ॡ�� ����稥 ��ப� s ��稭�� � ⥪�饩 ����樨
                     �⠥���� 䠩��}
                    procedure RequireString (s:string);
                    {�뤠�� PE, �᫨ � ⥪�饩 ����樨 ��室���� ��ॢ��
                     ��ப� (�ய�᪠�� �஡���)}
                    procedure NoNewLine;

                    procedure assert (what:boolean;msg:string);
                    procedure test (what:boolean);


                    procedure requireeof;
                    procedure requireleof;
                    procedure requireseof;

                    {���⪨� �����}
                    function nc:char;
                    procedure noeof;
                    procedure rne;
                    function RW (Before, After: CharSet; EmptyPossible:boolean): string;
                    function ReadW (Before, After: CharSet; EmptyPossible:boolean): string;
                    function getint:integer;
                    function onlyint:integer;
                    function roi:integer;
                    function unsonly:integer;
                    function rou:integer;
                    function rr:real;
                    function rl:longint;
                    function getl:longint;
                    function getlong:longint;
                    function readl:longint;
                    function rol:longint;
                    function onlylong:longint;
                    function roul:longint;
                    function onlyul:longint;
                    function getstr:string;
                    function reads:string;
                    function rs:string;
                    procedure rnl (eo:boolean);
                    procedure newl (eo:boolean);
                    procedure reql (eo:boolean);
                    function lcs:string;
                    function lcstr:string;
                    function slcs:string;
                    function slcstr:string;
                    function rlcs:string;
                    function rlcstr:string;
                    function rslcs:string;
                    function rslcstr:string;
                    function lc:string;
                    function lnum:string;
                    function lcnt:string;
                    function rlnum:string;
                    function rlcnt:string;
                    function rlc:string;
                    function slnum:string;
                    function slcnt:string;
                    function slc:string;
                    function rslnum:string;
                    function rslcnt:string;
                    function rslc:string;
                    function pp:string;
                    function pospair:string;
                    function spp:string;
                    function spospair:string;
                    function rpp:string;
                    function rpospair:string;
                    function rspp:string;
                    function rspospair:string;
                    procedure savep;
                    procedure sp;
                    function cs:string;
                    function cl:string;
                    function cstr:string;
                    function getcstr:string;
                    function curstr:string;
                    function getcs:string;
                    procedure reqs (s:string);
                    procedure reqstr (s:string);
                    procedure nnl;
                    procedure nonewl;
                    procedure noeoln;
                    procedure nnewl;
                    procedure nonl;
                    procedure reof;
                    procedure rleof;
                    procedure rseof;
                    procedure reqeof;
                    procedure reqleof;
                    procedure reqseof;
                    function getrng (fromn, ton:longint):longint;
                    function getintr (fromn, ton:longint):longint;
                    function intrange (fromn, ton:longint):longint;
                    function intrng (fromn, ton:longint):longint;
                    (* ��室 � ����ᨬ��� �� ⨯� 䠩��: � ��砥
                       input ��� answer ⨯ ��室� fail *)
                    procedure QUIT (res: TResult; msg: string);
                    (* ��८����� ������ 䠩� (���� ᭠砫�) *)
        procedure reopen;

                    private
                       {��� ����७���� �ᯮ�짮�����}
                       last13, last10:boolean;
                       procedure readnewline;
                       {procedure close;}

                end;


{$ifdef TESTJURY}
const _WI=_PE;
{$endif}
{��室}
procedure QUIT (res: TResult; msg: string);
{�� ��� �����頥� ��ப�}
function  IntToString (a:longint):string;
function  RealToString (a:real):string;
{�� ᨬ���� �����頥� �⠡��쭮� ��� ���ᠭ��}
function  SymbolToString (c:char):string;
{������ ��ப� ��⮢�� � ����}
function  MakePrintable (s:string):string;
{㤠��� �஡��� �ࠢ�}
function  StripRightSpaces (s:string):string;
{᫥��}
function  StripLeftSpaces (s:string):string;
{�ࠢ� � ᫥��}
function  StripSpaces (s:string):string;
{��ண�� �஢�ઠ �� EOF (��譨� �஡��� � ��ॢ��� ��ப� �ਢ���� � �訡��)}
procedure StrictEof;
{����� ����設�⢠ PE �뢮����� WA}
procedure DisablePE;
procedure EnablePE;
{��, �� �� �뢮��� ����� PE}
function  GetPE:TResult;

function min (a, b:longint):longint;
function max (a, b:longint):longint;
function CompToString (a:extended):string;
function Cp2s (a:extended):string;


procedure q (res:tresult; msg:string);
function i2s (a:longint):string;
function i2str (a:longint):string;
function int2str (a:longint):string;
function inttostr (a:longint):string;
function r2s (a:real):string;
function r2str (a:real):string;
function real2str (a:real):string;
function realtostr (a:real):string;
function c2s (c:char):string;
function c2str (c:char):string;
function chr2str (c:char):string;
function chrtostr (c:char):string;
function char2str (c:char):string;
function chartostr (c:char):string;
function s2s (c:char):string;
function s2str (c:char):string;
function sym2str (c:char):string;
function symtostr (c:char):string;
function mp (s:string):string;
function makep (s:string):string;
function mprt (s:string):string;
function makeprt (s:string):string;
function srs (s:string):string;
function srsp (s:string):string;
function sls (s:string):string;
function slsp (s:string):string;
function ss (s:string):string;
function ssp (s:string):string;
procedure steof;
procedure nope;
{$ifdef TESTJURY}
procedure CreateInf (s:string);
procedure AssignOutput (s:string);
procedure ci (s:string);
procedure ao (s:string);
{$endif}


{$ifdef TESTJURY}
function  CurChar: char; {�뤠�� cur}
function  NextChar:char;     {���室�� �� ᫥�. ᨬ���}

function  eof : boolean;  { == cur = EofChar}
{�஢���� ����� 䠩��, �������� �஡��� � ��ॢ���
 ��ப�}
function  seekeof:boolean;

{�ய�᪠�� ᨬ���� ��������� ������⢠}
{�� ��ࠡ��뢠�� �訡��}
procedure skip (setof: CharSet);

{�뤠�� �訡�� �� ���� 䠩��}
procedure RequireNotEof;

{��⠥� ᫮�� (�� ᨬ�����). ��। ᫮��� �ய�᪠����
 �� ᨬ���� �� Before. �ਧ����� ���� ᫮�� ����
 ���� ����� 䠩��, ���� ᨬ��� �� After. �᫨ ReadWord
 ���몠���� �� ����� 䠩�� ��� ᫮�� ���⮥, � �� �
 ����蠥��� � �訡��� _PE}
{�᫨ ᫮�� ��⮨� �����, 祬 �� 255 ᨬ����� =>
 ��室�� � �訡��� _PE}
function  ReadWord (Before, After: CharSet; EmptyPossible:boolean): string;

{���ᨨ *String ⠪�� �������� ��室��� �᫮ � ����
 ��ப� ��� 㤮��⢠ �뢮�� �訡�� �� ��ᮢ�������}
{���ᨨ *AndSets �ਭ����� �ந������ ������⢠
 ᨬ����� Before � After}
{���ᨨ *Only* ���� �᫮ ����� ⥪��, � �筮��
 � ⥪�饩 ����樨, ������ᨬ� �� �।������� �
 ��᫥����� ᨬ�����}

{��⠥� 楫�� integer}
{�� �訡�� ��室�� � _PE}
function  ReadIntegerWithStringAndSets (var save:string;
Before, After:CharSet):integer;
function  ReadIntegerWithString (var save:string):integer;
function  ReadInteger: integer;
{��᫮ ����� ⥪��}
function  ReadOnlyIntegerWithString (var save:string):integer;
function  ReadOnlyInteger:integer;
function  ReadOnlyUnsignedWithString (var save:string):integer;
function  ReadOnlyUnsigned:integer;

{��⠥� ������� 楫��}
{�� �訡�� ��室�� � _PE}
function  ReadLongintWithStringAndSets (var save:string;
Before, After:CharSet):longint;
function  ReadLongintWithString (var save:string):longint;
function  ReadLongint: longint;
{��᫮ ����� ⥪��}
function  ReadOnlyLongintWithString (var save:string):longint;
function  ReadOnlyLongint:longint;
function  ReadOnlyUnsignedLongWithString (var save:string):longint;
function  ReadOnlyUnsignedLong:longint;

{��⠥� ����⢥����}
{�� �訡�� ��室�� � _PE}
function  ReadRealWithStringAndSets (var save:string;
Before, After:CharSet):real;
function  ReadRealWithString (var save:string):real;
function  ReadReal: real;

{��⠥� ��ப� (�� ᨬ����� #13, #10),
 ⥪�饩 ����樥� �⠭������ ���� ᨬ��� ᫥�. ��ப�}
{�᫨ ��ப� ��⮨� �����, 祬 �� 255 ᨬ����� =>
 ��室�� � �訡��� _PE}
function  ReadString: string;

{�ॡ�� ������ ��ॢ��� ��ப� � ⥪�饩 ����樨 䠩��}
procedure RequireNewLine (EOFAcceptable:boolean);

{���⨣��� �� ����� ��ப�?}
function  eoln:boolean;
{� �� ᠬ��, �� � �����஢����� �஡����}
function  seekeoln:boolean;

{����砥� ����� ⥪�饩 ��ப�}
function  GetLineCountStr:string;
function  ReadableLineCountStr:string;
{����砥� ���� (⥪��� ��ப�, ⥪��� ������)}
function  GetPosPair:string;
function  ReadablePosPair:string;
{��࠭�� ������ ��� ��᫥��� �८�ࠧ������ �
 ��ப� �� �訡��}
procedure SavePosition;
{����砥� ��࠭���� ����� ��ப�}
function  GetSavedLineCountStr:string;
function  ReadableSavedLineCountStr:string;
{����砥� ���� (��࠭����� ��ப�, ��࠭����� ������)}
function  GetSavedPosPair:string;
function  ReadAbleSavedPosPair:string;
{�뢮��� �訡�� "�������� ����� 䠩��", ��祣�
 �� �஢����}
procedure UnExpectedEOF;

{����砥� ⥪���� ��ப� ��������� ��� �뢮�� �訡��}
function  GetCurString:string;
{�ॡ�� ����稥 ��ப� s ��稭�� � ⥪�饩 ����樨
 �⠥���� 䠩��}
procedure RequireString (s:string);
{�뤠�� PE, �᫨ � ⥪�饩 ����樨 ��室���� ��ॢ��
 ��ப� (�ய�᪠�� �஡���)}
procedure NoNewLine;

procedure assert (what:boolean;msg:string);
procedure test (what:boolean);

procedure requireeof;
procedure requireleof;
procedure requireseof;



{���⪨� �����}
function nc:char;
procedure noeof;
procedure rne;
function RW (Before, After: CharSet; EmptyPossible:boolean): string;
function ReadW (Before, After: CharSet; EmptyPossible:boolean): string;
function getint:integer;
function onlyint:integer;
function roi:integer;
function unsonly:integer;
function rou:integer;
function rr:real;
function rl:longint;
function getl:longint;
function getlong:longint;
function readl:longint;
function rol:longint;
function onlylong:longint;
function roul:longint;
function onlyul:longint;
function getstr:string;
function reads:string;
function rs:string;
procedure rnl (eo:boolean);
procedure newl (eo:boolean);
procedure reql (eo:boolean);
function lcs:string;
function lcstr:string;
function slcs:string;
function slcstr:string;
function rlcs:string;
function rlcstr:string;
function rslcs:string;
function rslcstr:string;
function lc:string;
function lnum:string;
function lcnt:string;
function rlnum:string;
function rlcnt:string;
function rlc:string;
function slnum:string;
function slcnt:string;
function slc:string;
function rslnum:string;
function rslcnt:string;
function rslc:string;
function pp:string;
function pospair:string;
function spp:string;
function spospair:string;
function rpp:string;
function rpospair:string;
function rspp:string;
function rspospair:string;
procedure savep;
procedure sp;
function cs:string;
function cl:string;
function cstr:string;
function getcstr:string;
function curstr:string;
function getcs:string;
procedure reqs (s:string);
procedure reqstr (s:string);
procedure nnl;
procedure noeoln;
procedure nonewl;
procedure nnewl;
procedure nonl;
procedure reof;
procedure rleof;
procedure rseof;
procedure reqeof;
procedure reqleof;
procedure reqseof;
function getrng (fromn, ton:longint):longint;
function getintr (fromn, ton:longint):longint;
function intrange (fromn, ton:longint):longint;
function intrng (fromn, ton:longint):longint;
{$endif}


var inf: InStream;
{$ifndef TESTJURY}
    ouf, ans:InStream;
    TestLibOutput:boolean;
{$else}
    DisplayOK     :boolean;
    DisplayConsole:boolean;
    OutputAssigned:boolean;
{$endif}
    StrictEofMode :boolean;
    PEisWA        :boolean;
const RealDisplayPrecision:integer=6;

(* ================================================================= *)
                              implementation
(* ================================================================= *)

(*uses crt;*)

{$ifdef VER70}
procedure SetLength (var s:string; newl:longint);
begin
  s[0]:=chr (newl);
end;
{$endif}

function GetPE:TResult;
begin
  if PEisWA then GetPE:=_WA else GetPE:=_PE;
end;

{$ifndef TESTJURY}
procedure QUIT (res: TResult; msg: string);
var pe:boolean;
begin
  if (res = _OK) then
    begin
      if StrictEofMode then pe:=not ouf.eof else pe:=not ouf.seekeof;
      if pe then QUIT (GetPE, '����� ���ଠ�� � ��室��� 䠩��');
    end;
  case res of
    _Fail: write ('* ����� * ');
    _PE:   write ('* ��ଠ� �/� * ');
    _OK:   write ('* ok * ');
    _WA:   write ('* ������ �⢥� * ');
    else   QUIT (_Fail, '�������� ��� �����襭�� ??? (ᮮ�饭��: '+
                         MakePrintable (msg)+')');
  end;
  writeln (msg);

  if testliboutput then begin
    {writeln;
    case res of
      _OK:writeln ('OK');
      _WA:writeln ('WA');
      _PE:writeln ('PE');
      _Fail:writeln ('JE');
    end;}
    close (output);
  end;

  if res = _OK then
    begin
      close (inf.f); close (ouf.f); close (ans.f);
      HALT (0)
    end
  else
  if res = _PE   then halt (2)
  else
  if res = _Fail then halt (3)
                 else HALT (1);
end;
{$else}
procedure QUITHelper (res: TResult;msg:string;console:boolean);
var pe:boolean;
begin
  if not inf.opened then
    writeln ('��������!!! ��⠫쭠� �訡��: �� ����� �室��� 䠩�');
  if (res = _OK) then
    begin
      if StrictEofMode then pe:=not inf.eof else pe:=not inf.seekeof;
      if pe then QUIT (GetPE, '����� ���ଠ�� �� �室��� 䠩��');
    end;
  case res of
    _Fail: write ('* ����� * ');
    _PE:   write ('* ��ଠ� ����� * ');
    _OK:   if console and DisplayOK then write ('* ok * ');
    _WA:   write ('* ������ ���� * ');
    else   QUIT (_Fail, '�������� ��� �����襭�� ??? (ᮮ�饭��: '+
                         MakePrintable (msg)+')');
  end;
  if (res<>_OK) or (DisplayOk and console) then writeln (msg);
end;

procedure QUIT (res: TResult; msg:string);
begin
  if OutputAssigned then begin QuitHelper (res, msg, false); close (output);
                         end;
  if DisplayConsole or not OutputAssigned then
    begin
      assign (output, ''); rewrite (output);
      QuitHelper (res, msg, true);
    end;
  if res=_PE then runerror (239)
  else
  if res=_WA then runerror (241)
  else
  if res=_Fail then runerror (240)
  else
  halt (0);
end;
{$endif}

procedure q (res:tresult; msg:string); begin quit (res, msg);end;

constructor Instream.init (fname: string; m: TMode);
begin
   name := fname;
   mode := m;
   assign (f, fname);
   linecount:=1; linepos:=0;
   curstring:='';
   last13:=false; last10:=false;
   {$I-} reset (f);
   if IORESULT <> 0 then
   begin
      if mode = _Output then QUIT (_PE,   '��������� 䠩� ''' +
                                   MakePrintable (fname) + '''')
                        else QUIT (_Fail, '��������� 䠩� ''' +
                                   MakePrintable (fname) + '''');
      (*cur := EofChar; {��� ��㣨� 䠩��� - �����}*)
   end
   else
     begin
       opened := true;
       if system.eof (f) then cur := EofChar
                         else begin cur := ' '; nextchar end;
     end;
   if cur=EofChar then linepos:=1;
   opened := true;
end;


procedure instream.reopen;
begin
  opened:=false;
  init (name, mode);
end;

function InStream.curchar: char;
begin
   curchar := cur
end;

function InStream.nextchar:char;
begin
  if not opened then QUIT (_Fail, '����⪠ �⥭�� �� ������⮣� 䠩�� ('+
                           MakePrintable (name)+')');
  nextchar:=cur;
  if cur = EofChar then {��祣� �� ������}
  else if system.eof (f) then cur := EofChar
  else begin
     {$I-} read (f, cur);
     if IORESULT <> 0 then Quit (_Fail, '�訡�� �⥭�� 䠩�� ''' +
                                        MakePrintable (name) + '''');
  end;
  if cur<>eofchar then
  if cur=#13 then
    begin
      if last13 or last10 then begin SetLength (curstring, 0);
                                     inc (linecount); linepos:=1; end
      else inc (linepos);
      last10:=false;
      last13:=true;
    end
  else
  if cur=#10 then
    begin
      if not last13 then inc (linepos);
      last13:=false;
      if last10 then begin SetLength (curstring, 0); inc (linecount); linepos:=1 end;
      last10:=true;
    end
  else
  if last10 or last13 then
    begin
      inc (linecount);
      linepos:=1;
      last13:=false;
      last10:=false;
      SetLength (curstring, 1);
      curstring[1]:=cur;
    end
  else
    begin
      inc (linepos);
      if Length (CurString)<255 then
        begin
          SetLength (Curstring, Length (CurString)+1);
          curstring [length (curstring)]:=cur;
        end;
    end;
end;


function instream.nc:char; begin nc:=nextchar;end;

procedure InStream.QUIT (res: TResult; msg: string);
begin
   {$ifndef TESTJURY}
   if mode = _Output then TESTLIB.QUIT (res, msg)
   else TESTLIB.QUIT (_Fail, msg + ' (' + MakePrintable (name) + ')');
   {$else}
   testjury.QUIT (res, msg)
   {$endif}
   {�訡�� �� �⥭�� input ��� answer - �� ⮫쪮 -Fail}
end;


procedure InStream.UnExpectedEOF;
begin
  QUIT (GetPE, '���������� ����� 䠩��');
end;


procedure InStream.RequireNOTEof;
begin
  if eof then UnexpectedEof;
end;

procedure instream.noeof; begin requirenoteof;end;
procedure instream.rne; begin requirenoteof;end;


function InStream.ReadWord (Before, After: CharSet; EmptyPossible:boolean): string;
var i: longint;
    res: string;
begin
   while cur in Before do nextchar;
   if (cur in After) then
     if not EmptyPossible then
       QUIT (GetPE, '���������� ᨬ��� ' + SymbolToString (cur) +
                  ' � ����樨 '+GetPosPair)
     else
       begin readword:=''; exit end;
   if cur = EofChar then UnExpectedEOF;

   i := 0;
{$IFDEF VER70}
   SetLength (Res, 255);
{$ELSE}
   SetLength (Res, 65536);
{$ENDIF}
   repeat
      inc (i);
      {$IFDEF VER70}
      if i > 255 then QUIT (GetPE, '���誮� ������� ��ப� ('+
                            GetLineCountStr+')');
      {$ELSE}
      if (i and 65535)=0 then SetLength (Res, Length (Res)+65536);
      {$ENDIF}
      res [i] := cur;
      nextchar
   until (cur in After) or (cur = EofChar);
   SetLength (Res, i);
   ReadWord := res
end;


function instream.rw (before, after:charset;emptypossible:boolean):string;
begin rw:=readword (before, after, emptypossible);end;


function instream.readw (before, after:charset;emptypossible:boolean):string;
begin readw:=readword (before, after, emptypossible);end;


function InStream.ReadIntegerWithStringAndSets (var save:string;
                                 Before, After:CharSet):integer;
var res:  longint;
    code: trueint;
begin
   save := ReadWord (Before, After, Reject_Empty);
   {$R-}
   val (save, res, code);
   {$R+}
   if code <> 0 then QUIT (GetPE, '����� "' + save + '" ��������� 楫��');
   if (res<-maxint-1) or (res>maxint) then
     quit (GetPE, '���ॡ����� 16-��⭮� 楫��, � ����祭� "'+save+'"');
   ReadIntegerWithStringAndSets := res
end;


function InStream.ReadIntegerWithString (var save:string):integer;
begin
  ReadIntegerWithString:=ReadIntegerWithStringAndSets (save,
    NumberBefore, NumberAfter);
end;


function InStream.ReadInteger: integer;
var help:string;
begin
  ReadInteger:=ReadIntegerWithString (help);
end;


function InStream.ReadIntegerRange (fromn, ton:longint):longint;
var tmp:longint;
begin
  if ton<fromn then quit (_Fail,
    '����⪠ ������ �᫮ � �������� �������⨬�� �।����: �� '+
    i2s (fromn)+' �� '+i2s (ton));
  tmp:=getlong;
  if (tmp<fromn) or (tmp>ton) then
    quit (getpe, '�ॡ������� �᫮ � �।���� �� '+i2s (Fromn)+' �� '+
                 i2s (ton)+', � ����祭� '+i2s (tmp));
  ReadIntegerRange:=tmp;
end;


function instream.intrange (fromn, ton:longint):longint; begin intrange:=readintegerrange (fromn, ton) end;
function instream.intrng (fromn, ton:longint):longint; begin intrng:=readintegerrange (fromn, ton) end;
function instream.getrng (fromn, ton:longint):longint; begin getrng:=readintegerrange (fromn, ton) end;
function instream.getintr (fromn, ton:longint):longint; begin getintr:=readintegerrange (fromn, ton) end;


function instream.getint:integer;
begin
  getint:=readinteger;
end;


function InStream.ReadOnlyIntegerWithString (var save:string):integer;
begin
  ReadOnlyIntegerWithString:=ReadIntegerWithStringAndSets
    (save, [], AfterInteger);
end;


function InStream.ReadOnlyInteger: integer;
var help:string;
begin
  ReadOnlyInteger:=ReadOnlyIntegerWithString (help);
end;


function instream.onlyint:integer;
begin
  onlyint:=readonlyinteger;
end;


function instream.roi:integer;
begin
  roi:=readonlyinteger;
end;


function InStream.ReadOnlyUnsignedWithString (var save:string):integer;
begin
  ReadOnlyUnsignedWithString:=ReadIntegerWithStringAndSets
    (save, [], AfterUnsigned);
end;


function InStream.ReadOnlyUnsigned: integer;
var help:string;
begin
  ReadOnlyUnsigned:=ReadOnlyUnsignedWithString (help);
end;


function instream.unsonly:integer;
begin
  unsonly:=readonlyunsigned;
end;


function instream.rou:integer;
begin
  rou:=readonlyunsigned;
end;


function InStream.ReadRealWithStringAndSets (var save:string;
                              Before, After:CharSet): real;
var res: real;
    code: trueint;
begin
   save := ReadWord (Before, After, Reject_Empty);
   val (save, res, code);
   if code <> 0 then QUIT (GetPE, '����� "' + save + '" ��������� ����⢥����');
   ReadRealWithStringAndSets := res
end;


function InStream.ReadRealWithString (var save:string):real;
begin
  ReadRealWithString:=ReadRealWithStringAndSets (save,
    NumberBefore, NumberAfter);
end;


function InStream.ReadReal:real;
var help:string;
begin
  ReadReal:=ReadRealWithString (help);
end;


function instream.rr:real; begin rr:=readreal;end;

function InStream.ReadLongintWithStringAndSets (var save:string;
                                 Before, After:CharSet): longint;
var res: longint;
    code: trueint;
begin
   save := ReadWord (Before, After, Reject_Empty);
   val (save, res, code);
   if code <> 0 then QUIT (GetPE, '����� "' + save + '" ��������� 32-��⭮� 楫��');
   ReadLongintWithStringAndSets := res
end;


function InStream.ReadLongintWithString (var save:string):longint;
begin
  ReadLongintWithString:=ReadLongintWithStringAndSets (save,
    NumberBefore, NumberAfter);
end;


function InStream.ReadLongint:longint;
var help:string;
begin
  ReadLongint:=ReadLongintWithString (help);
end;


function instream.rl:longint; begin rl:=readlongint;end;
function instream.getl:longint; begin getl:=readlongint;end;
function instream.readl:longint; begin readl:=readlongint;end;
function instream.getlong:longint; begin getlong:=readlongint;end;


function InStream.ReadOnlyLongintWithString (var save:string):longint;
begin
  ReadOnlyLongintWithString:=ReadLongintWithStringAndSets
    (save, [], AfterInteger);
end;


function InStream.ReadOnlyLongint: longint;
var help:string;
begin
  ReadOnlyLongint:=ReadOnlyLongintWithString (help);
end;


function instream.rol:longint; begin rol:=readonlylongint;end;
function instream.onlylong:longint; begin onlylong:=readonlylongint;end;


function InStream.ReadOnlyUnsignedLongWithString (var save:string):longint;
begin
  ReadOnlyUnsignedLongWithString:=ReadLongintWithStringAndSets
    (save, [], AfterUnsigned);
end;


function InStream.ReadOnlyUnsignedLong: longint;
var help:string;
begin
  ReadOnlyUnsignedLong:=ReadOnlyUnsignedLongWithString (help);
end;


function instream.roul:longint; begin roul:=readonlyunsignedlong;end;
function instream.onlyul:longint; begin onlyul:=readonlyunsignedlong;end;


procedure InStream.skip (setof: CharSet);
begin
   while (cur in setof) and (cur <> eofchar) do nextchar;
end;


function InStream.eof : boolean;
begin
   eof := cur = EofChar
end;


procedure InStream.ReadNewLine;
begin
  if cur=#13 then nextchar;
  if cur=#10 then nextchar;
end;


function InStream.ReadString: string;
var res: string;
begin
   res := ReadWord ([], CRS, Accept_Empty);
   ReadNewLine;
   readstring := res
end;

function instream.getstr:string; begin getstr:=readstring;end;
function instream.reads:string; begin reads:=readstring;end;
function instream.rs:string; begin rs:=readstring;end;

{procedure InStream.close;
begin
   if opened then system.close (f)
end;}


function InStream.seekeof : boolean;
begin
  skip (Blanks);
  seekeof:=eof;
end;


function InStream.eoln : boolean;
begin
  eoln:=cur in [#13, #10, #26];
end;


function InStream.seekeoln : boolean;
begin
  skip (OnlyBlanks);
  seekeoln := eoln;
end;


procedure InStream.RequireNewLine (EofAcceptable:boolean);
begin
  SavePosition;
  if cur=#26 then
    if EofAcceptable then exit
    else UnExpectedEOF;
  if cur=#10 then begin nextchar;exit end;
  if cur=#13 then begin
    nextchar;
    if cur<>#10 then QUIT (GetPE, '�������� ��ॢ�� ��ப� � ����樨 '+GetSavedPosPair);
    nextchar;
    exit;
  end;
  QUIT (GetPE, '�������� ��ॢ�� ��ப� � ����樨 '+GetSavedPosPair);
end;


procedure instream.rnl (eo:boolean);begin requirenewline (eo);end;
procedure instream.newl (eo:boolean);begin requirenewline (eo);end;
procedure instream.reql (eo:boolean);begin requirenewline (eo);end;


function IntToString (a:longint):string;
var tmp:string;
begin
  str (a, tmp);
  IntToString:=tmp;
end;


function i2s (a:longint):string; begin i2s:=inttostring (a);end;
function i2str (a:longint):string; begin i2str:=inttostring (a);end;
function int2str (a:longint):string; begin int2str:=inttostring (a);end;
function inttostr (a:longint):string; begin inttostr:=inttostring (a);end;


function RealToString (a:real):string;
var tmp:string;
begin
  str (a:0:RealDisplayPrecision, tmp);
  RealToString:=tmp;
end;


function r2s (a:real):string; begin r2s:=realtostring (a);end;
function r2str (a:real):string; begin r2str:=realtostring (a);end;
function real2str (a:real):string; begin real2str:=realtostring (a);end;
function realtostr (a:real):string; begin realtostr:=realtostring (a);end;


function CompToString (a:extended):string;
var tmp:string;
begin
  str (a:0:0, tmp);
  if abs (a)>9 then begin
    a:=a-int (a/10)*10;
    tmp[length (tmp)]:=chr (trunc (abs (a))+48);
  end;
  CompToString:=tmp;
end;

function cp2s (a:extended):string; begin cp2s:=comptostring (a) end;


function SymbolToString (c:char):string;
var tmp:string;
begin
  if (c<=#32) or (c=#127) then
    begin
      str (ord (c), tmp);
      tmp:='#'+tmp;
      SymbolToString:=tmp;
    end
  else
    SymbolToString:=''''+c+'''';
end;


function s2s (c:char):string; begin s2s:=symboltostring (c);end;
function s2str (c:char):string; begin s2str:=symboltostring (c);end;
function sym2str (c:char):string; begin sym2str:=symboltostring (c);end;
function symtostr (c:char):string; begin symtostr:=symboltostring (c);end;
function c2s (c:char):string; begin c2s:=symboltostring (c);end;
function c2str (c:char):string; begin c2str:=symboltostring (c);end;
function chr2str (c:char):string; begin chr2str:=symboltostring (c);end;
function chrtostr (c:char):string; begin chrtostr:=symboltostring (c);end;
function char2str (c:char):string; begin char2str:=symboltostring (c);end;
function chartostr (c:char):string; begin chartostr:=symboltostring (c);end;

function MakePrintable (s:string):string;
var tmp:string;
    i, l:integer;
begin
  tmp:='';
  {$IFNDEF VER70}
  if length (s)>1024 then l:=1024 else l:=length (s);
  {$ELSE}
  l:=length (s);
  {$ENDIF}
  for i:=1 to l do
    if s[i]<#32 then tmp:=tmp+SymbolToString (s[i])
    else tmp:=tmp+s[i];
  MakePrintable:=tmp;
end;


function mp (s:string):string; begin mp:=makeprintable (s) end;
function mprt (s:string):string; begin mprt:=makeprintable (s) end;
function makeprt (s:string):string; begin makeprt:=makeprintable (s) end;
function makep (s:string):string; begin makep:=makeprintable (s) end;


function InStream.GetLineCountStr:string;
begin
  GetLineCountStr:=IntToString (LineCount);
end;


function InStream.readableLineCountStr:string;
begin
  readableLineCountStr:='(��ப� '+GetLineCountStr+')';
end;


function instream.lc:string; begin lc:=getlinecountstr; end;
function instream.lcnt:string; begin lcnt:=getlinecountstr; end;
function instream.lnum:string; begin lnum:=getlinecountstr; end;
function instream.lcs:string; begin lcs:=getlinecountstr; end;
function instream.lcstr:string; begin lcstr:=getlinecountstr; end;
function instream.rlc:string; begin rlc:=readablelinecountstr; end;
function instream.rlcnt:string; begin rlcnt:=readablelinecountstr; end;
function instream.rlnum:string; begin rlnum:=readablelinecountstr; end;
function instream.rlcs:string; begin rlcs:=readablelinecountstr; end;
function instream.rlcstr:string; begin rlcstr:=readablelinecountstr; end;


function InStream.GetPosPair:string;
begin
  GetPosPair:='('+GetLineCountStr+', '+IntToString (LinePos)+')';
end;


function instream.readablepospair:string;
begin
  readablepospair:='[������ '+getpospair+']';
end;


function instream.pp:string; begin pp:=getpospair; end;
function instream.pospair:string; begin pospair:=getpospair; end;
function instream.rpp:string; begin rpp:=readablepospair; end;
function instream.rpospair:string; begin rpospair:=readablepospair; end;


procedure InStream.SavePosition;
begin
  SavedLineCount:=LineCount; SavedLinePos:=LinePos;
end;


procedure instream.savep; begin saveposition;end;
procedure instream.sp; begin saveposition; end;


function InStream.GetSavedLineCountStr:string;
begin
  GetSavedLineCountStr:=IntToString (SavedLineCount);
end;


function InStream.readableSavedLineCountStr:string;
begin
  readableSavedLineCountStr:='(��ப� '+readableSavedLineCountStr+')';
end;

function instream.slc:string; begin slc:=getsavedlinecountstr; end;
function instream.slcs:string; begin slcs:=getsavedlinecountstr; end;
function instream.slcnt:string; begin slcnt:=getsavedlinecountstr; end;
function instream.slnum:string; begin slnum:=getsavedlinecountstr; end;
function instream.slcstr:string; begin slcstr:=getsavedlinecountstr; end;
function instream.rslc:string; begin rslc:=readablesavedlinecountstr; end;
function instream.rslcs:string; begin rslcs:=readablesavedlinecountstr; end;
function instream.rslcnt:string; begin rslcnt:=readablesavedlinecountstr; end;
function instream.rslnum:string; begin rslnum:=readablesavedlinecountstr; end;
function instream.rslcstr:string; begin rslcstr:=readablesavedlinecountstr; end;


function InStream.GetSavedPosPair:string;
begin
  GetSavedPosPair:='('+GetSavedLineCountStr+', '+IntToString (SavedLinePos)+')';
end;


function instream.readablesavedpospair:string;
begin
  readablesavedpospair:='[������ '+getsavedpospair+']';
end;


function instream.spp:string; begin spp:=getsavedpospair; end;
function instream.spospair:string; begin spospair:=getsavedpospair; end;
function instream.rspp:string; begin rspp:=readablesavedpospair; end;
function instream.rspospair:string; begin rspospair:=readablesavedpospair; end;


function StripRightSpaces (s:string):string;
begin
  while (length (s)>0) and (s[length (s)] in Blanks) do SetLength (S, Length (S)-1);
  StripRightSpaces:=s;
end;


function srs (s:string):string; begin srs:=striprightspaces (s);end;
function srsp (s:string):string; begin srsp:=striprightspaces (s); end;


function StripLeftSpaces (s:string):string;
var p:integer;
begin
  p:=1;
  while (p<=length (s)) and (s[p] in Blanks) do inc (p);
  if p>length (s) then StripLeftSpaces:='' else
                       StripLeftSpaces:=copy (s, p, 255);
end;


function sls (s:string):string; begin sls:=stripleftspaces (s);end;
function slsp (s:string):string; begin slsp:=stripleftspaces (s); end;


function StripSpaces (s:string):string;
begin
  StripSpaces:=StripLeftSpaces (StripRightSpaces (s));
end;


function ss (s:string):string; begin ss:=stripspaces (s);end;
function ssp (s:string):string; begin ssp:=stripspaces (s);end;


procedure StrictEof;
begin
  StrictEofMode:=true;
end;

procedure steof; begin stricteof;end;


procedure DisablePE;
begin
  PEisWA:=true;
end;

procedure EnablePE;
begin
  PEisWA:=false;
end;

procedure nope; begin disablepe;end;


function InStream.GetCurString:string;
begin
  while not InStream.eoln do nextchar;
  GetCurString:=curstring;
end;

function instream.cs:string; begin cs:=getcurstring;end;
function instream.cl:string; begin cl:=getcurstring;end;
function instream.getcs:string; begin getcs:=getcurstring;end;
function instream.getcstr:string; begin getcstr:=getcurstring;end;
function instream.cstr:string; begin cstr:=getcurstring;end;
function instream.curstr:string; begin curstr:=getcurstring;end;


procedure InStream.RequireString (s:string);
var tmp:string;
    i:integer;
begin
  SavePosition;
  tmp:='';
  for i:=1 to length (s) do
    begin
      if eof then UnExpectedEOF;
      tmp:=tmp+nextchar;
    end;
  if tmp<>s then QUIT (GetPE, '�ॡ������� ����稥 "'+mp(s)+'" � ����樨 '+
    GetSavedPosPair+', � ����祭� "'+mp(tmp)+'".');
end;


procedure instream.reqs (s:string); begin requirestring (s);end;
procedure instream.reqstr (s:string); begin requirestring (s);end;

procedure InStream.NoNewLine;
begin
  if seekeoln then QUIT (GetPE, '���������� ��ॢ�� ��ப� � ����樨 '+
                         GetPosPair);
end;

procedure instream.nnl; begin nonewline end;
procedure instream.noeoln; begin nonewline end;
procedure instream.nonl; begin nonewline end;
procedure instream.nnewl; begin nonewline end;
procedure instream.nonewl; begin nonewline end;

procedure instream.assert (what:boolean; msg:string);
begin
  if not what then quit (getpe, msg);
end;


procedure instream.test (what:boolean);
begin
  if not what then
    quit (getpe, '');
end;


procedure instream.RequireEOF;
begin
  if not eof then quit (getpe, '�������� ����� 䠩�� � ����樨 '+GetPosPair);
end;


procedure instream.reof;begin requireeof;end;
procedure instream.reqeof;begin requireeof;end;

procedure instream.requireleof;
begin
  requirenewline (accept);
  requireeof;
end;

procedure instream.rleof;begin requireleof;end;
procedure instream.reqleof;begin requireleof;end;

procedure instream.requireseof;
begin
  if not seekeof then quit (getpe, '�������� ����� 䠩�� � ����樨 '+GetPosPair);
end;


function min (a, b:longint):longint;
begin
  if a<b then min:=a else min:=b;
end;


function max (a, b:longint):longint;
begin
  if a>b then max:=a else max:=b;
end;



procedure instream.rseof;begin requireseof;end;
procedure instream.reqseof;begin requireseof;end;

{$ifdef TESTJURY}
(* ������ ��� ��� *)
function  CurChar: char; begin curchar:=inf.curchar;end;
function  NextChar:char; begin nextchar:=inf.nextchar;end;

function  eof : boolean; begin eof:=inf.eof;end;
{�஢���� ����� 䠩��, �������� �஡��� � ��ॢ���
 ��ப�}
function  seekeof:boolean;begin seekeof:=inf.seekeof;end;

{�ய�᪠�� ᨬ���� ��������� ������⢠}
{�� ��ࠡ��뢠�� �訡��}
procedure skip (setof: CharSet); begin inf.skip (setof);end;

{�뤠�� �訡�� �� ���� 䠩��}
procedure RequireNotEof; begin inf.requirenoteof;end;

{��⠥� ᫮�� (�� ᨬ�����). ��। ᫮��� �ய�᪠����
 �� ᨬ���� �� Before. �ਧ����� ���� ᫮�� ����
 ���� ����� 䠩��, ���� ᨬ��� �� After. �᫨ ReadWord
 ���몠���� �� ����� 䠩�� ��� ᫮�� ���⮥, � �� �
 ����蠥��� � �訡��� _PE}
{�᫨ ᫮�� ��⮨� �����, 祬 �� 255 ᨬ����� =>
 ��室�� � �訡��� _PE}
function  ReadWord (Before, After: CharSet; EmptyPossible:boolean): string;
begin readword:=inf.readword (before,after,emptypossible);end;

{���ᨨ *String ⠪�� �������� ��室��� �᫮ � ����
 ��ப� ��� 㤮��⢠ �뢮�� �訡�� �� ��ᮢ�������}
{���ᨨ *AndSets �ਭ����� �ந������ ������⢠
 ᨬ����� Before � After}
{���ᨨ *Only* ���� �᫮ ����� ⥪��, � �筮��
 � ⥪�饩 ����樨, ������ᨬ� �� �।������� �
 ��᫥����� ᨬ�����}

{��⠥� 楫�� integer}
{�� �訡�� ��室�� � _PE}
function  ReadIntegerWithStringAndSets (var save:string;
Before, After:CharSet):integer;begin readintegerwithstringandsets:=
inf.readintegerwithstringandsets (save, before, after);end;
function  ReadIntegerWithString (var save:string):integer;
begin readintegerwithstring:=inf.readintegerwithstring (save);end;
function  ReadInteger: integer; begin readinteger:=inf.readinteger;end;
{��᫮ ����� ⥪��}
function  ReadOnlyIntegerWithString (var save:string):integer;
begin readonlyintegerwithstring:=inf.readonlyintegerwithstring(save);end;
function  ReadOnlyInteger:integer;
begin readonlyinteger:=inf.readonlyinteger;end;
function  ReadOnlyUnsignedWithString (var save:string):integer;
begin readonlyunsignedwithstring:=inf.readonlyunsignedwithstring(save);end;
function  ReadOnlyUnsigned:integer;
begin readonlyunsigned:=inf.readonlyunsigned;end;

{��⠥� ������� 楫��}
{�� �訡�� ��室�� � _PE}
function  ReadLongintWithStringAndSets (var save:string;
Before, After:CharSet):longint;
begin readlongintwithstringandsets:=inf.readlongintwithstringandsets
(save, before, after);end;
function  ReadLongintWithString (var save:string):longint;
begin readlongintwithstring:=inf.readlongintwithstring (save);end;
function  ReadLongint: longint;begin readlongint:=inf.readlongint end;
{��᫮ ����� ⥪��}
function  ReadOnlyLongintWithString (var save:string):longint;
begin readonlylongintwithstring:=inf.readonlylongintwithstring (save);end;
function  ReadOnlyLongint:longint;
begin readonlylongint:=inf.readonlylongint;end;
function  ReadOnlyUnsignedLongWithString (var save:string):longint;
begin readonlyunsignedlongwithstring:=inf.readonlyunsignedlongwithstring
(save);end;
function  ReadOnlyUnsignedLong:longint;
begin readonlyunsignedlong:=inf.readonlyunsignedlong;end;

{��⠥� ����⢥����}
{�� �訡�� ��室�� � _PE}
function  ReadRealWithStringAndSets (var save:string;
Before, After:CharSet):real;
begin readrealwithstringandsets:=inf.readrealwithstringandsets
(save, before, after);end;
function  ReadRealWithString (var save:string):real;
begin readrealwithstring:=inf.readrealwithstring (save);end;
function  ReadReal: real;
begin readreal:=inf.readreal;end;

{��⠥� ��ப� (�� ᨬ����� #13, #10),
 ⥪�饩 ����樥� �⠭������ ���� ᨬ��� ᫥�. ��ப�}
{�᫨ ��ப� ��⮨� �����, 祬 �� 255 ᨬ����� =>
 ��室�� � �訡��� _PE}
function  ReadString: string;begin readstring:=inf.readstring;end;

{�ॡ�� ������ ��ॢ��� ��ப� � ⥪�饩 ����樨 䠩��}
procedure RequireNewLine (EOFAcceptable:boolean);
begin inf.requirenewline (eofacceptable);end;

{���⨣��� �� ����� ��ப�?}
function  eoln:boolean;begin eoln:=inf.eoln;end;
{� �� ᠬ��, �� � �����஢����� �஡����}
function  seekeoln:boolean;begin seekeoln:=inf.seekeoln;end;

{����砥� ����� ⥪�饩 ��ப�}
function  GetLineCountStr:string;
begin getlinecountstr:=inf.getlinecountstr;end;
function  ReadableLineCountStr:string;
begin readablelinecountstr:=inf.readablelinecountstr;end;
{����砥� ���� (⥪��� ��ப�, ⥪��� ������)}
function  GetPosPair:string;begin getpospair:=inf.getpospair;end;
function  ReadablePosPair:string;
begin readablepospair:=inf.readablepospair;end;
{��࠭�� ������ ��� ��᫥��� �८�ࠧ������ �
 ��ப� �� �訡��}
procedure SavePosition;begin inf.saveposition;end;
{����砥� ��࠭���� ����� ��ப�}
function  GetSavedLineCountStr:string;
begin getsavedlinecountstr:=inf.getsavedlinecountstr;end;
function  ReadableSavedLineCountStr:string;
begin readablesavedlinecountstr:=inf.readablesavedlinecountstr;end;
{����砥� ���� (��࠭����� ��ப�, ��࠭����� ������)}
function  GetSavedPosPair:string;
begin getsavedpospair:=inf.getsavedpospair;end;
function  ReadAbleSavedPosPair:string;
begin readablesavedpospair:=inf.readablesavedpospair;end;
{�뢮��� �訡�� "�������� ����� 䠩��", ��祣�
 �� �஢����}
procedure UnExpectedEOF;begin inf.unexpectedeof;end;

{����砥� ⥪���� ��ப� ��������� ��� �뢮�� �訡��}
function  GetCurString:string;begin getcurstring:=inf.getcurstring;end;
{�ॡ�� ����稥 ��ப� s ��稭�� � ⥪�饩 ����樨
 �⠥���� 䠩��}
procedure RequireString (s:string);begin inf.requirestring (s);end;
{�뤠�� PE, �᫨ � ⥪�饩 ����樨 ��室���� ��ॢ��
 ��ப� (�ய�᪠�� �஡���)}
procedure NoNewLine;begin inf.nonewline end;

procedure assert (what:boolean;msg:string);
begin inf.assert (what, msg);end;
procedure test (what:boolean);
begin inf.test (what);end;


procedure requireeof;begin inf.requireeof;end;
procedure requireleof;begin inf.requireleof;end;
procedure requireseof;begin inf.requireseof;end;

{���⪨� �����}
function nc:char;begin nc:=inf.nc;end;
procedure noeof;begin inf.noeof;end;
procedure rne;begin inf.rne;end;
function RW (Before, After: CharSet; EmptyPossible:boolean): string;
begin rw:=inf.rw(before,after,emptypossible);end;
function ReadW (Before, After: CharSet; EmptyPossible:boolean): string;
begin readw:=inf.readw (before,after,emptypossible);end;
function getint:integer;begin getint:=inf.getint;end;
function onlyint:integer;begin onlyint:=inf.onlyint;end;
function roi:integer;begin roi:=inf.roi;end;
function unsonly:integer;begin unsonly:=inf.unsonly;end;
function rou:integer;begin rou:=inf.rou;end;
function rr:real;begin rr:=inf.rr;end;
function rl:longint;begin rl:=inf.rl;end;
function getl:longint;begin getl:=inf.getl;end;
function getlong:longint;begin getlong:=inf.getlong;end;
function readl:longint;begin readl:=inf.readl;end;
function rol:longint;begin rol:=inf.rol;end;
function onlylong:longint;begin onlylong:=inf.onlylong;end;
function roul:longint;begin roul:=inf.roul;end;
function onlyul:longint;begin onlyul:=inf.onlyul;end;
function getstr:string;begin getstr:=inf.getstr;end;
function reads:string;begin reads:=inf.reads;end;
function rs:string;begin rs:=inf.rs;end;
procedure rnl (eo:boolean);begin inf.rnl (eo);end;
procedure newl (eo:boolean);begin inf.newl (eo);end;
procedure reql (eo:boolean);begin inf.reql (eo);end;
function lcs:string;begin lcs:=inf.lcs;end;
function lcstr:string;begin lcstr:=inf.lcstr;end;
function slcs:string;begin slcs:=inf.slcs;end;
function slcstr:string;begin slcstr:=inf.slcstr;end;
function rlcs:string;begin rlcs:=inf.rlcs;end;
function rlcstr:string;begin rlcstr:=inf.rlcstr;end;
function rslcs:string;begin rslcs:=inf.rslcs;end;
function rslcstr:string;begin rslcstr:=inf.rslcstr;end;
function lc:string;begin lc:=inf.lc;end;
function lnum:string;begin lnum:=inf.lnum;end;
function lcnt:string;begin lcnt:=inf.lcnt;end;
function rlnum:string;begin rlnum:=inf.rlnum;end;
function rlcnt:string;begin rlcnt:=inf.rlcnt;end;
function rlc:string;begin rlc:=inf.rlc;end;
function slnum:string;begin slnum:=inf.slnum;end;
function slcnt:string;begin slcnt:=inf.slcnt;end;
function slc:string;begin slc:=inf.slc;end;
function rslnum:string;begin rslnum:=inf.rslnum;end;
function rslcnt:string;begin rslcnt:=inf.rslcnt;end;
function rslc:string;begin rslc:=inf.rslc;end;
function pp:string;begin pp:=inf.pp;end;
function pospair:string;begin pospair:=inf.pospair;end;
function spp:string;begin spp:=inf.spp;end;
function spospair:string;begin spospair:=inf.spospair;end;
function rpp:string;begin rpp:=inf.rpp;end;
function rpospair:string;begin rpospair:=inf.rpospair;end;
function rspp:string;begin rspp:=inf.rspp;end;
function rspospair:string;begin rspospair:=inf.rspospair;end;
procedure savep;begin inf.savep;end;
procedure sp;begin inf.sp;end;
function cs:string;begin cs:=inf.cs;end;
function cl:string;begin cl:=inf.cl;end;
function cstr:string;begin cstr:=inf.cstr;end;
function getcstr:string;begin getcstr:=inf.getcstr;end;
function curstr:string;begin curstr:=inf.curstr;end;
function getcs:string;begin getcs:=inf.getcs;end;
procedure reqs (s:string);begin inf.reqs (s);end;
procedure reqstr (s:string);begin inf.reqstr (s);end;
procedure nnl;begin inf.nnl;end;
procedure noeoln;begin inf.nnl;end;
procedure nonewl;begin inf.nonewl;end;
procedure nnewl;begin inf.nnewl;end;
procedure nonl;begin inf.nonl;end;
procedure reof;begin inf.reof;end;
procedure rleof;begin inf.rleof;end;
procedure rseof;begin inf.rseof;end;
procedure reqeof;begin inf.reqeof;end;
procedure reqleof;begin inf.reqleof;end;
procedure reqseof;begin inf.reqseof;end;
function intrange (fromn, ton:longint):longint; begin intrange:=inf.readintegerrange (fromn, ton) end;
function intrng (fromn, ton:longint):longint; begin intrng:=inf.readintegerrange (fromn, ton) end;
function getrng (fromn, ton:longint):longint; begin getrng:=inf.readintegerrange (fromn, ton) end;
function getintr (fromn, ton:longint):longint; begin getintr:=inf.readintegerrange (fromn, ton) end;
{$endif TESTJURY}

BEGIN {�������������}
   if (ParamCount < 3) or (ParamCount>4) then
      Quit (_fail, '���⠪��: <INPUT-FILE> <OUTPUT-FILE> <ANSWER-FILE> [<log-file>]');

   if paramcount=4 then begin
     assign (output, paramstr (4)); rewrite (output);
     TestLibOutput:=true;
   end;

   inf.opened := false;
   ouf.opened := false;
   ans.opened := false;

   inf.init (ParamStr (1), _Input);
   ouf.init (ParamStr (2), _Output);
   ans.init (ParamStr (3), _Answer);
end.
