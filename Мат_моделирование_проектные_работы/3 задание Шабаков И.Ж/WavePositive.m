clear all
close all
a=1;
b=1;
x=0;
X =10; 
N_x = 100; 
h_x = (X-x)/N_x;
x_setka=x:h_x:X

t=0;
h_t = b*h_x/abs(a);
T=1;


L=a*h_t/h_x

U= @(x) sqrt(x/X)*abs(cos(2*x-1));
u_t= @(t) (t/50)^(1/6)*(sin(t/6))^2;

for i=1:N_x+1
    y_0(i)=U(x_setka(i));
end

time=0
while(time < T)
y_j(1)=u_t(time);
Real(1) = Solution(x_setka(1),time,U,u_t,a,X);
for i=2:N_x+1
    y_j(i)=y_0(i)*(1-L)+L*y_0(i-1);
    Real(i) = Solution(x_setka(i),time,U,u_t,a,X);
end
y_0=y_j;
plot(x_setka,y_j,x_setka,Real,'--');
xlabel('x')
ylabel('U(x,t)')
legend('прибл.','точное')
grid on
axis([0 10 0 1]);
pause(0.1);
time = time + h_t;
end
    

