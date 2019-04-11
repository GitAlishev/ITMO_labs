function[] = plotXY()
x = -1:pi/200:1;
y = x+sin(10*pi*x)+1;
whitebg([1 1 1]);
axes('XColor', 'white', 'Ycolor', 'white');
hold on
plot(x,y,'r:o');
text(0.5,0,'plotXY');
end