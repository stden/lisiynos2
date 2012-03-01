{ fp }

(* Problem:   GOODWAYS
 * Contest:   UOI-2005, tour 1
 * Type:      Solution
 * Author:    Ilya Porublyov
 * Date:      unknown
 * Language:  Pascal
 * Compiler:  Free Pascal 1.0.10
 * Algorithm: The best _of _iterative_ solutions, using little memory
 *)

{$R-,Q-,S-,I-}
const MAXN=200;
      MAXK=200;

{$define USE_HEAP}

{ $ define USE_EXTENDED}

{$ifdef USE_EXTENDED}
type ResNum=extended;
{$else}
type ResNum=longint;
{$endif}

type Ways=record
            sh:integer;
            v:ResNum;
          end;
     WaysArr=array[1..MAXK+1] of Ways;
{$ifdef USE_HEAP}
     PWaysArr=^WaysArr;
{$endif}

     CellEst=record
               est:longint;
               num:integer;
{$ifdef USE_HEAP}
               nn:PWaysArr;
{$else}
               nn:WaysArr;
{$endif}
             end;
     CellEstLine=array[1..MAXN] of CellEst;
     PCellEstLine=^CellEstLine;
     
{$ifdef USE_HEAP}
     LongIntArr=array[1..MAXN] of longint;
     PLongIntArr=^LongIntArr;
{$endif}

var fv:text;
    mass:array[1..MAXN,1..MAXN] of byte;
{$ifdef USE_HEAP}
    est2:array[1..MAXN] of PLongIntArr;
{$else}
    est2:array[1..MAXN,1..MAXN] of longint;
{$endif}
    THE_M,THE_N,THE_K:byte;

    res_line_1,res_line_2:CellEstLine;
    res1,res2,r_tmp:PCellEstLine;
    THE_BEST_SUM:longint;

function max(x,y:longint):longint;
Begin
  if x>y then max:=x else max:=y;
End;

procedure MergeCells(the_v:byte;const the_est2:longint;const c1,c2:CellEst; var cres:CellEst);
var add_sh_1,add_sh_2,local_K:longint;
    i,j,k:byte;

Begin
  if c1.est>=c2.est then begin
    add_sh_1:=0;
    add_sh_2:=c1.est-c2.est;
    cres.est:=c1.est+the_v;
  end else begin
    add_sh_1:=c2.est-c1.est;
    add_sh_2:=0;
    cres.est:=c2.est+the_v;
  end;
  local_K:=(longint(THE_K)+(cres.est+the_est2-longint(the_v)))-THE_BEST_SUM;
  if local_K<0 then begin
    cres.num:=0;
    exit;
  end;

  i:=1; j:=1; k:=1;
  while((i<=c1.num)and(j<=c2.num)and
        (integer(c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh)+add_sh_1<=local_K)and
        (integer(c2.nn{$ifdef USE_HEAP}^{$endif}[j].sh)+add_sh_2<=local_K)) do begin
    if c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh+add_sh_1=c2.nn{$ifdef USE_HEAP}^{$endif}[j].sh+add_sh_2 then begin
      cres.nn{$ifdef USE_HEAP}^{$endif}[k].sh:=c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh+add_sh_1;
      cres.nn{$ifdef USE_HEAP}^{$endif}[k].v :=
         c1.nn{$ifdef USE_HEAP}^{$endif}[i].v + c2.nn{$ifdef USE_HEAP}^{$endif}[j].v;
      inc(i);
      inc(j);
      inc(k);
    end else
      if integer(c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh)+add_sh_1 <
      integer(c2.nn{$ifdef USE_HEAP}^{$endif}[j].sh)+add_sh_2 then begin
        cres.nn{$ifdef USE_HEAP}^{$endif}[k].sh:=c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh+add_sh_1;
        cres.nn{$ifdef USE_HEAP}^{$endif}[k].v:=c1.nn{$ifdef USE_HEAP}^{$endif}[i].v;
        inc(i);
        inc(k);
      end else begin
        cres.nn{$ifdef USE_HEAP}^{$endif}[k].sh:=c2.nn{$ifdef USE_HEAP}^{$endif}[j].sh+add_sh_2;
        cres.nn{$ifdef USE_HEAP}^{$endif}[k].v:=c2.nn{$ifdef USE_HEAP}^{$endif}[j].v;
        inc(j);
        inc(k);
      end;
  end;
  while((i<=c1.num)and(integer(c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh)+add_sh_1<=local_K)) do begin
    cres.nn{$ifdef USE_HEAP}^{$endif}[k].sh:=c1.nn{$ifdef USE_HEAP}^{$endif}[i].sh+add_sh_1;
    cres.nn{$ifdef USE_HEAP}^{$endif}[k].v:=c1.nn{$ifdef USE_HEAP}^{$endif}[i].v;
    inc(i);
    inc(k);
  end;
  while((j<=c2.num)and(integer(c2.nn{$ifdef USE_HEAP}^{$endif}[j].sh)+add_sh_2<=local_K)) do begin
    cres.nn{$ifdef USE_HEAP}^{$endif}[k].sh:=c2.nn{$ifdef USE_HEAP}^{$endif}[j].sh+add_sh_2;
    cres.nn{$ifdef USE_HEAP}^{$endif}[k].v:=c2.nn{$ifdef USE_HEAP}^{$endif}[j].v;
    inc(j);
    inc(k);
  end;
  cres.num:=k-1;

{$ifdef DEBUG_OUT}
  writeln('cres.num=',cres.num);
  for k:=1 to cres.num do
    writeln(cres.nn{$ifdef USE_HEAP}^{$endif}[k].sh,#8,cres.nn{$ifdef USE_HEAP}^{$endif}[k].v);
{$endif}
End;

{$ifdef USE_HEAP}
procedure ClearEstLine(var estl:CellEstLine);
var i:byte;
Begin
  for i:=1 to THE_M do begin
    FreeMem(estl[i].nn,estl[i].num*sizeof(Ways));
    estl[i].num:=0;
    estl[i].nn:=nil;
  end;
End;
{$endif}

var i,j:byte;
    res_v:ResNum;

BEGIN
{$ifdef USE_HEAP}
{$ifdef DEBUG_OUT}
  writeln('MemAvail=',MemAvail);
{$endif}
{$endif}
  assign(fv,'goodways.dat'); reset(fv);
  readln(fv,THE_M,THE_N,THE_K);
  for i:=1 to THE_M do begin
    for j:=1 to THE_N do
      read(fv,mass[i,j]);
    readln(fv);
  end;
  close(fv);

{$ifdef USE_HEAP}
  for i:=THE_M downto 1 do
    GetMem(est2[i],THE_N*sizeof(longint));
{$endif}

  est2[THE_M{$ifdef USE_HEAP}]^[{$else},{$endif}THE_N]:=mass[THE_M,THE_N];

  for i:=THE_M-1 downto 1 do
    est2[i{$ifdef USE_HEAP}]^[{$else},{$endif}THE_N]:=est2[i+1{$ifdef USE_HEAP}]^[{$else},{$endif}THE_N]+mass[i,THE_N];
  for j:=THE_N-1 downto 1 do
    est2[THE_M{$ifdef USE_HEAP}]^[{$else},{$endif}j]:=est2[THE_M{$ifdef USE_HEAP}]^[{$else},{$endif}j+1]+mass[THE_M,j];

  for i:=THE_M-1 downto 1 do
    for j:=THE_N-1 downto 1 do
      est2[i{$ifdef USE_HEAP}]^[{$else},{$endif}j]:=
        max(est2[i+1{$ifdef USE_HEAP}]^[{$else},{$endif}j],est2[i{$ifdef USE_HEAP}]^[{$else},{$endif}j+1])+mass[i,j];

  THE_BEST_SUM:=est2[1{$ifdef USE_HEAP}]^[{$else},{$endif}1];

{$ifdef USE_HEAP}
  FreeMem(est2[1],THE_N*sizeof(longint));
{$endif}

  res1:=@res_line_1;
  res2:=@res_line_2;

{$ifdef USE_HEAP}
  GetMem(res1^[1].nn,1*sizeof(Ways));
  GetMem(res2^[1].nn,1*sizeof(Ways));
  for j:=2 to THE_N do begin
    GetMem(res1^[j].nn,(THE_K+1)*sizeof(Ways));
    GetMem(res2^[j].nn,(THE_K+1)*sizeof(Ways));
  end;

{$ifdef DEBUG_OUT}
  writeln('MemAvail=',MemAvail);
{$endif}
{$endif}

  for j:=1 to THE_N do begin
    if j=1 then
      res2^[1].est:=mass[1,1]
    else
      res2^[j].est:=res2^[j-1].est+mass[1,j];
    res2^[j].num:=1;
    res2^[j].nn{$ifdef USE_HEAP}^{$endif}[1].sh:=0;
    res2^[j].nn{$ifdef USE_HEAP}^{$endif}[1].v:=1;
  end;

  for i:=2 to THE_M do begin
    r_tmp:=res1;
    res1:=res2;
    res2:=r_tmp;

    res2^[1].est:=res1^[1].est+mass[i,1];
    res2^[1].num:=1;
    res2^[1].nn{$ifdef USE_HEAP}^{$endif}[1].sh:=0;
    res2^[1].nn{$ifdef USE_HEAP}^{$endif}[1].v:=1;

    for j:=2 to THE_N do
{$ifdef DEBUG_OUT}
    begin
      writeln('before calling MergeCells at r=',r,', i=',i,' (cell (',r-i+1,',',i,'))');
{$endif}
      MergeCells(mass[i,j],est2[i{$ifdef USE_HEAP}]^[{$else},{$endif}j],res1^[j],res2^[j-1],res2^[j]);
{$ifdef DEBUG_OUT}
      writeln('after calling MergeCells at r=',r,', i=',i,' (cell (',r-i+1,',',i,'))');
    end;
{$endif}
  end;

  res_v:=0;
  for i:=1 to res2^[THE_N].num do
    res_v:=res_v+res2^[THE_N].nn{$ifdef USE_HEAP}^{$endif}[i].v;
  assign(fv,'goodways.sol'); rewrite(fv);
  writeln(fv,THE_BEST_SUM);

{$ifdef USE_EXTENDED}
  writeln(fv,res_v:0:0);
{$else}
  writeln(fv,res_v);
{$endif}
  close(fv);
END.
