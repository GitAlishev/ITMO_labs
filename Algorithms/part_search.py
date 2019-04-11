from copy import copy

""" 1. TASK | STRING-SEARCH ALGORITHM: PART COINCIDENCE """

# for lists of values in strings
# s - type string, where to search
# w - type string, template to search for
def part_search(s, w):
	cnt = 0      # number of appearances
	values = []  # result

	for i in range(len(s) - len(w) + 1):    # + 1 to not omit the end
		word = copy(w)                      # for changes
		for j in range(len(w)):
			if w[j] == '.':
				word[j] = s[i:len(w)+i][j]  # change to compare
		if word == s[i:len(w)+i]:           # compare
			cnt += 1
			values.append("".join(s[i:len(w)+i]))
	
	return cnt, values


# string-search algorithm: full coincidence
# incremental search
def inc_search(s, w):
	cnt = 0
	for i in range(len(s) - len(w) + 1):
		if w == s[i:len(w)+i]:
			cnt += 1
	return cnt

"""
# TRANSITORIO / TEMPORARY
# Works if dots are in the beginning or the end of the word
# For both strings and lists of values in strings

def not_universal(s, w):

	cnt = 0      # count appearances
	dot_cnt = 0  # number of dots in w
	values = []  # search result

	# remove dots in the beginning or the end
	if w[0] == '.':
		for j in range(len(w)):
			if w[j] == '.':
				word = w[j+1:]
				dot_cnt += 1
				start = True

	if w[len(w)-1] == '.':
		for j in range(len(w)):
			if w[j] == '.':
				word = w[:j]
				dot_cnt = len(w) - len(word)
				start = False
				break

	# search
	for i in range(len(s) - len(word)):
		if word == s[i:len(word)+i]:
			cnt += 1
			if start == True:
				values.append(s[i-dot_cnt:len(word)+i])
			else:
				values.append(s[i:len(word)+i+dot_cnt])
		else:
			pass

	return cnt, values
"""


""" 2. EXAMPLES """

# 1
s, w = 'tookqwerbooktyuioaslookdfghjkzhookxcvbnmcook', '.o.k'

number, result = part_search(list(s), list(w))
print('\n--- 1st example ---')
print('Search for', w, 'in', s)
print('Number of appearances:', number)
print('Search result:', result)


# 2
s1, w1 = 'areaqwertyartsfgtartejdfnceuarcsfhrytuart', 'ar..'

number, result = part_search(list(s1), list(w1))
print('\n--- 2nd example ---')
print('Search for', w1, 'in', s1)
print('Number of appearances:', number)
print('Search result:', result)


# 3
s2, w2 = 'dfrtbananadejdejcasabadjfjdefpajama', '.a.a.a'

number, result = part_search(list(s2), list(w2))
print('\n--- 3rd example ---')
print('Search for', w2, 'in', s2)
print('Number of appearances:', number)
print('Search result:', result)


# 4
s4, w4 = 'bookqwerbooktyuioaslookdfghjkzhookxcvbnmbook', 'book'

print('\n--- 4th example ---')
print('Search for', w4, 'in', s4)
print('Number of appearances:', inc_search(s4, w4))
