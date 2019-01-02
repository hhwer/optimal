function [x, out] = ADMM(x0,A,b,mu)
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));
[m,~]=size(A);
lambda = b;
T = 10000;
t = 25;
x = x0;
epsilon = 1e-6;
Q = (eye(m)+t*(A*A'))^(-1);
for i =1:T
    s  =A'*lambda+x/t;
    s(s>mu)=mu;
    s(s<-mu)=-mu;
    lambda = Q*(A*(t*s-x)+b);
    x1 = x + t*(A'*lambda-s);
    if norm(x1-x)<epsilon
        break;
    end
    x = x1;
end
out.Fun = Fun(x);
end