function [x] = Adam(x0,A,b,mu,ep)
delta = 1;
K = 5000;
Q = A'*A;
lam = 1e-5;
bb = A'*b;
k = 1;
rho1 = 0.9;
rho2 = 0.999;
eta = 0.01;
gs = @(x,lambda)(x/lambda.*(abs(x)<=lambda)+(x>lambda)-(x<-lambda));
r = zeros(length(x0),1);
s = r;
x=x0;
g = Q*x-bb+mu*gs(x,lam);
while norm(g,inf) >= ep && k <= K
    g = Q*x-bb+mu*gs(x,lam);
    s = rho1*s+(1-rho1)*g;
    r = rho2*r+(1-rho2)*g.*g;
    shat = s/(1-rho1^k);
    rhat = r/(1-rho2^k);
    t = eta*shat./(delta+sqrt(rhat));
    x = x-t;
    k = k+1;
end
end