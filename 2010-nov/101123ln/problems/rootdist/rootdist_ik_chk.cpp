#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

using namespace std;

#define TASKNAME "rootdist"

const int MinN = 1, MaxN = 100;

int p [MaxN];
int r [MaxN];

int main (void)
{
 int c, i, k, m, n;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d", &n) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  for (i = 1; i < n; i++)
  {
   scanf (" %d", &p[i]);
   p[i]--;
  }
  m = c = 0;
  for (i = 0; i < n; i++)
  {
   r[i] = 0;
   for (k = i; k != 0; k = p[k])
    r[i]++;
   if (m < r[i])
   {
    m = r[i];
    c = 0;
   }
   if (m == r[i])
    c++;
  }
  printf ("%d\n", m);
  printf ("%d\n", c);
  for (i = 0; i < n; i++)
   if (r[i] == m)
   {
    c--;
    printf ("%d%c", i + 1, c ? ' ' : '\n');
   }
 }
 return 0;
}
