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
    p_column = 1:n;
    
    [row_max, row_idx] = max(A(n, 1:n));
    buf = p_row(n);
    p_row(n) = p_row(row_idx);
    p_row(row_idx) = buf;
    d = row_max;
    A= A(1:n,p_row(1:n))
    w = A(n,1:n-1)';
    L(n,1:n-1) = w/d;
    
    [column_max, column_idx] = max(A(1:n,n));
    buf = p_column(n)
    p_column(n) = p_column(column_idx)
    p_column(column_idx) = buf
    buf = b(n);
    b(n) = b(column_idx);
    b(column_idx) = b(n);
    A= A(p_column(1:n),1:n)
    d = column_max;
    v = A(1:n-1,n)';
    U(1:n-1,n) = v/d;
    
    D(n,n) = A(n,n)
    H = A(n-1,n-1);
    theta = zeros(n-1,1);

    C = zeros(n-1,n-1);
    C(1:n-1,1:n-1) = w(1:n-1)*v(1:n-1)/d;
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