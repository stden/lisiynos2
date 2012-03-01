{$APPTYPE CONSOLE}

{-.$define DEBUG1}
{-$M 16384,102400,102400}

program Solution;

{$ifndef DEBUG1}
{$A-,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V-,X+,Y+}
const
  inFile                        = 'town.in';
  outFile                       = 'town.out';
{$else}
{$A-,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
const
  inFile                        = 'town.in';
  outFile                       = 'con';
  dbgFile                       = 'con';
var
  dbg                           : Text;
{$endif}

const
  maxN        = 200;
  inf       = maxlongint;

type
  int       = longint;

  PNode       = ^TNode;
  TNode       = object
    op        : char;
    left,right      : PNode;
    optTime     : int;
    procedure     Print( brackets : boolean );
    function      EvalTime : int;
    function      Optimize : PNode;
    procedure     Markup( _op : char );
  end;

var
  expr        : string;
  root        : PNode;
  optRoot     : PNode;
  time        : int;
  optTime     : int;
  tPlus       : int;
  tMult       : int;
  nodes       : array[1..maxN] of PNode;
  nNodes      : integer;

procedure TNode.Print( brackets : boolean );
begin
  if (op <> '+') and (op <> '*') then
    write( op )
  else begin
    if brackets then write( '(' );
    left^.Print( true );
    write( op );
    right^.Print( true );
    if brackets then write( ')' );
  end;
end;

function max( a, b : int ) : int;
begin
  if a > b then max := a else max := b;
end;

function TNode.EvalTime : int;
begin
  case op of
    '+' : EvalTime := tPlus + max( left^.EvalTime, right^.EvalTime );
    '*' : EvalTime := tMult + max( left^.EvalTime, right^.EvalTime );
  else
    EvalTime := 0;
  end;
end;

procedure TNode.Markup( _op : char );
begin
  if (op <> '+') and (op <> '*') or (op <> _op) then begin
    inc( nNodes );
    nodes[nNodes] := @self;
    exit;
  end;
  left^.Markup( _op );
  right^.Markup( _op );
end;

function FindMinNode( lo, hi : integer ) : int;
var
  min       : int;
  i,j       : integer;

begin
  min := inf;
  for i := lo to hi do
    if nodes[i]^.optTime < min then begin
      min := nodes[i]^.optTime;
      j := i;
    end;
  FindMinNode := j;
end;

procedure Swap( var a, b : PNode );
var
  c       : PNode;

begin
  c := a;
  a := b;
  b := c;
end;

function TNode.Optimize : PNode;
var
  node        : PNode;
  lo,hi       : integer;
  i,j,k       : integer;
  tOp       : int;

begin

  if (op <> '+') and (op <> '*') then begin
    new( node );
    node^.op := op;
    node^.optTime := 0;
    Optimize := node;
    exit;
  end;

  if op = '+' then tOp := tPlus else tOp := tMult;

  lo := nNodes + 1;
  Markup( op );
  hi := nNodes;

  for i := lo to hi do nodes[i] := nodes[i]^.Optimize;

  for i := 1 to hi - lo do begin
    j := FindMinNode( lo, hi );
    Swap( nodes[j], nodes[hi] );
    k := FindMinNode( lo, hi - 1 );
    Swap( nodes[k], nodes[hi-1] );
    new( node );
    node^.op := op;
    node^.left := nodes[hi-1];
    node^.right := nodes[hi];
    node^.optTime := tOp + max( node^.left^.optTime, node^.right^.optTime );
    nodes[hi-1] := node;
    dec( hi );
  end;

  Optimize := nodes[lo];

end;

function ParseExpr( l, r : integer ) : PNode;
var
  i,j       : integer;
  layer       : integer;
  node        : PNode;

begin

  new( node );
  ParseExpr := node;

  repeat
    if l = r then begin
      node^.op := expr[l];
      exit;
    end;
    layer := 0;
    for i := l to r do begin
      if expr[i] = '(' then inc( layer );
      if expr[i] = ')' then dec( layer );
      if layer = 0 then break;
    end;
    if i <> r then break;
    inc( l );
    dec( r );
  until false;

  node^.left := ParseExpr( l, i );
  node^.op := expr[i+1];
  node^.right := ParseExpr( i + 2, r );

end;

procedure Solve;
begin
  root := ParseExpr( 1, length( expr ) );
  time := root^.EvalTime;
  nNodes := 0;
  optRoot := root^.Optimize;
  optTime := optRoot^.optTime;
end;

procedure ReadData;
begin
  readln( tPlus, tMult );
  readln( expr );
end;

procedure WriteData;
begin
  writeln( time );
  optRoot^.Print( false );
  writeln;
  writeln( optTime );
end;

procedure Initialize;
begin

  assign( input, inFile );
  reset( input );

  assign( output, outFile );
  rewrite( output );

  {$ifdef DEBUG1}
  assign( dbg, dbgFile );
  rewrite( dbg );
  writeln( '----Initialized----' );
  {$endif}

end;

procedure Finalize;
begin

  {$ifdef DEBUG1}
  writeln( '----Finalized----' );
  close( dbg );
  {$endif}

  close( input );
  close( output );

  halt( 0 );

end;

begin
  Initialize;
  ReadData;
  Solve;
  WriteData;
  Finalize;
end.