function [Xrl,Yrl]=Real_tridiagonal(a,b,N,qa,qb)
x(1)=a;
x(N+1)=b;
y(1)=qa;
y(N+1)=qb


h=(b-a)/N;
C1=2*(qb-qa-sin(b)/2+sin(a)/2+cos(b)/2-cos(a)/2)/(exp(b)-exp(a))
C2=qa-((C1*exp(a))/2)-sin(a)/2+cos(a)/2


for i=1:N-1
    x(i+1)=x(1)+i*h;
    y(i+1)=C1*exp(x(i+1))/2+C2+sin(x(i+1))/2-cos(x(i+1))/2;
end
Xrl=x;
Yrl=y;
end