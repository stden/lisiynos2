{ fp }
(* Problem:   GOODWAYS
 * Contest:   UOI-2005, tour 1
 * Type:      Solution
 * Author:    Savchuk Sergey
 * Date:      12.04.2005
 * Language:  Pascal
 * Compiler:  Free Pascal 1.0.10
 * Algorithm: Recursion with memo
 *)
Var a:array[0..201,0..201] of byte;
    s:array[0..201,0..201] of longint;
    c:array[0..201,0..201,0..201] of longint;
    M,N,K,i,j,count: longint;
    fi,fo: Text;

Function max(a,b:int64):int64; Begin if a>b Then max:=a Else max:=b End;

Function Calc(k,i,j:longint):longint; Var d: longint;
Begin
     if c[k,i,j]=0 Then Begin d:=s[i,j]-a[i,j];
      if k>=d-s[i-1,j] Then inc(c[k,i,j],Calc(k+s[i-1,j]-d,i-1,j));
      if k>=d-s[i,j-1] Then inc(c[k,i,j],Calc(k+s[i,j-1]-d,i,j-1));
     End; Calc:=c[k,i,j];
End;

Begin Assign(fi,'goodways.dat'); Reset(fi);
      Readln(fi,M,N,K);
      For i:=1 to M do Begin
       For j:=1 to N do read(fi,a[i,j]); Readln(fi)
      End;

      For i:=1 to m do For j:=1 to n do
       s[i,j]:=a[i,j]+max(s[i-1,j],s[i,j-1]);

      For i:=1 to m do For j:=0 to k do c[j,i,1]:=1;
      For j:=1 to n do For i:=0 to k do c[i,1,j]:=1;

      Assign(fo,'goodways.sol'); Rewrite(fo);
       Writeln(fo,s[m,n]); Writeln(fo,Calc(k,m,n));
      Close(fo)
End.

