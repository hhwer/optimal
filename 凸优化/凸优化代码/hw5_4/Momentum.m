function [x] = Momentum(x0,A,b,mu,ep,eta,alpha)
k = 0;
K = 5000;
Q = A'*A;
lam = 1e-5;
bb = A'*b;
% eta = 0.01;
% alpha = 1;
v = zeros(length(x0),1);
gs = @(x,lambda)(x/lambda.*(abs(x)<=lambda)+(x>lambda)-(x<-lambda));
x=x0;
g = Q*x-bb+mu*gs(x,lam);
while norm(g,inf) >= ep && k <= K
    k = k+1;
    g = Q*x-bb+mu*gs(x,lam);
    v = alpha*v-eta*g;
    x = x+v;   
end
end