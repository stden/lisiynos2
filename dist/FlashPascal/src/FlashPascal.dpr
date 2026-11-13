program FlashPascal;

{ Pascal for Flash compiler (c)2008 by Paul TOTH <tothpaul@free.fr> }

{
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

{ 2008-06-14
   version 0.1 - Proof of concept !

  2008-06-17
   version 0.2 - this is a fun project :D

   SWFOptimize to concat PUSH operations
   SWFDictionary to define a string pool
   FOR loop support
   ARRAY support
   some changes in class construction

  2008-07-05
   version 0.3

   new samples, new keywords
   register usage optimized

  2008-07-15

   version 0.3a

   where is this #$@ bug on the ZoneFlash.pas sample ?!

  2008-07-25

   version 0.4

   alias constructor need a Name parameter, "undefined" work until a depth test !

   -> v0.3 (replace Parent by undefined, then call Parent's method - or _root for nil )
    contructor Create(Parent:MovieClip; Depth:integer) as Parent.createEmptyMovieClip
   -> v0.4 (remove the Parent parameter and use the provided Name)
    contructor Create(Parent:MovieClip; Name:string; Depth:integer) as Parent.createEmptyMovieClip

 2008-08-06

  version 0.5

   added ZLIB compression
   multiple dimension array
   while statement
   constant array (beginGradientFill)
   kylix compatible !

 2008-09-03

  version 0.5.1

  using pasZLib
  memory leaks fixed (GetArray, RepeatStatement)

 2008-11-26

  version 0.5.2
  new Deflate unit 

}

// http://www.m2osw.com/fr/swf_alexref.html

{$APPTYPE CONSOLE}

{%file '..\samples\Flash8.pas'}
{%file '..\samples\Hello.pas'}
{%file '..\samples\Calc.pas'}
{%file '..\samples\Etoile.pas'}
{%file '..\samples\Barycentre.pas'}
{%file '..\samples\DragPoly.pas'}
{%file '..\samples\ZoneFlash.pas'}
{%file '..\samples\FlashMine.pas'}

{%file 'FlashPascal.inc'}

uses
  SysUtils,
  Deflate in 'Deflate.pas',
  Global in 'Global.pas',
  SWF in 'SWF.pas',
  Compiler in 'Compiler.pas',
  Parser in 'Parser.pas',
  Source in 'Source.pas';

{$I FlashPascal.inc}

procedure CompileFile(const AFileName:string);
var
 c:TCompiler;
 s,syms:TSymbol;
 i:integer;
begin
 WriteLn(AFileName);
 Path := AFileName;
 i := pos('\',AFileName);
 if i=0 then
  Path:=''
 else begin
  i:=Length(AFileName);
  while AFileName[i]<>'\' do dec(i);
  Path:=copy(AFileName,1,i);
 end;
{$IFDEF MEMCHECK}
 WriteLn('sCount=',sCount);
 WriteLn('eCount=',eCount);
{$ENDIF}
 syms:=Symbols;

 FrameWidth  :=800;
 FrameHeight :=600;
 FrameRate   :=32;
 Background  :=$FFFFFF;
 FlashVersion:=9;

 c:=TCompiler.Create(AFileName);

 Dictionary.Items:=nil;
 Dictionary.Length :=0;
 Dictionary.Count  :=0;
 Resources:='';
 ResourceID:=0;

 c.Compile;

 c.Free;

 Resources:='';

 s:=Symbols;
 while s<>syms do begin
  Symbols:=s.NextSymbol;
  s.Free;
  S:=Symbols;
 end;
 s:=Anonyms;
 while s<>nil do begin
  Anonyms:=s.NextSymbol;
  s.Free;
  S:=Anonyms;
 end;

{$IFDEF MEMCHECK}
 WriteLn('sCount=',sCount);
 WriteLn('eCount=',eCount);
{$ENDIF}
end;

function AddType(const Name:string):TSymbol;
begin
 Result:=TBaseType.Create;
 Result.name:=Name;
 Result.NextSymbol:=Symbols;
 Symbols:=Result;
end;

{$IFNDEF TEST}
var
 i:integer;
{$ENDIF}
begin
 DecimalSeparator:='.';
 
// init symbols
 Symbols :=nil;
 Anonyms :=nil;
 Scopes  :=nil;
 _Root   :=TVariable.Create;
 _Root.realName:='_root';
 _String :=AddType('STRING');
 _Integer:=AddType('INTEGER');
 _Double :=AddType('DOUBLE');
 _Boolean:=AddType('BOOLEAN');
 _Object :=AddType('TOBJECT');

{$IFDEF TEST}
 CompileFile('samples\Hello.pas');
 CompileFile('samples\Calc.pas');
 CompileFile('samples\Etoile.pas');
 CompileFile('samples\Barycentre.pas');
 CompileFile('samples\DragPoly.pas');
 CompileFile('samples\ZoneFlash.pas');
 CompileFile('samples\FlashMine.pas');
{$ELSE}
  if ParamCount>0 then
    for i:=1 to ParamCount do
      if FileExists(ParamStr(i)) then
        CompileFile(ParamStr(i))
      else
        WriteLn('ERROR: File not found ',ParamStr(i))
  else begin
    WriteLn('Pascal for Flash compiler (c)2008 by Paul TOTH <tothpaul@free.fr>');
    WriteLn('usage: ',ExtractFileName(ParamStr(0)),' <file1> <file2> ... <fileN>');
  end;
{$ENDIF}

// for Free Pascal's builtin embedded heap profiler
{$IFDEF FPC}
 _Object.Free;
 _Boolean.Free;
 _Double.Free;
 _Integer.Free;
 _String.Free;
 _Root.Free;
{$ENDIF}

 ReadLn;
end.
