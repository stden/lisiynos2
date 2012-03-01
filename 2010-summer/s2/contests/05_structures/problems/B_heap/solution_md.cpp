/*
Description: priority queue
Author: Mike S. D'yakov
*/

#include <stdio.h>
#include <assert.h>

#define MAXN 100100

int heap[MAXN] = {0};
int size = 0;

void swap(int i, int j)
{
	int cur = heap[i];
	heap[i] = heap[j];
	heap[j] = cur;
}

void heap_add(int cur)
{
	int ind = size;

	heap[size] = cur;
	size++;

	while (ind > 0 && heap[ind] > heap[(ind - 1)/2])
	{
		swap(ind, (ind - 1)/2);
		ind = (ind - 1)/2;
	}
}

void heapify(int k)
{
	int largest = k;

	if (k*2 + 1 < size && heap[largest] < heap[k*2 + 1])
	{
		largest = k*2 + 1;
	}

	if (k*2 + 2 < size && heap[largest] < heap[k*2 + 2])
	{
		largest = k*2 + 2;
	}

	if (k != largest)
	{
		swap(k, largest);
		heapify(largest);
	}
}

int heap_extract_max()
{
	int res = heap[0];

	size--;

	assert(0 <= size);

	heap[0] = heap[size];
	heapify(0);

	return res;
}

int main()
{
	int N = 0;
	int i = 0;
	int cmd = 0;
	int cur = 0;

	freopen("heap.in", "rt", stdin);
	freopen("heap.out", "wt", stdout);

	scanf("%d", &N);

	for (i = 0; i < N; i++)
	{
		scanf("%d", &cmd);

		switch (cmd)
		{
			case 0:
				scanf("%d", &cur);
				heap_add(cur);
				break;
			case 1:
				assert(size > 0);
				printf("%d\n", heap_extract_max());
				break;
		}
	}

	//fcloseall();
	return 0;
}
