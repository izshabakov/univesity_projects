function[X,Y]=tridiagonal_matrix_algorithm(a,b,N,qa,qb)
format longg
h=(b-a)/N;
x=a:h:b;
f= @(x) exp(-x)*sin(x);
K= @(x) exp(-x);
C=zeros(1,N+1);
C(1)=1;
C(N+1)=1;
B=zeros(1,N+1);
% B(1)=K(x(1)+h/2);
A=zeros(1,N+1);
% A(N+1)=K(x(N+1)-h/2);
F=zeros(1,N+1);
F(1)=qa;
F(N+1)=qb;
alpha=zeros(1,N+1);
alpha(2)=B(1)/C(1);
beta=zeros(1,N+1);
beta(2)=F(1)/C(1);
for m=2:N
    A(m)=K(x(m)-h/2);
    B(m)=K(x(m)+h/2);
    C(m)=A(m)+B(m);
    F(m)=h^2*f(x(m));
    alpha(m+1)=B(m)/(C(m)-A(m)*alpha(m));
    beta(m+1)=(A(m)*beta(m)+F(m))/(C(m)-A(m)*alpha(m));
end
y=zeros(1,N+1);
y(1)=qa;
y(N+1)=qb;
for m= N:-1:2
    y(m)=y(m+1)*alpha(m+1)+beta(m+1);
end
[(A'),(B'),(C'),(F'),(alpha'),(beta'),(y')] 

X=x;
Y=y;
end