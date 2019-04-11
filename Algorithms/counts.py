""" 1. COUNT LETTER FREQUENCY """

from math import fabs


def counts(st):
	new = ''
	for i in st:
		if i not in new and i not in ' ,.?':
			new += i

	freqs = {}

	for j in new:
		cnt = 0
		for k in st:
			if k == j:
				cnt += 1

		if round(cnt/len(st) * 100, 1) < 10:
			f = round(cnt/len(st) * 100, 2)
		else:
			f = round(cnt/len(st) * 100, 1)
		
		freqs.update( { j : [f, int(fabs(ord('E') - ord(j)))] } )

	return sorted(freqs.items(), reverse=True, key=lambda k: k[1])


""" 2. EXAMPLES. VISUAL PART """

s1 = 'ATTACK AT DAWN'
s2 = 'NOTHING BUT GIBBERISH'
s3 = 'Master the basics of data analysis by manipulating common data structures'
s3 += ' such as vectors, matrices and data frames.'


for i in [s1, s2, s3]:

	print(i)

	print('-----------------------------')
	print('| letter | freq % | E shift |')
	print('-----------------------------')

	res = counts(i)

	for k, v in res:
		if v[1] < 10:
			print('|  ', k, '   | ', v[0], ' |  ', v[1], '    |')
		else:
			print('|  ', k, '   | ', v[0], ' |  ', v[1], '   |')

	print('-----------------------------\n')
