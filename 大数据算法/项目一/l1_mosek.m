function [x, res] = l1_mosek(x0, A, b, opts3);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
clear prob;

[m,n] = size(A);


prob.c = ones(2*n,1);
prob.a = [eye(n),zeros(n);eye(n),2*eye(n);zeros(m,n),A];
prob.blc = [zeros(2*n,1);b];
prob.buc = [inf*ones(2*n,1);b];
[r,res] = mosekopt('minimize',prob);
try
    xx = res.sol.itr.xx;
    x = xx(n+1:2*n);
catch
    fprintf('MSKERROR: Could not get solution')
end

end

