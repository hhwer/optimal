function[x, cvx_status] = l1_cvx_mosek(x0, A, b, mu, opts1);
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,n] = size(A);
cvx_begin
cvx_solver mosek
    variable x(n)
% expression x(n);
% x = x0;
minimize(1/2*sum_square(A*x-b)+mu*norm(x,1))
% minimize(1/2*(A*x-b)'*(A*x-b)+mu*norm(x,1))
cvx_end
end




