clear all
close all
clc
n=input('Введите размер матрицы: ');
h=1/n;
eps=h^3;
gamma=3;
mu=1;
condition =input('(1) - Тестовая матрица, (2) - Вариант 15: ');
if condition == 2
    [A,b]=matrix_install(n,h,gamma,mu);
    x_tochnoe = A\b;
else
    A=gallery('minij',n);
    for i=1:length(A)
        A(i,i)=A(i,i)*10;
    end
    x_tochnoe=round(rand(n,1)*100);
    b=A*x_tochnoe;
end

omega=1:0.1:1.9;
[err_res, x_res,omega_counter] = Zeidel_Relax(A,b,eps,n,omega);
[M,I]=min(omega_counter(:,2));
best_omega=omega_counter(I,1)
omega_counter(I,2);

%График y_k
Ox=linspace(1,n,n);
plot(Ox,x_tochnoe)
grid on
hold on
plot(Ox, x_res(I,:),'*--')
plot(Ox, x_res(1,:),'x:')
%legend('Точное решение', 'Метод релаксации')
%title('График значений(Точное, метод релаксации')
legend('Точное решение','Метод релаксации', 'Метод Зейделя')
title('График значений(Точное, м. Зейделя и релаксации')

%График погрешности м. Зейделя и Релаксации
figure
[err_res_zeidel]= Zeidel_Relax(A,b,eps,n,1);
Ox=linspace(1,length(err_res_zeidel),length(err_res_zeidel));
semilogy(Ox,err_res_zeidel)
[err_res_relax]= Zeidel_Relax(A,b,eps,n,best_omega);
Ox=linspace(1,length(err_res_relax),length(err_res_relax));
hold on
semilogy(Ox,err_res_relax,'r--')
legend('Метод Зейделя','Релаксация(оптимальная омега)')
grid on
title('График погрешности м. Зейделя и Релаксации')

%График итераций в зависимости от омега
figure
Ox=linspace(1,length(omega_counter),length(omega_counter));
plot(omega_counter(:,1),omega_counter(:,2))
grid on
title('График зависимости количества итерации от омеги')

%Таблица количества итераций при заданной Омеге
T_omega=array2table([omega_counter]);
T_omega.Properties.VariableNames(1:2)={'Omega','iter'};
T_omega

err_z = abs(A*x_res(1,:)'-b);
err_r = abs(A*x_res(I,:)'-b);
%Общая таблица
T_all = table(x_res(1,:)',x_res(I,:)', x_tochnoe, err_z, err_r, 'VariableNames',{'Zeidel','Relax','Tochnoe','Zeidel_err','Relax_err'})
%T_all = table(x_res(I,:)', x_tochnoe, err_r, 'VariableNames',{'Relax','Tochnoe','Relax_err'})