#!/usr/bin/python
#Author: Ivan Kazmenko
import inspect, math, random, sys
TASKNAME = 'rootdist'
random.seed (hash (TASKNAME))
TESTSTR = '%02d'
TOFILES = False
test = 1
shuffle_flag = False

MinN, MaxN = 1, 100

# output a test, checking it for correctness
def out (a):
	global shuffle_flag, test
	sys.stderr.write (('Test ' + TESTSTR + ' [generator line %d]\n') % \
	    (test, inspect.stack () [-2][2]))
	n = len (a) + 1
	assert MinN <= n <= MaxN
	for b in a:
		assert 0 <= b < n
	for b in a:
		d = b
		for k in range (n - 1):
			if d == 0:
				break
			d = a[d - 1]
		assert d == 0
	c = a

	if shuffle_flag:
		p = range (1, n)
		random.shuffle (p)
		p = [0] + p
		q = [0] * n
		for i in range (n):
			q[p[i]] = i
		c = [0] + c
#		print c
		c = [q[c[p[x]]] for x in range (n)]
#		print p
#		print q
#		print c
		c = c[1:]
	if TOFILES:
		f = open (TESTSTR % test, 'wt')
	else:
		f = sys.stdout
		try:
			if f.tell () != 0:
				f.write ('\n')
		except:
			f.write ('\n')
	f.write ('%d\n' % n)
	s = ''
	for b in c:
		f.write ('%d\n' % (b + 1))
	if TOFILES:
		f.close ()
	test += 1

def genrandom (n = MaxN):
	a = []
	for i in range (1, n):
		a.append (random.randrange (i))
	return a

def main ():
	global shuffle_flag, test
	if len (sys.argv) > 1:
		test = int (sys.argv[1])

	# samples
	shuffle_flag = False
	out ([0, 0])
	out ([0, 1])

	# small tests
	shuffle_flag = False
	out ([])
	out ([0])
	out ([2, 0])
	out ([0, 1, 2, 3, 1, 5, 6, 2, 8, 3])

	# random tests
	shuffle_flag = False
	out (genrandom (10))
	out (genrandom (31))
	out (genrandom (54))
	out (genrandom (MaxN - 1))
	out (genrandom (MaxN))
	shuffle_flag = True
	out (genrandom (10))
	out (genrandom (31))
	out (genrandom (54))
	out (genrandom (MaxN - 1))
	out (genrandom (MaxN))

	# large tests
	shuffle_flag = False
	out ([0] * (MaxN - 1))
	out ([x for x in range (MaxN - 1)])
	a = range (MaxN - 1)
	s = 0
	t = 14
	k = 0
	while s < MaxN - 1:
		a[s] = k
		s += t
		t -= 1
		k += 1
	out (a)
	shuffle_flag = True
	out (a)
	out ([x for x in range (MaxN - 1)])

if __name__ == "__main__":
	main ()
