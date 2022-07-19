format longg
h=[0.1,0.01,0.001,0.0001,0.00001,0.000001];
for i=1:6
%ялемю лерндю
[X,Y]=RK(0,1,1,h(i));
%рнвмне пеьемхе
[Xrl,Yrl]=Real(0,1,1,h(i));
ssmax(i)=Error(Y,Yrl)
K(i)=ssmax(i)/(h(i)^4)
end
loglog(h,ssmax)

ylabel('\psi','Color', 'k', 'FontWeight', 'bold')
xlabel('h','Color', 'k', 'FontWeight', 'bold')
grid on
Kavg=mean(K)

% L=[3.7548171E-03,3.7485286E-05 ,3.7484658E-07,3.7484652E-09,3.7484603E-11,3.7494205E-13];
% for i=1:6
% l(i)=L(i)/(h(i)^2);
% end
% l

% юаянкчрмюъ яундхлнярэ лоо х мэчрнмю
eps=[1, 10^-1,10^-2,10^-3,10^-4,10^-5,10^-6];
for i=1:7
%ялемю лерндю
[X,Y,Smax]=Newton(0,1,1,eps(i),0.01);
%рнвмне пеьемхе
[Xrl,Yrl]=Real(0,1,1,0.01);
it(i)=Smax
smax(i)=Error(Y,Yrl)
end
semilogx(eps,it)
ylabel('L','Color', 'k', 'FontWeight', 'bold')
xlabel('\epsilon','Color', 'k', 'FontWeight', 'bold')





