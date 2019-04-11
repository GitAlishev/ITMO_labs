""" 1. LINKED LIST: CREATE AND CHECK IF SORTED """

class Cell:
	def __init__(self, value):
		self.value = value
		self.next = None

	def Next(self):
		return self.next

	def setNext(self, next):
		self.next = next


class LinkedList:
	def __init__(self):
		self.head = None

	def add(self, new_value):
		new = Cell(new_value)
		new.setNext(self.head)
		self.head = new

	def is_sorted(self):
		current = self.head

		# if the list contains 1 element, it is sorted
		if current.Next() == None:
			return True

		# compare other elements
		while current.Next() != None:
			# compare current element with the next one
			if current.value > current.Next().value:
				return False
			# go to the next element
			current = current.Next()

		# if we are here, then the list is sorted
		return True

	def __str__(self):
		current = self.head
		out = 'Linked List [ ' + str(current.value) + ' '
		while current.Next() != None:
			current = current.Next()
			out += str(current.value) + ' '
		return out + ']'


""" 2. EXAMPLES """

if __name__ == '__main__':
	
	# 1
	print('\n--- 1st example ---')
	
	L = LinkedList()
	L.add(110)
	L.add(78)
	L.add(64)
	L.add(57)
	L.add(43)
	L.add(21)
	L.add(1)
	
	print(L)
	if L.is_sorted():
		print('Sorted')
	else:
		print('Not sorted')

	# 2
	print('\n--- 2nd example ---')

	R = LinkedList()
	R.add(1)
	R.add(2)
	R.add(117)

	print(R)
	if R.is_sorted():
		print('Sorted')
	else:
		print('Not sorted')


"""
	def length(self):
		current = self.head
		count = 0
		while current != None:
			count += 1
			current = current.Next()
		return count
"""
"""
	def remove(self, value):
		current = self.head
		previous = None
		found = False
		while not found:
			if current.getvalue() == value:
				found = True
			else:
				previous = current
				current = current.Next()
		if previous == None:
			self.head = current.Next()
		else:
			previous.setNext(current.Next())
"""
