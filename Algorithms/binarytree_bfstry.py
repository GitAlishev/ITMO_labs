def get_root_element(tree, i):
	return tree[i][0]

bf = []

for i in range(len(tree)):
	bf.append(get_root_element(tree, i))
for j in range(1,len(get_left_child(tree))):
	bf.append(get_root_element(get_left_child(tree), j))
for j in range(1,len(get_right_child(tree))):
	try:
		bf.append(get_root_element(get_right_child(tree), j))
	except:
		bf.append('')

print(bf)
