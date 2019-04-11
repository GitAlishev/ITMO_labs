import random
import heapq


def heapsort(array, sorted_list=[]):
	if array != []:
		array[0], array[-1] = array[-1], array[0]
		sorted_list.append(array[-1])
		array.pop()
		heapq.heapify(array)
		#print('Heap:  ', array)
		heapsort(array, sorted_list)
	else:
		print('Sorted:', sorted_list)


array = random.sample(range(1, 51), 20)
print('Array: ', array)

"""
# memory use
import os
import psutil
process = psutil.Process(os.getpid())
startRam = process.memory_info().rss / 1024

# time
from datetime import datetime
startTime = datetime.now()
"""

# max-heap
#heapq._heapify_max(array)
# min-heap
heapq.heapify(array)
print('Heap:  ', array)

# implement
heapsort(array)

"""
# memory use
process = psutil.Process(os.getpid())
print('memory use:', process.memory_info().rss / 1024 - startRam, 'Kb')

# time
print('time:', datetime.now() - startTime)
"""
