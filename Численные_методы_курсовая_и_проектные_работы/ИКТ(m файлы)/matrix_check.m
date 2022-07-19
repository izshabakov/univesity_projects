function matrix_check(A,ex)
n=length(A);
counter_equal=0;
%�������� �� �������������� � ������������� ��������������
if ex==2
    if ~isequal(A,A.') | eig(A)<=0
        error('������. ������� �� �������� ������������ ��� ������������ ������������.')
    end
end
%�������� �� ������������ ������������
for i=1:n
    row_sum_without_diag=sum(abs(A(i,:)),2)-abs(A(i,i));
    if abs(A(i,i)<row_sum_without_diag)
        error('������. ������� �� �������� ������������ �������������.')
    end
    if abs(A(i,i)==row_sum_without_diag)
        counter_equal=counter_equal+1
    end
end
if counter_equal==n
    error('������. ������� �� �������� ������������ �������������.')
end    