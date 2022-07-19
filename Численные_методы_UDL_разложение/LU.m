clear all
close all
clc
n = 5;
A = gallery('ris',n);
A_origin = A;
for i = 1:n
    A(1:i, 1:i)
    if det(A(1:i, 1:i)) == 0
        error('”гловой минор равен нулю')
    end
end
x = [ 4 11 15 3 5]';
b = A*x;

L = eye(n);
U = zeros(n,n);
k = n;
o = 1;
h = 2;
while length(A)~=1
d = A(1,1);
w = A(2:n,1)';
v = A(1,2:n)';
H = A(2:n,2:n);
theta = zeros(n-1,1);
buf = w/d
L(h:k,o) = buf;
U(o,o) = d;
U(o,h:k) = v;

C = zeros(n-1,n-1);
for i = 1:n-1
    for j = 1:n-1
        C(i,j) = w(i)*v(j)/d;
    end
end
A = H - C;
n = length(A);
o = o + 1;
h = h + 1;
if n == 1
    U(k,k) = A;
end
end

A_origin - L*U