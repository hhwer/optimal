function [u, out] = ALM(x0,A,b,mu)
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));
[m,~]=size(A);
lambda = b;
T = 10000;
t = 200;
u = x0;
epsilon = 1e-6;
Q = (eye(m)+t*(A*A'))^(-1);
TT = 10;
for i =1:T
    for j = 1:TT
%         s  =A'*lambda+u/beta;
        s  =A'*lambda+u/t;
        s(s>mu)=mu;
        s(s<-mu)=-mu;
        lambda = Q*(A*(t*s-u)+b);
    end
    u1 = u + t*(A'*lambda-s);
    if norm(u1-u)<epsilon
        break;
    end
    u = u1;
end
out.Fun = Fun(u);
end