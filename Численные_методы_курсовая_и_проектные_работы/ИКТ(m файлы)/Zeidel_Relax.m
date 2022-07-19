function [err_res, x_res,omega_counter] = Zeidel_Relax(A,b,eps,n,omega)
% Массив содержащий Омегу и количество итераций
omega_counter=zeros(length(omega),2);
% Массив результатов вычислений x_i
x_res=zeros(length(omega),n);
% Массив ошибок
err_res=0;
for omega_i=1:length(omega)
    x_exp=zeros(1,n);
    counter=1;
    while true
    for i=1:length(x_exp)
        sl1=0;
        sl2=0;  
    for j=1:i-1
        sl1=A(i,j)/A(i,i)*x_buf(j)+sl1;
    end
    for j=i+1:n
        sl2=A(i,j)/A(i,i) * x_exp(j)+sl2;
    end
    x_buf(i)=(1-omega(omega_i))*x_exp(i)+omega(omega_i)*(-sl1 -sl2 + (b(i)/A(i,i)));
    end
    % Записываем ошибку после вычислений k-итерации
    err_res(counter)=norm(A*x_buf.'-b);
    if err_res(counter)<=eps
        % Записываем омегу и количество итераций
        omega_counter(omega_i,:)=[omega(omega_i) counter];
        x_res(omega_i,:)=x_buf;
        break
    else
        x_exp=x_buf;
        counter=counter+1;
    end
    end
end
end