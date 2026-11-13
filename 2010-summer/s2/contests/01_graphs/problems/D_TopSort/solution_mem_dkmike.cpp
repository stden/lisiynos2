#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <assert.h>
#include <memory.h>

#define MAXN (100010)

typedef struct tag_node_t {
	int num;
	tag_node_t* next;
} node_t;

typedef node_t* list_t;

list_t adj[MAXN] = {0};
int res[MAXN] = {0};
int color[MAXN] = {0};
int count = 0;
int N = 0;
int M = 0;

node_t * iters[MAXN] = {0};
int vs[MAXN] = {0};

void init() {
	for (int i = 1; i <= M; i++) {
		adj[i] = (list_t)malloc(sizeof(node_t));
		assert(NULL != adj[i]);
		adj[i]->num = 0;
		adj[i]->next = NULL;
	}
}

void add(int a, int b) {
	node_t* cur = (node_t*)malloc(sizeof(node_t));
	assert(NULL != cur);
	cur->num = b;
	cur->next = adj[a]->next;
	adj[a]->next = cur;
}

void dfs(int k) {
	color[vs[k]] = 1;
	for (iters[k] = adj[vs[k]]->next; NULL != iters[k]; iters[k] = iters[k]->next)
		if (!color[iters[k]->num]) {
			vs[k + 1] = iters[k]->num;
			dfs(k + 1);
		}
		else
			if (1 == color[iters[k]->num]) {
				puts("-1");
				exit(0);
			}
	color[vs[k]] = 2;
	res[count++] = vs[k];
}

int main() {
	freopen("topsort.in", "rt", stdin);
	freopen("topsort.out", "wt", stdout);

	scanf("%d %d", &M, &N);
	init();
	for (int i = 0; i < N; i++) {
		int a = 0;
		int b = 0;
		scanf("%d %d", &a, &b);
		add(a, b);
	}

	for (int i = 1; i <= M; i++)
		if (!color[i]) {
		    vs[0] = i;
			dfs(0);
		}

	for (int i = count - 1; i >= 0; i--)
		printf("%d ", res[i]);

	//fcloseall();
	return 0;
}
