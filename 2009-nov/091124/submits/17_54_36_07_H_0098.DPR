Program airgun;

Var
x,xy,vx,vy,xt,rt,t,d,y,xp:Single;

Begin
reset(input,'airgun.in');
rewrite(output, 'airgun.out');
ReadLn(y, vy, vx, x, xt,rt);

d := Sqrt(vy * vy + 2 * 9.8 * y);
t := (d - vy) / 9.8;

xp := x + vx * t;
If (xp < xt + rt) And (xp > xt - rt) Then
Write('YES')
Else
Write ('NO');
End.
