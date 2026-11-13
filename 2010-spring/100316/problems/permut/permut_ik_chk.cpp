#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "permut"

const int MinN = 1, MaxN = 1000000;

bool b [MaxN];
int a [MaxN];
int n;

int main (void)
{
 int i;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d", &n) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  memset (b, 0, sizeof (b));
  for (i = 0; i < n; i++)
  {
   scanf (" %d", &a[i]);
   a[i]--;
   assert (!b[a[i]]);
   b[a[i]] = true;
  }
  for (i = 0; i < n; i++) // *
   assert (b[i]); // *
  for (i = 0; i < n; i++)
   if (b[i]) // *
    printf ("%d%c", i + 1, i + 1 < n ? ' ' : '\n');
 }
 return 0;
}
