function [F g G] = wood(x)
%WOOD Wood function with output F g G
% 
% (-3, -1, -3, -1) for test
% min = 0 at (1, 1, 1, 1)

% Version:	2009.05.22
% Create:	2009.05.22
% Coder:	Xin Liang
% Bug Submission:	liangxinslm@163.com

[r J] = woodJ(x);
F = r'*r;
g = 2*J'*r;
if nargout > 2
    G = J'*J;
    G(3,3) = G(3,3) - 2*sqrt(90) * r(3);
    G(1,1) = G(1,1) - 20 * r(1);
    G = G*2;
end