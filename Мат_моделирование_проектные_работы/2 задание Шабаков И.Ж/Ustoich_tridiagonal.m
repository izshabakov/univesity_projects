a=pi/2;
b=pi;
qa=0;
qb=1;
N=10
delta=[-10^-1, -5*10^-2, 0, 5*10^-2, 10^-1];
%y0=y0
[Xr,Yr]=tridiagonal_matrix_algorithm(a,b,N,qa,qb);
%yN
Ytoch=Yr(length(Yr)-1)
hold on
for i=1:5
    %y0=y0+delta
    %СМЕНА МЕТОДА
   [X,Y]=tridiagonal_matrix_algorithm(a,b,N,qa+delta(i),qb);
   %yN'
   Yshtrih=Y(length(Y)-1)
   %|yN'-yN|
   razn(i)=abs(Yshtrih-Ytoch);
   plot(X,Y)
end
grid on
xlabel('x')
ylabel('y')
legend('-0.1','-0.05','0','0.05','0.1')
title('Исследование qa')
figure
Ytoch=Yr(2)
hold on
for i=1:5
    %y0=y0+delta
    %СМЕНА МЕТОДА
   [X,Y]=tridiagonal_matrix_algorithm(a,b,N,qa,qb+delta(i));
   plot(X,Y)
   %yN'
   Yshtrih=Y(2)
   %|yN'-yN|
   razn(i)=abs(Yshtrih-Ytoch);
end
grid on
xlabel('x')
ylabel('y')
legend('-0.1','-0.05','0','0.05','0.1')
title('Исследование qb')