h=0.01;
eps=0.0001;
delta=[-10^-1, -5*10^-2, 0, 5*10^-2, 10^-1];
%y0=y0
%ялемю лерндю
[X,Yr]=Newton(0,1,1,10^-12,h)
%yN
Ytoch=Yr(length(Yr))
for i=1:5
    %y0=y0+delta
    %ялемю лерндю
   [X,Y]=Newton(0,1,1+delta(i),10^-12,h)
   %yN'
   Yshtrih=Y(length(Y))
   %|yN'-yN|
   razn(i)=abs(Yshtrih-Ytoch);
end
plot(delta,razn)
grid on
ylabel('\chi','Color', 'k', 'FontWeight', 'bold')
xlabel('\delta','Color', 'k', 'FontWeight', 'bold')
razn