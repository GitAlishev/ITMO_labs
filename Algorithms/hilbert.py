# memory use
import os
import psutil
process = psutil.Process(os.getpid())
startRam = process.memory_info().rss / (1024 ** 3)

# time
from datetime import datetime
startTime = datetime.now()


import turtle
from turtle import left, right, forward

# Каждая следующая кривая Гильберта порядка n состоит из 4 кривых порядка (n-1).

def hilbert(depth, angle):
	if depth > 0:
		width = 1
		turtle.width(width)
		turtle.hideturtle()
		turtle.speed(0)

		left(angle)
		hilbert(depth - 1, 360 - angle)
		forward(length)
		right(angle)
		hilbert(depth - 1, angle)
		forward(length)
		hilbert(depth - 1, angle)
		right(angle)
		forward(length)
		hilbert(depth - 1, 360 - angle)
		left(angle)


length = 10

current_depth = turtle.numinput(
	title='Hilbert Curve',
	prompt='Depth'
)
current_angle = turtle.numinput(
	title='Hilbert Curve',
	prompt='Angle',
	default=270
)

turtle.penup()
turtle.goto(-240, 200)
turtle.pendown()

hilbert(current_depth, current_angle)
turtle.done()


# current depth for info
print('Current depth is:', int(current_depth))

# memory use
import os
import psutil
process = psutil.Process(os.getpid())
print('memory use:', process.memory_info().rss / (1024 ** 3) - startRam, 'Gb')

# time
print('time:', datetime.now() - startTime)
