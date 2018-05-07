function [x, cvx_status] = l1_cvx_gurobi(x0, A, b, opts2);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[~,n] = size(A);
cvx_begin
cvx_solver gurobi
    variable x(n)
    minimize (norm(x,1))
    subject to
        A*x == b
cvx_end
end

