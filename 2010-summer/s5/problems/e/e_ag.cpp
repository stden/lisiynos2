#define _CRT_SECURE_NO_DEPRECATE
#pragma comment (linker,"/STACK:64000000")

#include <iostream>
#include <cstdio>
#include <cstring>
#include <sstream>
#include <algorithm>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <queue>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <cassert>

using namespace std;

#define sz(v) ((int)(v).size())
#define all(v) v.begin(), v.end()
#define pb push_back
#define mp make_pair

typedef long long ll;
typedef pair<int,int> ii;
typedef vector<int> vi;
typedef vector<string> vs;

template<class T>T abs(T x) { return (x>0) ? x : -x; }
template<class T>T sqr(T x) { return x*x;            }

typedef double D;
const D eps=1e-8;
const D pi=2*asin(1.);

struct P { // точка
    D x,y;
    P() {} 
    P(D x, D y): x(x), y(y) {} 
    P operator +(P a) {
        return P(x+a.x,y+a.y);
    }
    P operator -(P a) {
        return P(x-a.x,y-a.y);
    }
    P operator *(D k) { // умножение на скаляр
        return P(x*k,y*k);
    }
    D operator *(P a) { // векторное произведение
        return x*a.y-y*a.x;
    }
    D operator ^(P a) { // скалярное произведение
        return x*a.x+y*a.y;
    }
    D len() {
        return sqrt(x*x+y*y);
    }
    P perp() { // ортогональный вектор
        return P(y,-x);
    }
    P rotate(double an) {
        D c=cos(an);
        D s=sin(an);
        return P(x*c-y*s,x*s+y*c);
    }
    P norm() { // нормированный вектор
        D l=len();
        if (abs(l)<eps) 
            return P(x,y);
        else
            return P(x/l,y/l);
    }
    bool operator ==(P a) {
        return abs(x-a.x)<eps && abs(y-a.y)<eps;
    }
    void load() {
        cin>>x>>y;
    }
    void save() {
        printf("%.20lf %.20lf\n",x,y);
    }
};

struct L { // прямая, заданная уравнением ax+by+c=0
    D a,b,c;
    L() {}
    L(D a, D b, D c): a(a), b(b), c(c) {}
    L norm() {
        D div=sqrt(sqr(a)+sqr(b));
        assert(div>eps);
        return L(a/div,b/div,c/div);
    }
    D getValue(P p) {
        return a*p.x+b*p.y+c;
    }
};

L getLine(P p1, P p2) { // дано: две несовпадающих точки p1 и p2. возвращает прямую, их содержащую
    D x0=p1.x, y0=p1.y;
    D al=(p2-p1).x, be=(p2-p1).y;
    return L(be,-al,al*y0-be*x0);
}

P getPoint(L l1, L l2) { // дано: две прямые l1 и l2, которые пересекаются. возвращает точку пересечения
    D det=l1.a*l2.b-l1.b*l2.a;
    D det1=-(l1.c*l2.b-l1.b*l2.c);
    D det2=-(l1.a*l2.c-l1.c*l2.a);
    return P(det1/det,det2/det);
}

struct C { // окружность с центром в точке о и радиусом r
    P o;
    D r;
    C() {}
    C(P o, D r): o(o), r(r) {}
    bool contains(C c) {
        D d=(c.o-o).len();
        return d+c.r<r+eps;
    }
    void load() {
        o.load();
        cin>>r;
    }
};

vector<P> crossCircleAndLine(C c, L l) {
    vector<P> res; // результат
    D al,be; // направляющий вектор прямой l
    al=l.b;
    be=-l.a;
    D x0,y0; // точка на прямой l
    if (abs(l.a)<abs(l.b)) {
        x0=0;
        y0=-l.c/l.b;
    } else {
        y0=0;
        x0=-l.c/l.a;
    }
    // теперь x=x0+al*t, y=y0+be*t, подставляем в уравнение окружности и решаем квадратное уравнение a*t^2+b*t+c=0;
    D A,B,C,t;
    A=sqr(al)+sqr(be);
    B=2*al*(x0-c.o.x)+2*be*(y0-c.o.y);
    C=sqr(x0-c.o.x)+sqr(y0-c.o.y)-sqr(c.r);
    D d=B*B-4*A*C; // дискриминант
    if (d<-eps) return res; // решений нет
    if (d<0) d=0; // чтобы не было RE при d чуть меньшем нуля
    t=(-B+sqrt(d))/(2*A); // одно решение
    res.push_back(P(x0+al*t,y0+be*t));
    t=(-B-sqrt(d))/(2*A); // второе решение
    res.push_back(P(x0+al*t,y0+be*t));
    return res;
}

vector<P> crossTwoCircles(C c1, C c2) {
    // вычев из одного уравнения окружности другое, получим уравнение прямой ax+by+c=0
    D a,b,c;
    a=2*(c2.o.x-c1.o.x);    
    b=2*(c2.o.y-c1.o.y);
    c=sqr(c2.r)-sqr(c1.r)+sqr(c1.o.x)-sqr(c2.o.x)+sqr(c1.o.y)-sqr(c2.o.y);
    return crossCircleAndLine(c1,L(a,b,c));
}

int sgn(D x) { // знак числа х
    if (x>eps) return 1;
    if (x<-eps) return -1;
    return 0;
}

struct Circles2Solver {
    C c1,c2,c3;
    int buben;
    Circles2Solver(int buben): buben(buben) {}
    P getPoint(D x) {
        return c1.o+P(c1.r,0).rotate(x);
    }
    vector<P> getSide(D x) {
        P p=getPoint(x);
        vector<P> to;
        C circles[2];
        circles[0]=c2, circles[1]=c3;
        for (int t=0; t<2; t++) {
            C c=circles[t];
            D d=(p-c.o).len();
            D l=sqrt(max(0.,sqr(d)-sqr(c.r)));
            if (l<eps) continue;
            vector<P> add=crossTwoCircles(C(p,l),c);
            for (int i=0; i<sz(add); i++)
                to.pb(add[i]);
        }
        if (sz(to)==0) return vector<P>();
        int l=0,r=0;
        for (int i=0; i<sz(to); i++) {
            if ((to[i]-p)*(to[l]-p)<-eps) l=i;
            if ((to[i]-p)*(to[r]-p)>eps) r=i;
        }
        assert(l!=r);
        vector<P> tmp;
        tmp=crossCircleAndLine(c1,getLine(p,to[l]));
        assert(sz(tmp)==2);
        P p1=tmp[0]+tmp[1]-p;
        tmp=crossCircleAndLine(c1,getLine(p,to[r]));
        if (sz(tmp)!=2) {
            p.save();
            to[r].save();
        }
        assert(sz(tmp)==2);
        P p2=tmp[0]+tmp[1]-p;
        vector<P> res;
        res.pb(p1);
        res.pb(p2);
        return res;
    }
    D getValue(D x) {
        P p=getPoint(x);
        vector<P> tmp=getSide(x);
        if (sz(tmp)!=2) return -1e100;
        P p1=tmp[0];
        P p2=tmp[1];
        L line=getLine(p1,p2).norm();
        double res=1e100;
        C circles[2];
        circles[0]=c2, circles[1]=c3;
        for (int t=0; t<2; t++) {
            C c=circles[t];
            D cur;
            D d=abs(line.getValue(c.o));
            if (sgn(line.getValue(c.o))==sgn(line.getValue(p)))
                cur=d;
            else
                cur=-d;
            cur-=c.r;
            res=min(res,cur);
        }
        return res;     
    }
    void findMinValue(D l, D r, D &x, D &minVal) {
        for (int step=0; step<50; step++) {
            D len=r-l;
            D m1=l+len/3;
            D m2=r-len/3;
            D v1=getValue(m1);
            D v2=getValue(m2);
            if (v1<v2)
                l=m1;
            else
                r=m2;
            x=r;
            minVal=getValue(x);
        }
    }
    vector<P> getValidTriangle(C _c1, C _c2, C _c3) {
        c1=_c1, c2=_c2, c3=_c3;
        assert(c1.contains(c2) && c1.contains(c3));
        for (int i=0; i<buben-1; i++) {
            D l=2*pi/buben*i;
            D r=2*pi/buben*(i+1);
            D x,minVal;
            findMinValue(l,r,x,minVal);
            if (minVal>-eps) {
                cerr<<minVal<<endl;
                vector<P> res=getSide(x);
                res.pb(getPoint(x));
                if (!checkTriangle(res))
                    cout<<"botva\n";
                return res;
            }
        }
        return vector<P>();
    }
    bool checkTriangle(vector<P> p) {
        double eps=1e-5;
        assert(sz(p)==3);
        for (int i=0; i<3; i++) { 
            cerr<<(c1.o-p[i]).len()<<endl;
            if ((c1.o-p[i]).len()>c1.r+eps) 
                return false;
        }
        double area=0;
        for (int i=0; i<3; i++)
            area+=p[i]*p[(i+1)%3];
        area=abs(area);
        C circles[2];
        circles[0]=c2, circles[1]=c3;
        for (int t=0; t<2; t++) {
            C c=circles[t];
            double area2=0;
            for (int i=0; i<3; i++)
                area2+=abs((p[i]-c.o)*(p[(i+1)%3]-c.o));
            if (abs(area-area2)>eps) return false;
        }
        for (int t=0; t<2; t++) {
            C c=circles[t];
            for (int i=0; i<3; i++) {
                L line=getLine(p[i],p[(i+1)%3]).norm();
                if (abs(line.getValue(c.o))<c.r-eps) return false;              
            }
        }
        return true;
    }
};

int main()
{
    freopen("e.in","r",stdin);
    freopen("e.out","w",stdout);

    C c1,c2,c3;
    c1.load();
    c2.load();
    c3.load();
    Circles2Solver solver(113);
    vector<P> triangle=solver.getValidTriangle(c1,c2,c3);
    if (sz(triangle)==0)
        cout<<"impossible\n";
    else {
        cout<<"possible\n";
        for (int i=0; i<3; i++)
            triangle[i].save();
    }

    return 0;
}
