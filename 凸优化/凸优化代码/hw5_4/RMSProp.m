function [x] = RMSProp(x0,A,b,mu,ep,eta)
delta = 1e-2;
rho = 0.4;
k = 0;
K = 5000;
Q = A'*A;
lam = 1e-5;
bb = A'*b;
% eta = 0.01;
gs = @(x,lambda)(x/lambda.*(abs(x)<=lambda)+(x>lambda)-(x<-lambda));
r = zeros(length(x0),1);
x=x0;
g = Q*x-bb+mu*gs(x,lam);
while norm(g,inf) >= ep && k <= K
    k = k+1;
    g = Q*x-bb+mu*gs(x,lam);
    r = rho*r+(1-rho)*g.*g;
    t = eta./sqrt(delta+r).*g;
    x = x-t;   
end
end