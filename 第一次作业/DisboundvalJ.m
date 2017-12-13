function [y] = DisboundvalJ(x)
%DIS_BOUNDVALJ Discrete boundary value function with output sigma(r^2)
% 
% i/(n+1)*(i/(n+1) - 1) for test
% min = 0

% Version:	2009.05.23
% Create:	2009.05.23
% Coder:	Xin Liang
% Bug Submission:	liangxinslm@163.com

n =length(x);
x = [0; x(:); 0];
h = 1/(n+1);
t = (1:n)*h;

r = 2*x(2:n+1) - x(1:n) - x(3:n+2) + (x(2:n+1) + t').^3 *h^2/2;
y = 0;
for i=1:n
    y = y + r(i)^2;
end
    