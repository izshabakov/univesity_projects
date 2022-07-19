close all
clear all
clc
% Строим матрицу
n=input('Введите размер матрицы: ');
h=1/n;
eps=h^3;
gamma=3;
mu=1;
err=0;
test_or_Var15=input('Выберите матрицу: Тестовая(1) либо Вариант 15(2): ');
if test_or_Var15==2
    [A,b] = matrix_install(n,h,gamma,mu);
    x_tochnoe = A\b;
else
    A = gallery('lotkin',n);
    for i=1:n
        A(i,i)=A(i,i)*100;
    end
    %Проверка матрицы. Она должна быть несимметричной
    if isequal(A,A.')
        error('Матрица симметрична')
    end
    x_tochnoe=round(rand(n,1)*10);
    b=A*x_tochnoe;
end

%Решение
x_exp=zeros(n,1);
counter=1;
while true
    r_i=A*x_exp-b;
    A_r=A*r_i;
    t=dot(A_r,r_i)/dot(A_r,A_r);
    x_exp=x_exp-t*r_i;
    err(counter)=norm(A*x_exp-b);
    if err(counter)<=eps
        break
    else
        counter=counter+1;
    end
end

str=['Количество итераций: ' int2str(counter)];
disp(str)

%График убывания погрешности в зависимости от числа итераций
x_lin=linspace(1,counter,counter);
semilogy(x_lin, err)
grid on
title('График убывания погрешности в зависимости от числа итераций')

%График точного решения и метода мин. невязок
figure
x_lin=linspace(1,n,n);
plot(x_lin,x_tochnoe)
hold on
grid on
plot(x_lin,x_exp,'*--')
legend('Точное решение','Метод минимальных невязок')

%Таблица точного решения, метода мин. невязок и ошибки
error=abs(A*x_exp - b);
T=table(x_tochnoe, x_exp,error,'VariableNames',{'X_tochnoe', 'X_k', 'err'})