function [r J] = extend_rosenJ(x)
%EXTEND_ROSENJ Extender Rosenbrock function with output r J
% 
% (-1.2, 1, ..., -1.2, 1) for test
% min = 0 at (1, ..., 1)

% Version:	2009.05.22
% Create:	2009.05.22
% Coder:	Xin Liang
% Bug Submission:	liangxinslm@163.com

n = length(x);
n = n - mod(n, 2);

for i = 1:2:n-1
%    [r(i:i+1,1) J(i:i+1,i:i+1)] = rosenJ(x(i:i+1));
     [r(i:i+1,1) J(i:i+1,i:i+1)] = Rosenbrock(x(i:i+1));
end