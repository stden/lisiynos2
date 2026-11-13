#define _CRT_SECURE_NO_DEPRECATE
#include <cstdio>

const int MAX = 800100;
int n;
int cmin[MAX], cpos[MAX];

void go(int l, int r, int ver){
  if (l == r){
    cpos[ver] = r;
    return;
  }
  int m = (l+r)/2;
  go(l, m, 2*ver);
  go(m+1, r, 2*ver+1);
  cpos[ver] = cpos[2*ver];
}

void update(int l, int r, int pos, int cval, int ver){
  if (l == r){
    cmin[ver] = cval;
    return;
  }
  int m = (l+r)/2;
  if (pos <= m){
    update(l, m, pos, cval, 2*ver);
  }
  else{
    update(m+1, r, pos, cval, 2*ver+1);
  }
  if (cmin[2*ver] <= cmin[2*ver+1]){
    cmin[ver] = cmin[2*ver];
    cpos[ver] = cpos[2*ver];
  }
  else{
    cmin[ver] = cmin[2*ver+1];
    cpos[ver] = cpos[2*ver+1];
  }
}

int findpos(int l, int r, int cl, int cr, int ver, int& pos){
  if ((l == cl) && (r == cr)){
    pos = cpos[ver];
    return cmin[ver];
  }
  int m = (l + r) / 2;
  if (cr <= m){
    return findpos(l, m, cl, cr, 2*ver, pos);
  }
  if (cl > m){
    return findpos(m+1, r, cl, cr, 2*ver+1, pos);
  }
  int p1, p2;
  int a = findpos(l, m, cl, m, 2*ver, p1);
  int b = findpos(m+1, r, m+1, cr, 2*ver+1, p2);
  if (a <= b) pos = p1;
  else pos = p2;
  return (a<b)?a:b;
}

int main(){
  freopen("floor4.in", "r", stdin);
  freopen("floor4.out", "w", stdout);
  scanf("%d", &n);
  int i, a;
  go(1, 200000, 1);
  for (i=1; i<=n; i++){
    scanf("%d", &a);
    if (a < 0) update(1, 200000, -a, 0, 1);
    else{
      int p;
      findpos(1, 200000, a, 200000, 1, p);
      update(1, 200000, p, 1, 1);
      printf("%d\n", p);
    }
  }
  return 0;
}