function [X,Y]=PredictCorrect(a,b,y0,h)
y(1)=y0;
x(1)=a;
N=(b-a)/h;
for i=1:N
   x(i+1)=x(1)+i*h;
   yEil=y(i)+h*f(x(i),y(i));
   y(i+1)=y(i)+(h/2)*(f(x(i),y(i))+f(x(i+1),yEil));
end
X=x;
Y=y;

   