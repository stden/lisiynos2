import random
random.seed (12440)

test = 4

MinN = 1
MaxN = 100
MinM = 0
MaxM = 10000

def gen (n, m, l, h):
	s = ''
	s += '%d %d\n' % (n, m)
	for i in range (m):
	        j = random.randrange (n)
	        k = random.randrange (n)
	        r = random.randrange (l, h + 1)
		s += '%d %d %d\n' % (j + 1, k + 1, r)
        j = random.randrange (n)
        k = random.randrange (n)
	s += '%d %d\n' % (j + 1, k + 1)
	return s

def genpath (n, l, h):
	s = ''
	m = n - 1
	s += '%d %d\n' % (n, m)
	for i in range (m):
	        j = i
	        k = i + 1
	        r = random.randrange (l, h + 1)
		s += '%d %d %d\n' % (j + 1, k + 1, r)
        j = 0
        k = n - 1
	s += '%d %d\n' % (j + 1, k + 1)
	return s

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (5, 7, 1, 6)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = genpath (9, 10, 100)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (16, 14, 1, 100)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (25, 9, 100, 600)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (38, 0, 1, 1)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (46, 180, 3, 4)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (64, 4096, 1, 65536)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (89, 1984, 99999, 800000)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = gen (98, 9817, 1, 1000000)
f.write (s)
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
s = genpath (100, 999997, 1000000)
f.write (s)
f.close ()
test += 1
