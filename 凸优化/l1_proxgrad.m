function x = l1_proxgrad(A,b,mu,x0,ep)

Q = A'*A;
bb = A'*b;
g = @(x)((Q*x-bb)/mu);
MAX = 1000;
x1 = x0;
x = x1+1;
k = 1;
t = 1/norm(Q)*mu;
while norm(x1-x)>ep && k < MAX
    x = x1;
    gk = g(x);
    u = x - t*gk;
    x1 = (u-t).*(u>=t)+(u+t).*(u<=-t);
    k = k+1;
end