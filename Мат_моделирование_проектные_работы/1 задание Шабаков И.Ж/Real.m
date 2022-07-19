function [Xrl,Yrl]=Real(a,b,y0,h)
N=(b-a)/h;
y(1)=y0;
x(1)=a;
Cnst=(sin(a)/2+cos(a)/2+y0)/exp(a);
for i=1:N
    x(i+1)=x(1)+i*h;
    y(i+1)=Cnst*exp(x(i+1))-sin(x(i+1))/2-cos(x(i+1))/2;
end
Xrl=x;
Yrl=y;
end