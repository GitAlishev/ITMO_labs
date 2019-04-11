import turtle
from turtle import penup, pendown, write, goto, circle


""" CREATE AND OUTPUT THE TREE """

def binary_tree(node):
	""" Create binary tree with node as root """
	return [node, [], []]


def insert_left(tree, node):
	""" Create left subtree for current node or tree """
	tree[1] = [node, [], []]
	return tree


def insert_right(tree, node):
	""" Create right subtree for current node or tree """
	tree[2] = [node, [], []]
	return tree


def get_root_node(tree):
	""" Get the root node """
	return tree[0]


def get_left_child(tree):
	""" Get the left child of the tree """
	return tree[1]


def get_right_child(tree):
	""" Get the right child of the tree """
	return tree[2]


""" TREE TRAVERSAL """

def preorder(tree, tabs=0):
	""" прямой (preorder): root, left, right """
	if tree:
		print('\t'*tabs, get_root_node(tree))
		preorder(get_left_child(tree), tabs + 1)
		preorder(get_right_child(tree), tabs + 1)


def inorder(tree, tabs=0):
	""" симметричный (inorder): left, root, right """
	if tree:
		inorder(get_left_child(tree), tabs + 1)
		print('\t'*tabs, get_root_node(tree))
		inorder(get_right_child(tree), tabs + 1)


def postorder(tree, tabs=0):
	""" обратный (postorder): left, right, root """
	if tree:
		postorder(get_left_child(tree), tabs + 1)
		postorder(get_right_child(tree), tabs + 1)
		print('\t'*tabs, get_root_node(tree))


# Example from the task

tree = binary_tree('E')
insert_left(tree, 'B')
insert_right(tree, 'F')
insert_left(get_left_child(tree), 'A')
insert_right(get_left_child(tree), 'D')
insert_left(get_right_child(get_left_child(tree)), 'C')
insert_right(get_right_child(tree), 'I')
insert_left(get_right_child(get_right_child(tree)), 'G')
insert_right(get_right_child(get_right_child(tree)), 'J')
insert_right(get_left_child(get_right_child(get_right_child(tree))), 'H')
print(tree)
print('----------------------------------------')
preorder(tree)
print('----------------------------------------')
inorder(tree)
print('----------------------------------------')
postorder(tree)


# Result:

# ['E', ['B', ['A', [], []], ['D', ['C', [], []], []]], ['F', [], ['I', ['G', [], ['H', [], []]], ['J', [], []]]]]

"""
----------------------------------------
 E
         B
                 A
                 D
                         C
         F
                 I
                         G
                                 H
                         J
----------------------------------------
                 A
         B
                         C
                 D
 E
         F
                         G
                                 H
                 I
                         J
----------------------------------------
                 A
                         C
                 D
         B
                                 H
                         G
                         J
                 I
         F
 E
"""

""" DRAW THE TREE """

#tree = ['a', ['b', [], []], ['c', [], ['d', ['e', [], []], []]]]

turtle.hideturtle()
turtle.speed(0)
#turtle.delay(0)  # allows instant draw


def jumpto(x, y):
	penup()
	goto(x, y)
	pendown()


def draw(tree, x, y, dx):
	""" Draw the tree """
	if tree:
		goto(x, y)
		jumpto(x, y-30)
		circle(15)
		jumpto(x-5, y-30)
		write(get_root_node(tree), font=('Times New Roman', 18, 'normal'))
		draw(get_left_child(tree), x-dx, y-60, dx/2)
		jumpto(x, y-30)
		draw(get_right_child(tree), x+dx, y-60, dx/2)


# memory use
import os
import psutil
process = psutil.Process(os.getpid())
startRam = process.memory_info().rss / (1024 ** 3)

# time
from datetime import datetime
startTime = datetime.now()


jumpto(-40, 200)
draw(tree, -40, 200, 80)

turtle.done()  # leave the turtle window open


# memory use
import os
import psutil
process = psutil.Process(os.getpid())
print('memory use:', process.memory_info().rss / (1024 ** 3) - startRam, 'Gb')

# time
print('time:', datetime.now() - startTime)
