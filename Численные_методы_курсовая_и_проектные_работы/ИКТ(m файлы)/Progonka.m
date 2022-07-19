clc
close all
clear all
n=input('Введите размер матрицы: ');
h=1/n;
eps=h^3;
gamma=3;
mu=1;
[A,f,A_1,A_2,A_3,first_A,last_A] = matrix_install(n,h,gamma,mu);
A_progonka=[first_A(1:3);A_1 A_2 A_3;last_A(n-2:n)];
a=[0 A_1' last_A(n-1)];
b=[first_A(1) A_2' last_A(n)];
c=[first_A(2) A_3' 0];
P(2)=-c(1)/b(1);
Q(2)=f(1)/b(1);

%Подготовленная матрица к использованию метода прогонки
A_installed =[a' b' c'];
for i=2:n-1
    P(i+1)=-c(i)/(b(i)+a(i)*P(i));
    Q(i+1)=(f(i)-a(i)*Q(i))/(b(i)+a(i)*P(i));
end
x_n=(f(n)-a(n)*Q(n))/(b(n)+a(n)*P(n));
x(n)=x_n;
for i=n-1:-1:1
    x(i)=P(i+1)*x(i+1)+Q(i+1);
end

x_tochnoe = A\f;
err = abs(A*x'- f);

%График y_k
Ox=linspace(1,n,n);
plot(Ox,x_tochnoe)
grid on
hold on
plot(Ox, x,'*--')
legend('Точное решение', 'Метод прогонки')

%Таблица 
T=table(x_tochnoe, round(x',4),err,'VariableNames',{'X_tochnoe', 'X_i', 'Error'})
% writetable(T,'ex3.xlsx')