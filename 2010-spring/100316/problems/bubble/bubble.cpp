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

int a[MaxN + 3];
int n;

int main (void)
{
  int i;
  freopen ("bubble.in", "rt", stdin);
  freopen ("bubble.out", "wt", stdout);
  while (scanf ("%d", &n) != EOF)
  {
    assert ((MinN <= n) && (n <= MaxN));
    for (i = 0; i < n; i++)
    {
      scanf ("%d", &a[i]);
      assert ((MinX <= a[i]) && (a[i] <= MaxX));
    }
    sort (a, a + n);
    for (i = 0; i < n - 1; i++)
      printf ("%d ", a[i]);
    printf ("%d\n", a[n - 1]);
  }
  return 0;
}
