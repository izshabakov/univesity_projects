format longg
a=pi-1;
b=pi;
qa=0;
qb=1;
N=[10,100,1000,10000,100000,1000000];
for i=1:6
h(i)=(b-a)/N(i);    

[X,Y]=tridiagonal_matrix_algorithm(a,b,N(i),qa,qb);
%рнвмне пеьемхе
[Xrl,Yrl]=Real_tridiagonal(a,b,N(i),qa,qb);
smax(i)=Error(Y,Yrl);
K(i)=smax(i)/(h(i)^2)
end
K
smax
loglog(h,smax)
ylabel('\psi','Color', 'k', 'FontWeight', 'bold')
xlabel('h','Color', 'k', 'FontWeight', 'bold')
grid on