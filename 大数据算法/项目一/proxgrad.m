function x1 = proxgrad(Q,bb,t,mu,x0,ep)
g = @(x)((Q*x-bb)/mu);
MAX = 1000;
x1 = x0;
x = x1+1;
k = 1;
while norm(x1-x)>ep && k < MAX
    x = x1;
    gk = g(x);
    u = x - t*gk;
    x1 = (u-t).*(u>=t)+(u+t).*(u<=-t);
    k = k+1;
end

end