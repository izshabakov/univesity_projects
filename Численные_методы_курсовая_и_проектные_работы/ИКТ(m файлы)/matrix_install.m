function [A,b,A_1,A_2,A_3,first_A,last_A] = matrix_install(n,h,gamma,mu)
%Задаем известные функции
u=@(x) (x+2).*(1-x);
p=@(x) 1+x.^gamma;
g=@(x) x+100;
f=@(x) -(-2 - 3*x.^2 - 8*x.^3)+ g(x).*u(x);
a_i=@(i) (p(i.*h-h)+p(i.*h))/2;

g_i=@(i) g(i*h);
p_i=@(i) p(i*h);
f_i=@(i) f(i*h);
%Строим матрицу, состоящую со 2 по 38 строку
A_1=[-a_i(1:n-2)].';
A_2=[a_i(1:n-2)+a_i(2:n-1)+h^2*g_i(1:n-2)].';
A_3=[-a_i(2:n-1)].';
A = spdiags([A_1 A_2 A_3],0:2,n-2,n);
full(A);
 %Строим первую и последнюю строку матрицы
 first_A=[a_i(1)+(0.5*h^2*g_i(0))-h*p_i(0) -a_i(1) zeros(1,n-2)];
 last_A=[zeros(1,n-2) -a_i(n-1)  a_i(n-1)+a_i(n)+h^2*g_i(n-1)];
 %Собираем матрицу полностью
 A=[first_A; A; last_A];
 full(A);
 %Строим вектор b
b=[0.5*h^2*f_i(0)-h*p_i(0)*mu f_i(1:n-1)*h^2].';

A=A;
b=b;
end