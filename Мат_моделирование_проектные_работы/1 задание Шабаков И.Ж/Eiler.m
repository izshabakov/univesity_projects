function [X,Y]=Eiler(a,b,y0,h)
y(1)=y0;
x(1)=a;
N=(b-a)/h;
for i=1:N
   x(i+1)=x(1)+i*h;
   y(i+1)=y(i)+h*f(x(i),y(i));
end
X=x;
Y=y;