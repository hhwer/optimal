function[x, cvx_status] = l1_cvx_mosek(x0, A, b, opts1);
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[~,n] = size(A);
cvx_begin
cvx_solver mosek
    variable x(n)
    minimize (norm(x,1))
    subject to
        A*x == b
cvx_end
end




