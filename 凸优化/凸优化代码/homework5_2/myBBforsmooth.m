function x = myBBforsmooth(A,b,mu,x0,method,lambda,ep)
Q = A'*A;
bb = A'*b;
% huber
if method == 1 
    f = @(x)(0.5*norm(A*x-b,2)^2+mu*sum(x.^2/(2*lambda).*(abs(x)<=lambda)+(abs(x)-lambda/2).*(abs(x)>lambda)));
    g = @(x)((Q*x-bb)+mu*(x/lambda.*(abs(x)<=lambda)+(x>lambda)-(x<-lambda)));
% log-sum-exp
elseif method == 2
    f = @(x)(0.5*norm(A*x-b,2)^2+mu*sum(lambda*log((exp(x/lambda)+exp(-x/lambda))./2)));
    g = @(x)((Q*x-bb)+mu*((exp(x/lambda)-exp(-x/lambda))./((exp(x/lambda)+exp(-x/lambda)))));
% sqrt
else
    f = @(x)(0.5*norm(A*x-b,2)^2+mu*sum(sqrt(x.^2+lambda^2)-lambda));
    g = @(x)((Q*x-bb)+mu*(x./sqrt(x.^2+lambda^2)));
end
alpha = 1;
MAX = 500;
sigma = 0.01;
delta = 0.95;
alphaM = 5;
alpham = 1e-11;
k = 1;
x1 = x0;
x = x1+1;
fk = f(x);
gk = g(x1);
while norm(gk) > ep && k < MAX
    x = x1;
    gk = g(x);
    t = 0;
    while f(x-alpha*gk) >= fk - sigma*alpha*norm(gk)^2 && t<=1000
        alpha = delta*alpha;
        t = t+1;
    end
    x1 = x - alpha*gk;
    y = g(x1)-gk;
    alpha = max(min(-(alpha*(gk'*gk))/(gk'*y),alphaM),alpham);
    k = k+1;
end