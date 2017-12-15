function [F g G] = extend_rosen(x)
%EXTEND_ROSEN Extender Rosenbrock function with output F g G
% 
% (-1.2, 1, ..., -1.2, 1) for test
% min = 0 at (1, ..., 1)

% Version:	2009.05.22
% Create:	2009.05.22
% Coder:	Xin Liang
% Bug Submission:	liangxinslm@163.com

[r J] = extend_rosenJ(x);
F = r'*r;
g = 2*J'*r;
if nargout > 2
    n = length(x);
    n = n - mod(n, 2);
    G = J'*J;
    for i = 1:2:n-1
        G(i,i) = G(i,i) - 20 *r(i);
    end
    G = G*2;
end