clear all; close all; clc
m=45; C=0.25; p=1.29; S=0.35; g=9.81; v0=60;

angles=[20:1:70]; rad_angles=deg2rad(angles);
N=length(angles)

Lmax=0;
Angle_max=0;
legend_arr=cell(N,1);

for i=1:N
    h_t=0.01;
    V0=[0; 0; v0; rad_angles(i)];
    fun=@(t,y) [y(3)*cos(y(4)); y(3)*sin(y(4));-C*p*S*y(3).^2./(2*m)-g*sin(y(4)); -g*cos(y(4))./y(3)];

    [y,t] = RK4(fun, V0, h_t);
    plot(y(:,1)',y(:,2)'); ylim([0 inf])
    hold on
    legend_arr{i}=append('Угол: ', num2str(angles(i)));
    
    L(i)=y(end,1);
    buf=y(end,1);
    if buf>Lmax
        Lmax=buf;
        Angle_max = rad2deg(rad_angles(i));
        Varr_max=y(:,3);
        angle_max_arr=rad2deg(y(:,4));
        t_best=t;
    end
end
    title('Траектория полета снаряда при разных углах alpha')
    xlabel('x(t)')
    ylabel('y(t)')
    legend(legend_arr)

['Максимальная дальность полета = ' num2str(Lmax)]
['Искомый угол = ' num2str(Angle_max)]

    figure
    subplot(2,2,1)
    plot(angles, L)
    title('Зависимость дальности полета от угла alpha')
    xlabel('alpha')
    ylabel('L(alpha)')

    subplot(2,2,2)
    plot(t_best,angle_max_arr)
    title('Угол полета с течением времени')
    xlabel('t')
    ylabel('alpha(t)')

    subplot(2,2,3:4)
    plot(t_best,Varr_max)
    title('Скорость полета с течением времени')
    xlabel('t')
    ylabel('V(t)')

%     y(end,1)
%     y(end,2)