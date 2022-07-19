clear all
close all
clc
n = 10;
k = n;
in = input('¬ведите матрицу: 1 - тестова€, 2- √ильберта: ');
if in == 1
    A = gallery('ris',n);
else
    A = hilb(n);
end
A_orig = A;
for i = 1:n
    if det(A(1:i, 1:i)) == 0
        error('”гловой минор равен нулю')
    end
end
x = [ 4 11 15 3 5 2 3 6 1 24]';
b = A*x;

L = eye(n);
D = eye(n);
U = eye(n);
while length(A)~=1
    d = A(n,n);
    w = A(n,1:n-1)';
    v = A(1:n-1,n)';
    H = A(1:n-1,1:n-1);
    theta = zeros(n-1,1);
    L(n,1:n-1) = w/d;
    U(1:n-1,n) = v/d;
    D(n,n) = A(n,n);

    C = zeros(n-1,n-1);
    C(1:n-1,1:n-1) = w(1:n-1)*v(1:n-1)/d;
    A = H - C;
    n = length(A);
    if n == 1
        D(n,n) = A;
    end
end

y_ruch = zeros(1,k)
for i = k:-1:1
    sum = 0
    for j = i+1:k
        sum = sum + y_ruch(j)*U(i,j)
    end
    y_ruch(i) = b(i) - sum
end

z_ruch = zeros(1,k)
for i = 1:k
    z_ruch(i) = y_ruch(i)/D(i,i)
end

x_ruch = zeros(1,k)
for i = 1:k
    sum = 0
    for j = 1:i-1
        sum = sum + x_ruch(j)*L(i,j)
    end
    x_ruch(i) = z_ruch(i) - sum
end

% y = U\b;, z = D\y;, x_test= L\z;
% y' - y_ruch;
% z' - z_ruch;
% x_test' - x_ruch;

err = x-x_ruch'
table(x,x_ruch', err, 'VariableNames', {'x', 'x_UDL', 'error'})

A = A_orig;
UDL_A = U*D*L;
matrix_error = A_orig - U*D*L
max_udl_error = norm(x-x_ruch', inf)
