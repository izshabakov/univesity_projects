function [X,Y,Smax]=Simple(a,b,y0,h,eps)
y(1)=y0;
x(1)=a;
N=(b-a)/h;
maxit=1;
for i=1:N
    x(i+1)=x(1)+i*h;
    yP1=y(i);
    yP2=y(i)+(h/2)*(f(x(i),y(i))+f(x(i+1),yP1));
    it=1;
    while yP2-yP1>eps
        yP1=yP2;
        yP2=y(i)+(h/2)*(f(x(i),y(i))+f(x(i+1),yP1));
        it=it+1;
        if maxit<it
            maxit=it;
        end
    end
    y(i+1)=yP2;
end
X=x;
Y=y;
Smax=maxit;

        