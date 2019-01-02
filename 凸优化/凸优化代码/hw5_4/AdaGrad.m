function [x] = AdaGrad(x0,A,b,mu,ep,eta)
delta = 3e-2;
K = 5000;
Q = A'*A;
lam = 1e-5;
bb = A'*b;
k = 0;
% eta = 0.01;
gs = @(x,lambda)(x/lambda.*(abs(x)<=lambda)+(x>lambda)-(x<-lambda));
r = zeros(length(x0),1);
x=x0;
g = Q*x-bb+mu*gs(x,lam);
while norm(g,inf) >= ep && k <= K
    k = k+1;
    g = Q*x-bb+mu*gs(x,lam);
    r = r+g.*g;
    t = eta./(delta+sqrt(r)).*g;
    x = x-t;    
end
end