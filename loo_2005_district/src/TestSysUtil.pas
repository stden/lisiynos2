{$IFDEF MSWINDOWS}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}
unit TestSysUtil;

interface

uses SysUtils 
{$IFDEF MSWINDOWS}
,Windows
{$ENDIF}
{$IFDEF LINUX}
,Libc
{$ENDIF}
;

{$IFDEF MSWINDOWS}
const CopyWindows:boolean = true;
{$ENDIF}

{$IFDEF LINUX}
type THandle=integer;
{$ENDIF}


type PPatternList=^TPatternList;
     TPatternList=record
       next:PPatternList;
       include:boolean;
       Pattern:String;
     end;



{ForceDir: true == success, specified directory will exist}
function ForceDir (const name:string):boolean;
{ForceFile: true == success, path to specified file will be valid after call}
function ForceFilePath (const name:string):boolean;
{FCopy: true == file successfully copied, false otherwise}
function FCopy (const src, dst:string; OverWrite:boolean):boolean;
{Creates a flag (with creating neccesary directories, true=success)}
function CreateFlag (const name:string):boolean;
{DeleteFlag is an alias for Extended_Delete}
function DeleteFlag (const name:string):boolean;
{FTime returns int64 timestamp for a given file name}
{It returns value 0 on error (file not found) or other}
function FTime (const name:string):int64;
{Determines whether specifed file does exist or not. Use this function instead
 of Delphi function with the same name}
{So the SysUtils unit should be referenced before this unit}
function FileExists (const name:string):boolean;
{Determines whether the specified file exists and actually is a directory}
function DirExists (const name:string):boolean;
{Determines whether a path to specified file exists or not}
function FilePathExists (const name:string):boolean;
{Leaves the specified directory totally empty}
function DelTree (const dir:string):boolean;
{GetCurrentDir and SetCurrentDir:
delphi built-in functions are recommended to be used:
syntax:
function GetCurrentDir: string;
function SetCurrentDir(const Dir: string): Boolean;
they both are defined in module SysUtils}
{Checks if the name matches to specified pattern}
function MatchesPattern (Name, Pattern:PChar):boolean;
{Checks if the name matches to specified pattern list}
function MatchesPatternList (const Name:string; P:PPatternList):boolean;
{Deletes file, read-only files are deleted as well as normal}
function Extended_Delete (const path:string):boolean;
{Deletes file. If all attemps to delete file fail, clears file contents.}
function Extended_Delete_Contents (const path:string):boolean;
{XWrite: does blockwrite&checks amount of bytes written}
function XWrite (h:THandle; var t; size:cardinal):boolean;
{XRead: does blockread&checks amount of bytes written}
function XRead (h:THandle; var t; size:cardinal):boolean;
{total share mode: read/write/delete}
{$IFDEF MSWINDOWS}
function GetTotalShareMode:cardinal;
{$ENDIF}
{$IFDEF LINUX}
function CloseHandle (h:THandle):boolean;
function GetTickCount:cardinal;
{$ENDIF}
function ResetSharedFile (const name:string):THandle;
function RewriteSharedFile (const name:string; Shared:boolean):THandle;
function AppendSharedFile (const name:string; Shared:boolean):THandle;
function CloseSharedFile (h:THandle):boolean;
function IsErrorHandle (h:THandle):boolean;
function HandleToString (f:THandle; maxsize:cardinal; failifgreater:boolean;
                         var data:string):boolean;
function FileToString (const Name:string; maxsize:cardinal;
                       failifgreater:boolean; var data:string):boolean;
function StringToHandle (data:string; handle:THandle):boolean;
function StringToFile (data:string; const Name:string; Shared:boolean):boolean;
function StringToFileForced (data:string; const Name:string; Shared:boolean):boolean;
{$IFDEF MSWINDOWS}
function StringToFileSoft (data:string; const Name:string):boolean;
{$ENDIF}
function InterpretPatternList (const s:string):PPatternList;
procedure FreePatternList (var P:PPatternList);
function CopyToHandle (const Source:string; handle:THandle):boolean;
function CreateUniqueFile (const Where:string; const Ext:String;
                           var GotName:string):THandle;
function getenv (S : string) : string;
function GetTickDist (from:cardinal):cardinal;
{Closes array of windows handles;
 Returns false when at least one error was occured}
function CloseHandles (const Handles:array of THandle):boolean;
{Returns true if at least one of the handles in the array is invalid}
function AreErrorHandles (const Handles:array of THandle):boolean;
function EatNewLines (s:string; p:integer):integer;
function GetEndLinePtr (s:string; p:integer):integer;
{Advances pointer to the next line in the multiline string (read file?)}
function GetNextLinePtr (s:string; p:integer):integer;
function MakePrintable (s:string):string;
function AppendStringToFile (data:string; const Name:string; Shared:boolean):boolean;

implementation

const CopyBufSize={262144}16384;

type tbuffer=array [0..CopyBufSize-1] of char;
     pbuffer=^tbuffer; 

{function Str2PChar (const src:string):PChar;
begin
  Str2PChar:=StrAlloc (length (src)+1);
  StrPCopy (result, src);
end;}

{$IFDEF MSWINDOWS}
function DirExists (const name:string):boolean;
var tmp:cardinal;
begin
  tmp:=GetFileAttributes (PChar (name));
  DirExists:=(tmp<>$ffffffff) and ((tmp and FILE_ATTRIBUTE_DIRECTORY)<>0);
end;
{$ENDIF}

{$IFDEF LINUX}
function DirExists (const name:string):boolean;
var buf:TStatBuf;
begin
  DirExists:=(stat (PChar (name), buf)=0) and ((buf.st_mode and S_IFDIR)<>0);
end;
{$ENDIF}



function FilePathExists (const name:string):boolean;
begin
  Result:=DirExists (ExtractFileDir (name));
end;


{Included to avoid linkning of VCL to judge or other programs}
function ForceDir (const name:string):boolean;
var dirup, tmpname:string;
begin
  tmpname:=ExcludeTrailingPathDelimiter (name);
  dirup:=extractfiledir (tmpname);
  if (dirup=tmpname) or (tmpname='') or DirExists (tmpname) then ForceDir:=true
  else ForceDir:=ForceDir (dirup) and CreateDir (tmpname);
end;


function ForceFilePath (const name:string):boolean;
begin
  Result:=ForceDir (ExtractFileDir (name))
end;

{$IFDEF MSWINDOWS}
function CreateFileForced (const name:string; access, share,
                           mode, flags:cardinal):THandle;
begin
  Result:=CreateFile (PChar (name), access, share, nil, mode, flags, 0);
  if IsErrorHandle (Result) and not FilePathExists (name) then begin
    if ForceFilePath (name) then
      Result:=CreateFile (PChar (name), access, share, nil, mode, flags, 0);
  end;
end;
{$ENDIF}
{$IFDEF LINUX}
function openForced (const name:string; flags, mode:cardinal):integer;
begin
  Result:=open (PChar (name), flags, mode);
  if IsErrorHandle (Result) and not FilePathExists (name) then begin
    if ForceFilePath (name) then
      Result:=open (PChar (name), flags, mode);
  end;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
function FCopy (const src, dst:string; OverWrite:boolean):boolean;
var shandle, dhandle:THandle;
    buffer:pbuffer;
    specmode:cardinal;
    bytes:cardinal;
label _esrc, _ebuf;
begin
  FCopy:=false;
  {if not ForceFile (dst) then exit;}
  if CopyWindows then begin
    FCopy:=CopyFile (PChar (src), PChar (dst), not OverWrite);
    if not Result and not FilePathExists (dst) then
      if ForceFilePath (dst) then
        FCopy:=CopyFile (PChar (src), PChar (dst), not OverWrite);
  end else begin
    shandle:=CreateFile (PChar (src), GENERIC_READ, FILE_SHARE_READ,
                         nil, OPEN_EXISTING,
              FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN,
              0);
    if IsErrorHandle (shandle) then exit;
    if OverWrite then specmode:=CREATE_ALWAYS else
                      specmode:=CREATE_NEW;
    dhandle:=CreateFileForced (dst, GENERIC_WRITE, 0, specmode,
                               FILE_ATTRIBUTE_NORMAL);
    if IsErrorHandle (dhandle) then
      begin
        _esrc:
        CloseHandle (shandle);
        exit;
      end;
    new (buffer);
    repeat
      if not ReadFile (shandle, buffer^, sizeof (buffer^), bytes, nil) then
        begin
          _ebuf:
          dispose (buffer);
          CloseHandle (dhandle);
          Extended_Delete (dst);
          goto _esrc;
        end;
      if bytes=0 then break;
      if not XWrite (dhandle, buffer^, bytes) then
        goto _ebuf;
    until false;
    dispose (buffer);
    FCopy := CloseHandle (dhandle) and CloseHandle (shandle);
  end;
end;
{$ENDIF}
{$IFDEF LINUX}
function FCopy (const src, dst:string; OverWrite:boolean):boolean;
var shandle, dhandle:THandle;
    buffer:pbuffer;
    specmode:cardinal;
    bytes:integer;
label _esrc, _ebuf;
begin
  FCopy:=false;
  shandle:=open (PChar (src), O_RDONLY);
  if IsErrorHandle (shandle) then exit;
  if OverWrite then specmode:=O_TRUNC else
                    specmode:=O_CREAT or O_EXCL;
  dhandle:=openForced (dst, specmode or O_WRONLY, S_IRWXU);
  if IsErrorHandle (dhandle) then
    begin
      _esrc:
      __close (shandle);
      exit;
    end;
  new (buffer);
  repeat
    bytes:=__read (shandle, buffer^, sizeof (buffer^));
    if bytes<0 then begin
      _ebuf:
      dispose (buffer);
      __close (dhandle);
      Extended_Delete (dst);
      goto _esrc;
    end;
    if bytes=0 then break;
    if not XWrite (dhandle, buffer^, bytes) then
      goto _ebuf;
  until false;
  dispose (buffer);
  FCopy := (__close (dhandle)=0) and (__close (shandle)=0);
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function CopyToHandle (const Source:string; handle:THandle):boolean;
var shandle:THandle;
    buffer:pbuffer;
    bytes:cardinal;
label _ebuf;
begin
  Result:=false;
  shandle:=CreateFile (PChar (Source), GENERIC_READ, FILE_SHARE_READ,
                       nil, OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN,
            0);
  if IsErrorHandle (shandle) then exit;
  new (buffer);
  repeat
    if not ReadFile (shandle, buffer^, sizeof (buffer^), bytes, nil) then begin
      _ebuf:
      dispose (buffer);
      CloseHandle (shandle);
      exit;
    end;
    if bytes=0 then break;
    if not XWrite (handle, buffer^, bytes) then
      goto _ebuf;
  until false;
  dispose (buffer);
  Result:= CloseHandle (shandle);
end;
{$ENDIF}


{$IFDEF LINUX}
function CopyToHandle (const Source:string; handle:THandle):boolean;
var shandle:THandle;
    buffer:pbuffer;
    bytes:integer;
label _ebuf;
begin
  Result:=false;
  shandle:=open (PChar (Source), O_RDONLY);
  if IsErrorHandle (shandle) then exit;
  new (buffer);
  repeat
    bytes:=__read (shandle, buffer^, sizeof (buffer^));
    if bytes<0 then begin
      _ebuf:
      dispose (buffer);
      __close (shandle);
      exit;
    end;
    if bytes=0 then break;
    if not XWrite (handle, buffer^, bytes) then
      goto _ebuf;
  until false;
  dispose (buffer);
  Result:= __close (shandle)=0;
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function GetTotalShareMode:cardinal;
begin
  if Win32Platform=VER_PLATFORM_WIN32_NT then
    Result:=FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE
  else
    Result:=FILE_SHARE_READ or FILE_SHARE_WRITE;
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function CreateFlag (const name:string):boolean;
var handle:THandle;
begin
  CreateFlag:=false;
  handle:=CreateFileForced (name, GENERIC_WRITE, GetTotalShareMode,
                            CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL);
  if not IsErrorHandle (handle) then CreateFlag:=CloseHandle (handle)
end;
{$ENDIF}


{$IFDEF LINUX}
function CreateFlag (const name:string):boolean;
var handle:THandle;
begin
  CreateFlag:=false;
  handle:=openForced (name, O_TRUNC or O_WRONLY, S_IRWXU);
  if not IsErrorHandle (handle) then CreateFlag:=__close (handle)=0;
end;
{$ENDIF}



function DeleteFlag (const name:string):boolean;
begin
  DeleteFlag:=Extended_Delete (name);
end;

{$IFDEF MSWINDOWS}
function FTime (const name:string):int64;
var handle:THandle;
    crtime, actime, wrtime:filetime;
begin
  FTime:=0;
  handle:=CreateFile (PChar (name), GENERIC_READ, FILE_SHARE_READ,
                       nil, OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);
  if not IsErrorHandle (handle) then
    begin
      if GetFileTime (handle, @crtime, @actime, @wrtime) then
        FTime:=int64 (wrtime);
      if not CloseHandle (handle) then FTime:=0;
    end;
end;
{$ENDIF}


{$IFDEF LINUX}
function FTime (const name:string):int64;
var buf:TStatBuf;
begin
  FTime:=0;
  if stat (PChar (name), buf)<>0 then exit;
  FTime:=int64 (buf.st_mtime)*10000000+116444736000000000;
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function FileExists (const name:string):boolean;
begin
  FileExists:=GetFileAttributes (PChar (name))<>$ffffffff;
end;
{$ENDIF}


{$IFDEF LINUX}
function FileExists (const name:string):boolean;
begin
  FileExists:=access (PChar (name), 0)=0;
end;
{$ENDIF}

{ÂÑÅ ÏÎÒÐÈ}
function DelTree (const dir:string):boolean;
var tmp:TSearchRec;
    path:string;
    Res1, Res2:boolean;
begin
  Result:=true;
  if (dir='') or (dir='\') or (dir='/') then runerror (239);
  path:=IncludeTrailingPathDelimiter (dir);
  if FindFirst (path+'*', faAnyFile, tmp)<>0 then exit;
  repeat
    if (tmp.attr and faDirectory)<>0 then begin
      if (tmp.name<>'.') and (tmp.name<>'..') then begin
        Res1:=DelTree (path+tmp.name);
        {$IFDEF MSWINDOWS}
        if (tmp.attr and faReadOnly)<>0 then
          SetFileAttributes (PChar (path+tmp.name), tmp.attr and not FILE_ATTRIBUTE_READONLY);
        {$ENDIF}
        Res2:=RemoveDir (path+tmp.name);
        Result:=Result and Res1 and Res2;
      end
    end else begin
      Res1:=Extended_Delete (path+tmp.name);
      Result:=Result and Res1;
    end;
  until FindNext (tmp)<>0;
  sysutils.FindClose (tmp);
end;




function Extended_Delete (const path:string):boolean;
var tmp:cardinal;
begin
  Result:=false;
  if sysutils.DeleteFile (path) then begin Result:=true; exit end;
  {$IFDEF MSWINDOWS}
  tmp:=GetFileAttributes (PChar (path));
  if tmp<>$ffffffff then begin
    if (tmp and FILE_ATTRIBUTE_READONLY)<>0 then begin
      SetFileAttributes (PChar (path), tmp and not FILE_ATTRIBUTE_READONLY);
      if sysutils.DeleteFile (path) then begin Result:=true; exit end;
    end;
  end else Result:=true;
  {$ENDIF}
end;


function Extended_Delete_Contents (const path:string):boolean;
var handle:THandle;
begin
  Result:=false;
  if Extended_Delete (path) then begin Result:=true; exit end;
  {$IFDEF MSWINDOWS}
  handle:=CreateFile (PChar (path), GENERIC_WRITE,
                      FILE_SHARE_READ or FILE_SHARE_WRITE,
                      nil, OPEN_EXISTING,
                      FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);
  if not IsErrorHandle (handle) then begin
    SetFilePointer (handle, 0, nil, FILE_BEGIN); 
    SetEndOfFile (handle);
    CloseHandle (handle);
  end;
  {$ENDIF}
end;


function MatchesPattern (Name, Pattern:PChar):boolean;
type tarr=array of boolean;
var i, j, t, p:integer;
    c, cs, q:char;
    a:tarr;
    r:boolean;
begin
(*
v def: a[m][n]=comps (string [m], pattern [n])
v ********************************************
v if (pattern [n]=='*') a[m][n]=a[m+1][n] | a[m][n+1] ;
v else if (pattern [n]=='?') a[m][n]=a[m+1][n+1];
v else if (pattern [n]==string [m]) a[m][n]=a[m+1][n+1];
v else a[m][n]=0;
v comps (string, "") = (string [0] == 0);
*)
(*int i, j, t, p;
/*char *a=malloc (1 + max (t=strlen (string), p=strlen (pattern)));*/
char r, a[512];
register char c;*)
 (* optimization 1: compare starting parts of strings *)
  repeat
    c:=pattern [0];
    cs:=Name[0];
    if c='*' then break;
    if c=#0 then begin Result:=cs=#0; exit end;
    if cs=#0 then begin Result:=false; exit end;
    if (c<>'?') and (UpCase(c)<>UpCase (cs)) then
      begin Result:=false; exit end;
    inc (pattern); inc (Name);
  until false;

  if pattern[1]=#0 then begin Result:=true; exit end;    (* '*' *)

  if (pattern[1]<>'*') and (pattern[1]<>'?') and
     (UpCase(pattern[1])=pattern[1]) and
     (pattern[2]='*') and (pattern[3]=#0) then
     begin Result:=StrScan (Name, pattern [1])<>nil; exit end;
     (* something like '*.*' *)

  t:=StrLen (Name);
  p:=StrLen (pattern);

  SetLength (a, t+1);
  fillchar (a[0], length (a), 0);
  a[t]:=true;
  for j:=p-1 downto 0 do
    case Pattern[j] of
      '*':begin
	    r:=false;
            for i:=t downto 0 do begin
              r:=r or a[i];
              a[i]:=r;
            end;
          end;
      '?':begin
            move (a[1], a[0], t);
            a[t]:=false;
	  end
      else begin
	q:=UpCase (pattern [j]);
	for i:=0 to t do
	  if UpCase (Name [i])=q then a[i]:=a[i+1] else a[i]:=false;
      end;
    end;
  Result:=a[0];
end;


function MatchesPatternList (const Name:string; P:PPatternList):boolean;
begin
  Result:=true;
  while P<>nil do begin
    if P^.include
    then Result:=Result or MatchesPattern (PChar (Name), PChar (P^.Pattern))
    else Result:=Result and not
                           MatchesPattern (PChar (Name), PChar (P^.Pattern));
    P:=P^.next;
  end;
end;


{$IFDEF MSWINDOWS}
function XWrite (h:THandle; var t; size:cardinal):boolean;
var res:DWORD;
begin
  XWrite:=WriteFile (h, t, size, res, nil) and (res=size); 
end;
{$ENDIF}


{$IFDEF LINUX}
function XWrite (h:THandle; var t; size:cardinal):boolean;
begin
  XWrite:=__write (h, t, size)=size; 
end;
{$ENDIF}



{$IFDEF MSWINDOWS}
function XRead (h:THandle; var t; size:cardinal):boolean;
var res:DWORD;
begin
  XRead:=ReadFile (h, t, size, res, nil) and (res=size);
end;
{$ENDIF}


{$IFDEF LINUX}
function XRead (h:THandle; var t; size:cardinal):boolean;
begin
  XRead:=__read (h, t, size)=size; 
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function ResetSharedFile (const name:string):THandle;
begin
  Result:=
  CreateFile (PChar (name), GENERIC_READ, GetTotalShareMode, nil,
              OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0);
end;
{$ENDIF}


{$IFDEF LINUX}
function ResetSharedFile (const name:string):THandle;
begin
  Result:=open (PChar (name), O_RDONLY);
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function RewriteSharedFile (const name:string; Shared:boolean):THandle;
var shmode:cardinal;
begin
  if Shared then shmode:=GetTotalShareMode else shmode:=0;
  Result:=
  CreateFile (PChar (name), GENERIC_WRITE, shmode, nil,
              CREATE_ALWAYS, FILE_FLAG_SEQUENTIAL_SCAN or FILE_ATTRIBUTE_NORMAL,
              0);
end;
{$ENDIF}


{$IFDEF LINUX}
function RewriteSharedFile (const name:string; Shared:boolean):THandle;
begin
  Result:=open (PChar (name), O_WRONLY or O_TRUNC, S_IRWXU);
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function RewriteSharedFileForced (const name:string; Shared:boolean):THandle;
var shmode:cardinal;
begin
  if Shared then shmode:=GetTotalShareMode else shmode:=0;
  Result:=
  CreateFileForced (PChar (name), GENERIC_WRITE, shmode, CREATE_ALWAYS, 
                    FILE_FLAG_SEQUENTIAL_SCAN or FILE_ATTRIBUTE_NORMAL);
end;
{$ENDIF}


{$IFDEF LINUX}
function RewriteSharedFileForced (const name:string; Shared:boolean):THandle;
begin
  Result:=openForced (PChar (name), O_WRONLY or O_TRUNC, S_IRWXU);
end;
{$ENDIF}



{$IFDEF MSWINDOWS}
function ReOpenSharedFile (const name:string; Shared:boolean):THandle;
var shmode:cardinal;
begin
  if Shared then shmode:=GetTotalShareMode else shmode:=0;
  Result:=
  CreateFile (PChar (name), GENERIC_WRITE, shmode, nil,
              OPEN_ALWAYS, FILE_FLAG_SEQUENTIAL_SCAN or FILE_ATTRIBUTE_NORMAL,
              0);
end;
{$ENDIF}


{$IFDEF LINUX}
function ReOpenSharedFile (const name:string; Shared:boolean):THandle;
begin
  Result:=open (PChar (name), O_WRONLY or O_CREAT, S_IRWXU);
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
function AppendSharedFile (const name:string; Shared:boolean):THandle;
var shmode:cardinal;
begin
  if Shared then shmode:=GetTotalShareMode else shmode:=0;
  Result:=
  CreateFile (PChar (name), GENERIC_WRITE, shmode, nil,
              OPEN_ALWAYS, FILE_FLAG_SEQUENTIAL_SCAN or FILE_ATTRIBUTE_NORMAL,
              0);
  if not IsErrorHandle (Result) then
   if (SetFilePointer (Result, 0, nil, FILE_END)=$ffffffff) and
      (GetLastError<>NO_ERROR) then  begin
      CloseHandle (Result);
      Result:=INVALID_HANDLE_VALUE;
   end;
end;
{$ENDIF}


{$IFDEF LINUX}
function AppendSharedFile (const name:string; Shared:boolean):THandle;
begin
  Result:=open (PChar (name), O_WRONLY or O_CREAT or O_APPEND, S_IRWXU);
end;
{$ENDIF}


{$IFDEF LINUX}
function CloseHandle (h:THandle):boolean;
begin
  CloseHandle:=__close (h)=0;
end;
{$ENDIF}


function CloseSharedFile (h:THandle):boolean;
begin
  Result:=CloseHandle (h);
end;


{$IFDEF MSWINDOWS}
function IsErrorHandle (h:THandle):boolean;
begin
  Result:=(h=0) or (h=INVALID_HANDLE_VALUE);
end;
{$ENDIF}


{$IFDEF LINUX}
function IsErrorHandle (h:THandle):boolean;
begin
  Result:=h<0;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
function HandleToString (f:THandle; maxsize:cardinal; failifgreater:boolean;
                         var data:string):boolean;
var t:DWORD;
begin
  data:='';
  Result:=false;
  t:=getfilesize (f, nil);
  if t=$ffffffff then begin CloseHandle (f); exit; end;
  if t>maxsize then begin
    if failifgreater then begin closehandle (f); exit end;
    t:=maxsize;
  end;
  SetLength (data, t);
  if (t>0) and not XRead (f, data[1], t) then begin
    data:=''; closehandle (f); exit
  end;
  Result:=CloseHandle (f);
end;
{$ENDIF}


{$IFDEF LINUX}
function HandleToString (f:THandle; maxsize:cardinal; failifgreater:boolean;
                         var data:string):boolean;
var t:integer;
    buf:TStatBuf;
begin
  data:='';
  Result:=false;
  if fstat (f, buf)<>0 then begin CloseHandle (f); exit end;
  t:=buf.st_size;
  if t>maxsize then begin
    if failifgreater then begin closehandle (f); exit end;
    t:=maxsize;
  end;
  SetLength (data, t);
  if (t>0) and not XRead (f, data[1], t) then begin
    data:=''; closehandle (f); exit
  end;
  Result:=CloseHandle (f);
end;
{$ENDIF}

function FileToString (const Name:string; maxsize:cardinal;
                       failifgreater:boolean; var data:string):boolean;
var f:THandle;
begin
  f:=ResetSharedFile (Name);
  if IsErrorHandle (f) then Result:=false
  else Result:=HandleToString (F, maxsize, failifgreater, data);
end;


function StringToHandle (data:string; handle:THandle):boolean;
begin
  StringToHandle:=not ((length (data)>0) and not XWrite (handle, data[1], length (data)));
end;


function StringToFile (data:string; const Name:string; Shared:boolean):boolean;
var f:THandle;
begin
  Result:=false;
  f:=RewriteSharedFile (Name, Shared);
  if IsErrorHandle (f) then exit;
  if not StringToHandle (data, f) then begin
    CloseSharedFile (f); exit
  end;
  Result:=CloseSharedFile (f);
end;


function StringToFileForced (data:string; const Name:string; Shared:boolean):boolean;
var f:THandle;
begin
  Result:=false;
  f:=RewriteSharedFileForced (Name, Shared);
  if IsErrorHandle (f) then exit;
  if not StringToHandle (data, f) then begin
    CloseSharedFile (f); exit
  end;
  Result:=CloseSharedFile (f);
end;


function AppendStringToFile (data:string; const Name:string; Shared:boolean):boolean;
var f:THandle;
begin
  Result:=false;
  f:=AppendSharedFile (Name, Shared);
  if IsErrorHandle (f) then exit;
  if not StringToHandle (data, f) then begin
    CloseSharedFile (f); exit
  end;
  Result:=CloseSharedFile (f);
end;


{$IFDEF MSWINDOWS}
function StringToFileSoft (data:string; const Name:string):boolean;
var f:THandle;
begin
  Result:=false;
  f:=ReOpenSharedFile (Name, True);
  if IsErrorHandle (f) then exit;
  if ((length (data)>0) and not XWrite (f, data[1], length (data)))
     or not SetEndOfFile (f) then begin
    CloseSharedFile (f); exit
  end;
  Result:=CloseSharedFile (f);
end;
{$ENDIF}


function InterpretPatternList (const s:string):PPatternList;
var t:^PPatternList;
    cs:string;
    tpos:integer;
begin
  Result:=nil; t:=@Result;
  cs:=TrimLeft (s);
  while cs<>'' do begin
    tpos:=pos (' ', cs);
    if tpos=0 then tpos:=length (cs)+1;
    new (t^);
    with t^^ do begin
      if cs[1]='!' then begin
        include:=false;
        Pattern:=copy (cs, 2, tpos-1);
      end else begin
        include:=true;
        Pattern:=copy (cs, 1, tpos);
      end;
      next:=nil;
    end;
    t:=@t^.next;
    cs:=TrimLeft (copy (cs, tpos+1, length (cs)));
  end;
end;

procedure FreePatternList (var P:PPatternList);
var q:PPatternList;
begin
  while p<>nil do begin
    q:=p^.next;
    dispose (p);
    p:=q;
  end;
end;


{$Q-,R-}
function sumover (a, b:cardinal):cardinal;
begin
  Result:=a+b;
end;
{$Q+,R+}

{$IFDEF LINUX}
function GetTickCount:cardinal;
begin
  GetTickCount:=0;
end;
{$ENDIF}


function CreateUniqueFile (const Where:string; const Ext:String;
                           var GotName:string):THandle;
var tmp, retries:cardinal;
begin
  randomize;
  tmp:=GetTickCount;
  for retries:=1 to 5 do begin
    GotName:=format ('%x', [tmp])+Ext;
    {$IFDEF MSWINDOWS}
    Result:=CreateFile (PChar (
       IncludeTrailingPathDelimiter (Where)+GotName),
       GENERIC_WRITE, 0, nil, CREATE_NEW, FILE_FLAG_SEQUENTIAL_SCAN or
       FILE_ATTRIBUTE_NORMAL, 0);
    {$ENDIF}
    {$IFDEF LINUX}
    Result:=open (PChar (IncludeTrailingPathDelimiter (Where)+GotName),
                  O_WRONLY or O_CREAT or O_EXCL, S_IRWXU);
    {$ENDIF}
    if not IsErrorHandle (Result) then break;
    tmp:=sumover (tmp, cardinal (random (123456789)));
    tmp:=sumover (tmp, GetTickCount);
  end;
end;

{$IFDEF MSWINDOWS}
function getenv (S : string) : string;
begin
  setlength (Result, 4096);
  setlength (Result, GetEnvironmentVariable (PChar(S), PChar (Result), 4096));
end;
{$ENDIF}


{$IFDEF LINUX}
function getenv (S : string) : string;
begin
  Result:=GetEnvironmentVariable (PChar (s));
end;
{$ENDIF}

{$Q-,R-}
function GetTickDist (from:cardinal):cardinal;
begin
  Result:=GetTickCount-from;
end;
{$Q+,R+}

function CloseHandles (const Handles:array of THandle):boolean;
var i:integer;
begin
  Result:=true;
  for i:=low (handles) to high (handles) do
    Result:=Result and CloseHandle (Handles [i]);
end;


function AreErrorHandles (const Handles:array of THandle):boolean;
var i:integer;
begin
  Result:=false;
  for i:=low (handles) to high (handles) do
    Result:=Result or IsErrorHandle (Handles [i]);
end;


function EatNewLines (s:string; p:integer):integer;
begin
  while (p<=length (s)) and (s[p] in [#10..#13]) do inc (p);
  Result:=p;
end;


function GetEndLinePtr (s:string; p:integer):integer;
begin
  while (p<=length (s)) and not (s[p] in [#10..#13]) do inc (p);
  Result:=p;
end;


function GetNextLinePtr (s:string; p:integer):integer;
begin
  Result:=EatNewLines (s, GetEndLinePtr (s, p));
end;


function MakePrintable (s:string):string;
var tmp:string;
    i:integer;
begin
  tmp:='';
  for i:=1 to length (s) do
    if s[i]<#32 then tmp:=tmp+format ('#%d', [ord (s[i])])
    else tmp:=tmp+s[i];
  MakePrintable:=tmp;
end;



end.
