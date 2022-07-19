clear all
close all
clc
n = 10;
A = gallery('ris',n);
A_orig = A
for i = 1:n
    A(1:i, 1:i)
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
    p_row = 1:n;
    
    [row_max, row_idx] = max(A(n, 1:n));
    buf = p_row(n);
    p_row(n) = p_row(row_idx);
    p_row(row_idx) = buf;
    buf = b(n);
    b(n) = b(row_idx);
    b(row_idx) = b(n);
    
    d = row_max;
    w = A(n,p_row(1:n-1))';
    H = A(p_row(1:n-1),1:n-1);
    theta = zeros(n-1,1);
    L(n,1:n-1) = w/d;

    C = zeros(n-1,n-1);
    for i = 1:n-1
        for j = 1:n-1
            C(i,j) = w(i)*v(j)/d;
        end
    end
    A = H - C;
    n = length(A);
    if n == 1
        D(1,1) = A;
    end
end
max(max(abs(A_orig - U*D*L)))

y = U\b;, z = D\y;, x_test= L\z;
err = x-x_test;
table(x,x_test, err, 'VariableNames', {'x', 'x_UDL', 'error'})