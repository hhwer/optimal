function x = Proxgrad(A,b,mu,x0,ep)

% f = @(x)(0.5*norm(A*x-b,2)^2+mu*norm(x,1));
Q = A'*A;
bb = A'*b;
g = @(x)((Q*x-bb)/mu);
MAX = 1000;
x1 = x0;
x = x1+1;
g0 = g(x1);
k = 1;
t = 1/norm(Q)*mu;
% t = 1;
while norm(x1-x)>ep && k < MAX
    x = x1;
    u = x - t*g0;
    x1 = (u-t).*(u>=t)+(u+t).*(u<=-t);
%     s = x1 - x;
    g1 = g(x1);
%     y = g1-g0;
    g0 = g1;
    k = k+1;
%     t = s'*y/(y'*y);
end
end