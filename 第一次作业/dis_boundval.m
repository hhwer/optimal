function [F g G] = dis_boundval(x)
%DIS_BOUNDVAL Discrete boundary value function with output F g G
% 
% i/(n+1)*(i/(n+1) - 1) for test
% min = 0

% Version:	2009.05.23
% Create:	2009.05.23
% Coder:	Xin Liang
% Bug Submission:	liangxinslm@163.com

[r J] = dis_boundvalJ(x);
F = r'*r;
g = 2*J'*r;
if nargout > 2
    n =length(x);
    x = x(:);
    h = 1/(n+1);
    t = (1:n)*h;
    G = 2*(J'*J + diag(3*h^2*(x+t'+1).*r));
end