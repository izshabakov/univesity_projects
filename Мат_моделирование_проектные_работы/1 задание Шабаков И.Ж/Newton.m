function [X,Y,Smax] = Newton(a,b,y0,eps,h) 
y(1)=y0;
x(1)=a;
N=(b-a)/h;
maxit=1;
for i=1:N
   x(i+1)=x(1)+i*h;
   xY1=y(i);
   xY2=xY1-(xY1-y(i)-(h/2)*(f(x(i),y(i))+f(x(i+1),xY1)))/(1-(h/2));
   it=1;
    while xY2-xY1>eps
       xY1=xY2;
       xY2=xY1-(xY1-y(i)-(h/2)*(f(x(i),y(i))+f(x(i+1),xY1)))/(1-(h/2));
       it=it+1; 
        if maxit<it
            maxit=it;
        end
    end
    y(i+1)=xY2;
end
X=x;
Y=y;
Smax=maxit
end