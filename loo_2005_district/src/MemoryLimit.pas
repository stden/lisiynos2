{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P-,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
unit MemoryLimit;

interface

uses SysUtils, Windows;

function InitMemoryLimit:boolean;
function processmemorylimitdata (ProcessID:DWORD; var MaxMemoryUsed:int64):boolean;

implementation

type PERF_OBJECT_TYPE=record
       TotalByteLength:DWORD;
       DefinitionLength:DWORD;
       HeaderLength:DWORD;
       ObjectNameTitleIndex:DWORD;
       ObjectNameTitle:PWideChar;
       ObjectHelpTitleIndex:DWORD;
       ObjectHelpTitle:PWideChar;
       DetailLevel:DWORD;
       NumCounters:DWORD;
       DefaultCounter:integer;
       NumInstances:Integer;
       CodePage:DWORD;
       PerfTime:int64;
       PerfFreq:int64;
     end;
     PPERF_OBJECT_TYPE=^PERF_OBJECT_TYPE;
     PERF_COUNTER_DEFINITION=record
       ByteLength:DWORD;
       CounterNameTitleIndex:DWORD;
       CounterNameTitle:PWideChar;
       CounterHelpTitleIndex:DWORD;
       CounterHelpTitle:PWideChar;
       DefaultScale:DWORD;
       DetailLevel:DWORD;
       CounterType:DWORD;
       CounterSize:DWORD;
       CounterOffset:DWORD;
     end;
     PPERF_COUNTER_DEFINITION=^PERF_COUNTER_DEFINITION;
     PERF_DATA_BLOCK=record
       Signature:array [0..3] of WideChar;
       LittleEndian:DWORD;
       Version, Revision, TotalByteLength, HeaderLength, NumObjectTypes:DWORD;
       DefaultObject:DWORD;
       SysTime:SYSTEMTIME;
       PerfTime, PerfFreq, PerfTime100nSec:int64;
       SystemNameLength, SystemNameOffset:DWORD;
     end;
     PPERF_DATA_BLOCK=^PERF_DATA_BLOCK;
     PERF_INSTANCE_DEFINITION=record
       ByteLength, ParentObjectTitleIndex, ParentObjectInstance:DWORD;
       UniqueID, NameOffset, NameLength:DWORD;
     end;
     PPERF_INSTANCE_DEFINITION=^PERF_INSTANCE_DEFINITION;


  


const StrS=5;
      OBJ_ID=1;
      PID_ID=2;

const names:array [1..StrS] of string = ('Process', 'ID Process', 'Working Set Peak', 'Working Set', 'Private Bytes');
var theirid:array [1..StrS] of cardinal;
    queryname:string;

function InitMemoryLimit:boolean;
var key:HKey;
    strings:array of char;
    CurLength:cardinal;
    i, ptr, curid, tmp:integer;
begin
  Result:=false;
  if RegOpenKeyEx (HKEY_LOCAL_MACHINE,
   'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009',
   0, KEY_READ, key)<>ERROR_SUCCESS then exit;
  if RegQueryInfoKey(key, nil, nil, nil, nil, nil, nil, nil, nil, @CurLength,
                     nil, nil)<>ERROR_SUCCESS then begin
    RegCloseKey (key);
    exit;
  end;
  inc (CurLength);
  setlength (strings, CurLength+2);
  strings [CurLength]:=#0; strings [CurLength+1]:=#0;
  if RegQueryValueEx(key, 'Counter', nil, nil, @strings[0], 
                     @CurLength)<>ERROR_SUCCESS then begin
    RegCloseKey (key);
    exit;
  end;
  if RegCloseKey (key)<>ERROR_SUCCESS then exit;
  ptr:=0; fillchar (theirid, sizeof (theirid), 0);
  while strings[ptr]<>#0 do begin
    val (PChar (@strings[ptr]), curid, tmp);
    inc (ptr, strlen (@strings[ptr])+1);
    if tmp=0 then
      for i:=1 to StrS do
        if names[i]=Pchar (@strings[ptr]) then
          theirid[i]:=curid;
    if strings[ptr]<>#0 then inc (ptr, strlen (@strings[ptr])+1);
  end;
  for i:=1 to StrS do
    if theirid[i]=0 then exit;
  str (theirid[1], queryname);
  Result:=true;
end;



const LastMemoryAllocation:cardinal=65536;
      MemoryAllocationIncrement=32768;


function processmemorylimitdata (ProcessID:DWORD; var MaxMemoryUsed:int64):boolean;
var offsets, sizes:array [2..StrS] of cardinal;

function getcounter (where:Pointer; what:integer):int64;
begin
  if sizes [what]=4 then getcounter:=PDWORD (where)^
                    else getcounter:=PInt64 (where)^;
end;

var tempsize:cardinal;
    cnt, i, j, res, ptr, p2:cardinal;
    buffer:array of char;
    mem, max:int64;
begin
  Result:=false;
  repeat
    tempsize:=LastMemoryAllocation;
    SetLength (buffer, tempsize);
    res:=RegQueryValueEx (HKEY_PERFORMANCE_DATA, PChar (queryname), nil, nil, 
                          @buffer[0], @tempsize);
    if res=ERROR_SUCCESS then break;
    if res<>ERROR_MORE_DATA then exit;
    inc (LastMemoryAllocation, MemoryAllocationIncrement);
  until LastMemoryAllocation<=1 shl 28;
  if res<>ERROR_SUCCESS then exit;
  with PPERF_DATA_BLOCK (@buffer[0])^ do begin
    if Signature<>'PERF' then exit;
    ptr:=HeaderLength;
  end;
  while (ptr<tempsize) and (PPERF_OBJECT_TYPE (@buffer[ptr]).ObjectNameTitleIndex<>theirid[1]) do
    inc (ptr, PPERF_OBJECT_TYPE (@buffer[ptr]).TotalByteLength);
  if ptr>=tempsize then exit;
  with PPERF_OBJECT_TYPE (@buffer[ptr])^ do begin
    if NumInstances<0 then exit;
    p2:=ptr+HeaderLength;
    fillchar (sizes, sizeof (sizes), 0);
    for i:=1 to NumCounters do begin
      if p2>=tempsize then exit; {fatal}
      with PPERF_COUNTER_DEFINITION (@buffer[p2])^ do begin
        for j:=2 to StrS do
          if (theirid[j]=CounterNameTitleIndex) and (CounterSize in [4, 8]) then begin
            offsets[j]:=CounterOffset;
            sizes[j]:=CounterSize;
          end;
        inc (p2, ByteLength);
      end;
    end;
    if sizes[2]=0 then exit;
    p2:=ptr+DefinitionLength;
    for i:=1 to NumInstances do begin
      if p2>=tempsize then exit;
      with PPERF_INSTANCE_DEFINITION (@buffer[p2])^ do begin
        if getcounter (@buffer[p2+ByteLength+offsets[2]], 2)=ProcessID then begin
          cnt:=0; max:=0;
          for j:=3 to StrS do
            if sizes[j]<>0 then begin
              mem:=getcounter (@buffer[p2+ByteLength+offsets[j]], j);
              if mem>max then max:=mem;
              inc (cnt);
            end;
          Result:=cnt>0;
          MaxMemoryUsed:=max;
          exit;
        end;
        inc (p2, ByteLength+PDWORD (@buffer[p2+ByteLength])^);
      end;
    end;
  end;
end;

end.
