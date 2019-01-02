function [x, out] = ADMM_intercept(x0,A,b,mu,epsilon)
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));

[m,~]=size(A);
lambda = b;
T = 5000;
t = 25;
x = x0; 
one_m = ones(m,1);
Q = (eye(m)+t*(A*A'))^(-1);
I_Q_I = one_m'*Q*one_m;
Q_I = Q*one_m;
for i =1:T
    s  =A'*lambda+x/t;
    s(s>mu)=mu;
    s(s<-mu)=-mu;
%     psi = (one_m'*Q*(A*(t*s-x)+b)) / o_Q_o;
    temp = Q*(A*(t*s-x)+b);
    lambda = temp - one_m'*temp/I_Q_I * Q_I;
    x1 = x + t*(A'*lambda-s);
    if norm(x1-x)<epsilon
        break;
    end
    x = x1;
end
out.Fun = Fun(x);
F = @(lam,s,x)0.5*lam'*lam-lam'*b+x'*(A'*lam-s)+t/2*(A'*lam-s)' ...
    *(A'*lam-s);
% x(abs(A'*lambda)>mu)=0;
% F(lambda,s,x)
disp(1/2*lambda'*lambda+lambda'*b)
y = -lambda;
out.intercept = mean(y+b-A*x);
end