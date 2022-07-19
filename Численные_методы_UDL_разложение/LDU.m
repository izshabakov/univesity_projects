clear all
close all
clc
n = 5;
A = gallery('ris',n);
A_orig = A
for i = 1:n
    A(1:i, 1:i)
    if det(A(1:i, 1:i)) == 0
        error('”гловой минор равен нулю')
    end
end
x = [ 4 11 15 3 5]';
b = A*x;

L = eye(n);
U = eye(n);

k = n;
i = 1;
j = 2;
while length(A)~=1
    d = A(1,1);
    w = A(2:n,1)';
    v = A(1,2:n)';
    H = A(2:n,2:n);
    theta = zeros(n-1,1);
    L(j:k,i) = w/d;
    U(i,j:k) = v/d;
    D(i,i) = A(1,1)

    C = zeros(n-1,n-1);
    for o = 1:n-1
        for h = 1:n-1
            C(o,h) = w(o)*v(h)/d;
        end
    end
    A = H - C;
    n = length(A);
    i = i + 1;
    j = j + 1;
    if n == 1
        D(k,k) = A;
    end
end

max(max(abs((abs(A_orig) - abs(L*D*U)))))