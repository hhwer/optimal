function [x, res] = l1_mosek(c, A, b, mu, opts3);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
clear prob;

[m,n] = size(A);


prob.c = [c];
prob.a = [sparse(A);sparse(A)];
prob.blc = [zeros(2*n,1)];
prob.buc = [inf*ones(2*n,1)];
prob.sol.int.xx = [zeros(n,1);x0];
[r,res] = mosekopt('minimize',prob);
try
    xx = res.sol.itr.xx;
    x = xx(1:n);
    y = prob.cfix + 0.5*x'*A'*A*x - b'*A*x + mu*norm(x,1);
    fprintf('*** Optimal value: %8.3f\n',y);
catch
    fprintf('MSKERROR: Could not get solution')
end

end

