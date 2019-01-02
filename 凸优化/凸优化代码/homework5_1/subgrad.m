function [x] = subgrad(A,b,mu,x0)
%
%
%

epsilon = 1e-6;
MAX = 100;
k = 1;
x=x0;
g = A'*A*x-A'*b+mu*sign(x);
while norm(g,inf) >= epsilon && k <= MAX
    g = A'*A*x-A'*b+mu*sign(x);
    t = 0.01/k;
    x = x-t*g;
    k = k+1;
end
   