function [x, out] = ADMMline1(x0,A,b,mu,epsilon)
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));
[m,~]=size(A);
T = 1000;
beta = 1e-1;
x = x0;
z = zeros(m,1);
t = 1e-3;
% t =1/ beta / max(eig(A'*A));
y = beta*(A*x-b)/(1+beta);
bhat = A'*b;
Q = A'*A;
for i =1:T
    g = beta*(Q*x-bhat-A'*(y+z));
    x1 = prox(x-g*t,t*mu);
    y = beta*(A*x1-b-z)/(1+beta);
    z = z - (A*x1-y-b);
    if norm(x1-x)<epsilon
        x = x1;
        break;
    end
    x = x1;
end
out.fun = Fun(x);
function u = prox(x,t)
    u = (x>t).*(x-t)+(x<-t).*(x+t);
end
end