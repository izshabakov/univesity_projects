a=pi/2;
b=pi;
qa=0;
qb=1;
N=10;
% [Xrl,Yrl]=Real_tridiagonal(a,b,N,qa,qb)
[Xrl,Yrl]=Real_tridiagonal(a,b,N,qa,qb)
[X,Y]=tridiagonal_matrix_algorithm(a,b,N,qa,qb)

hold on
plot(X,Y,'r')
plot(Xrl,Yrl,'b.')
xlabel('x')
ylabel('y')
grid on
legend('Приближенное решение','Точное решение')
% [(Yrl'),(Y')]
[max]=Error(Y,Yrl)
% [Xrl,Yrl]=Real_tridiagonal(a,b,N,qa,qb)
% plot(Xrl,Yrl)
% ylabel('y','Color', 'k', 'FontWeight', 'bold')
% xlabel('x','Color', 'k', 'FontWeight', 'bold')
% legend('Точное решение')
% [X,Y]=tridiagonal_matrix_algorithm(a,b,N,qa,qb)