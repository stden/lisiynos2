#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main(void) {
	int N = 0;
	vector < int > heap(0);

	freopen("heap.in", "rt", stdin);
	freopen("heap.out", "wt", stdout);

	cin >> N;
	for (int i = 0; i < N; i++) {
		int cmd = 0;
		cin >> cmd;
		if (0 == cmd) {
			int val = 0;
			cin >> val;
			heap.push_back(val);
			push_heap(heap.begin(), heap.end());
		} else {
			cout << heap[0] << endl;
			pop_heap(heap.begin(), heap.end());
			heap.pop_back();
		}
	}

	return 0;
}
