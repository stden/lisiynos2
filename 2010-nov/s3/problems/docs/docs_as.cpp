#define _CRT_SECURE_NO_DEPRECATE
#include <cstdio>
#include <cassert>
#include <algorithm>
using namespace std;

const int N = 131072 * 2;
const int INF = 2000000000;

int n, nn, m;
int inds[N], as[N], bs[N];
int ans[N];

int cmin[N];
int cpos[N];

int cmp(int a, int b){
 return (as[a] < as[b]); 
}

inline int min(int a, int b){ return (a<b)?a:b;}

void update(int pos, int val){
  pos += nn-1;
  cmin[pos] = val;
  pos >>= 1;
  while (pos > 1){
    if (cmin[pos<<1] <= cmin[(pos<<1) + 1]){
      cmin[pos] = cmin[pos<<1];
      cpos[pos] = cpos[pos<<1];
    }
    else{
      cmin[pos] = cmin[(pos<<1)+1];
      cpos[pos] = cpos[(pos<<1)+1];
    }
    pos >>= 1;
  }
}

int getMin(int cl, int cr, int l, int r, int pos, int& val){
  if ((cl == l) && (cr == r)){
    val = cmin[pos];
    return cpos[pos];
  }
  int m = (l+r)>>1;
  if (cr <= m) return getMin(cl, cr, l, m, pos<<1, val);
  if (cl > m) return getMin(cl, cr, m+1, r, (pos<<1)+1, val);
  int m1, v1, m2, v2;
  m1 = getMin(cl, m, l, m, pos<<1, v1);
  m2 = getMin(m+1, cr, m+1, r, (pos<<1)+1, v2);
  if (v1 <= v2){
    val = v1;
    return m1;
  }
  else{
    val = v2;
    return m2;
  }
}

void build_tree(){
  int i;
  for (i=nn; i<2*nn; i++){
    cpos[i] = i-nn+1;
    if (i-nn+1 <= n) cmin[i] = bs[inds[i-nn+1]];
    else cmin[i] = INF;
  }
  for (i=nn-1; i>=1; i--){
    if (cmin[i<<1] <= cmin[(i<<1)+1]){
      cmin[i] = cmin[i<<1];
      cpos[i] = cpos[i<<1];
    }
    else{
      cmin[i] = cmin[(i<<1)+1];
      cpos[i] = cpos[(i<<1)+1];
    }
  }
}

int bb[N];

int main(){
  freopen("docs.in", "r", stdin);
  freopen("docs.out", "w", stdout);
  scanf("%d", &n);
  int i, ok=1;
  for (i=1; i<=n; i++){
    scanf("%d%d", &as[i], &bs[i]);
    inds[i] = i;
  }
  // ASSERT BEGIN
  for (i=1; i<=n; i++){
    bb[i] = bs[i];
  }
  sort(bb+1, bb+n+1);
  for (i=2; i<=n; i++){
    assert(bb[i] != bb[i-1]);
  }
  // ASSERT END
  inds[n+1] = n+1;
  for (nn=1; nn<n; nn<<=1);
  as[0] = -INF; as[n+1] = INF;
  sort(inds, inds+n+2, cmp);
  build_tree();
  int m, c, d, cl, cr, l, r, q;
  scanf("%d", &m);
  for (i=1; i<=m; i++){
    scanf("%d%d", &c, &d);
    l=0; r=n+1;
    while (l < r){
      q = (l+r) >> 1;
      if (as[inds[q]] < c) l = q+1;
      else r = q;
    }
    cl = l;
    l=0; r=n+1;
    while (l < r){
      q = (l+r+1) >> 1;
      if (as[inds[q]] > d) r = q-1;
      else l=q;
    }
    cr = l;
    if (cl > cr){
      ok = 0;
      break;
    }
    int val;
    int res = getMin(cl, cr, 1, nn, 1, val);
    if (val == INF){
      ok = 0;
      break;
    }
    ans[i] = inds[res];
    update(res, INF);
  }
  if (!ok) printf("BOTVA\n");
  else{
    for (i=1; i<=m; i++) printf("%d ", ans[i]);
  }
  return 0;
}