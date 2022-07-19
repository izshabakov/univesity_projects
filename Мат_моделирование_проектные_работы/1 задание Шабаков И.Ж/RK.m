function [ X,Y] = RK(a,b,y0,h)
N=(b-a)/h;
y(1)=y0;
x(1)=a;
 for i=1:N
    x(i+1)=x(1)+i*h;
    K1=f(x(i),y(i));
    K2=f(x(i)+h/2,y(i)+(h/2)*K1);
    K3=f(x(i)+h/2,y(i)+(h/2)*K2);
    K4=f(x(i)+h,y(i)+h*K3);
    y(i+1) = y(i) + (h/6)*(K1+2*K2+2*K3+K4);
 end
X=x;
Y=y;
end
 

 