clear all
close all
% b=[1 1.3];
x=0;
X =10; 
N_x = 100; 
h_x = (X-x)/N_x;
x_setka=x:h_x:X;

t=0;
T=60;

U= @(x) sqrt(x/X)*abs(cos(2*x-1));
u_t= @(t) (t/50)^(1/6)*sin(t/6)*sin(t/6);
a_f=@(x,t)sin(t/4.5-x/2);
L_f=@ (a,h_t,h_x) a*h_t/h_x;


% for l=1:2
for i=1:N_x+1
    y_0(i)=U(x_setka(i));
end
time=0;
    
 while(time < T)
 for i=1:N_x+1
     a(i)=a_f(x_setka(i),time);
 end
 max_a=max(abs(a));
 if max_a~=0
    h_t=h_x/max_a;
 else
    h_t=b*h_x;
 end
     
if x_setka(1)==0 && a(1)<0
    y_j(1)=y_0(1)*(1+L_f(a(1),h_t,h_x))-L_f(a(1),h_t,h_x)*y_0(2);
else
    y_j(1)=u_t(time);
end

 
for i=2:N_x+1
     if a(i)>=0
         y_j(i)=y_0(i)*(1-L_f(a(i),h_t,h_x))+L_f(a(i),h_t,h_x)*y_0(i-1);
     end
     if a(i)<0
         if a(i)==a(N_x+1) && a(N_x+1)<0
             y_j(N_x+1)=y_0(N_x+1);
             continue
         end
          y_j(i)=y_0(i)*(1+L_f(a(i),h_t,h_x))-L_f(a(i),h_t,h_x)*y_0(i+1);
     end
 end
y_0=y_j;
plot(x_setka,y_j);

xlabel('x')
ylabel('U(x,t)')

grid on
axis([0 10 0 1]);
pause(0.1);
time=time+h_t;
 end
%  plot(x_setka,y_j);
%  hold on
% % plot(x_setka,a);
% xlabel('x')
% ylabel('U(x,t)')
% legend('b=1','b=0.1')
% % ylabel('a(x,t)')
% grid on
% axis([0 10 0 1]);
% pause(0.1);
% end