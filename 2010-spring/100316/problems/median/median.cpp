#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <string.h>
#include <vector>
#include <algorithm>

#define MaxN 5000
#define MaxX 1000000000l
#define MinN 1
#define MinX 1

using namespace std;

long a[MaxN + 3];
int n;

int main (void)
{
  int i;
  freopen ("median.in", "rt", stdin);
  freopen ("median.out", "wt", stdout);
  while (scanf ("%d", &n) != EOF)
  {
    assert ((MinN <= n) && (n <= MaxN));
    for (i = 0; i < n; i++)
    {
      scanf ("%ld", &a[i]);
      assert ((MinX <= a[i]) && (a[i] <= MaxX));
    }
    sort (a, a + n);
    printf ("%lg\n", (a[(n - 1) / 2] + a[n / 2]) * 0.5);
  }
  return 0;
}
