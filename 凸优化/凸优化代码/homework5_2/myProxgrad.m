function x = myProxgrad(A,b,mu,x0,ep)

% f = @(x)(0.5*norm(A*x-b,2)^2+mu*norm(x,1));
Q = A'*A;
bb = A'*b;
g = @(x)(Q*x-bb);
MAX = 1000;
x = x0;
g0 = g(x);
t = 1/norm(Q);
% t = 1;
for k = 1:MAX
    u  = x - t*g0;
    t1 = t*mu;
    x1 = (u-t1).*(u>=t1)+(u+t1).*(u<=-t1);
    s = x1 - x;
    g1 = g(x1);
    y = g1-g0;
    x = x1;
    g0 = g1;
    if norm(g0) < 1e-6;
        return
    end
%     t = s'*y/(y'*y);
end
end