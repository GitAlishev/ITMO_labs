function[] = plotXYZ()
[X,Y] = meshgrid(-1:0.1:1);
Z = 100.*(Y - X.^2)^2+(1 - X).^2;
mesh(X,Y,Z);
surf(X,Y,Z);
grid on;
colormap(hot);
end