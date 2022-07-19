clc
close all
clear all

odefun = @(t, y) [y(2); -2*y(1)^2*(1-4*t^2*y(1))];
y0 = [1;0];

% %reshenie funkciei ode45()
% [T, Y] = ode45(odefun, [0,5], y0);

%Решение методом Рунге-Кутта 4-го порядка
t = 0:0.01:5;
y = RK4_test(odefun, t, y0);

%Точное решение
 y_exact(1,:)=1./(1+t.^2);
 y_exact(2,:)=-2*t./((1+t.^2).^2);


hold on;
grid on
% plot(T, Y,'y'); 
plot(t, y, 'r--', 'linewidth', 2.5)
plot(t, y_exact,'b-', 'linewidth', 0.5); 
legend('Exact','', 'R-K','')


h=0.01:0.01:0.09;
for i=1:length(h)
    t=0:h(i):5;
    y = RK4_test(odefun, t, y0);
    y_exact1 =1./(1+t.^2);
    y_exact2 =-2*t./((1+t.^2).^2);
    y_exact = [y_exact1;y_exact2]
    err(i,:)=max(abs(y-y_exact'));
    err_divide(i,:)=max(abs(y-y_exact'))/(h(i)^4);
end
    figure
    subplot(1,2,1)
    plot(h,err(:,1))
    title('Зав-ть погрешности e от шага h для y1')
    subplot(1,2,2)
    plot(h,err(:,2))
    title('Зав-ть погрешности e от шага h для y2')

    figure
    subplot(1,2,1)
    loglog(h,err(:,1))
    title('Зав-ть погрешности e от шага h для y1')
    subplot(1,2,2)
    loglog(h,err(:,2))
    title('Зав-ть погрешности e от шага h для y2')

    figure
    subplot(1,2,1)
    plot(h,err_divide(:,1))
    title('График e/h^4 для y1')
    subplot(1,2,2)
    plot(h,err_divide(:,2))
    title('График e/h^4 для y2')

    figure
    subplot(1,2,1)
    loglog(h,err_divide(:,1))
    title('График e/h^4 для y1')
    subplot(1,2,2)
    loglog(h,err_divide(:,2))
    title('График e/h^4 для y2')
    for i=2:length(h)
        alpha(i-1) = log10(err(i, 1)./err(i-1,1))./log10(h(i)./h(i-1));
    end
mean(alpha)