function x1 = NesterovForSmoothed(A,b,mu,x0,method,lambda,ep)
Q = A'*A;
bb = A'*b;
% huber
if method == 1 
    g = @(x)((Q*x-bb)+mu*(x/lambda.*(abs(x)<=lambda)+(x>lambda)-(x<-lambda)));
% log-sum-exp
elseif method == 2
    g = @(x)((Q*x-bb)+mu*((exp(x/lambda)-exp(-x/lambda))./((exp(x/lambda)+exp(-x/lambda)))));
% sqrt
else
    g = @(x)((Q*x-bb)+mu*(x./sqrt(x.^2+lambda^2)));
end
T = 1000;
eta = 1/(norm(Q)+2*mu);
x1 = x0;
y = x1;
for k = 1:T
    y = x1 + (k-2)/(k+1)*(x1-x0);
    x0 = x1;
    x1 = y - eta*g(y);
    if norm(x1-x0)< ep
        break;
    end
end
end