function [x] = BMR(Q,c,x0)
%
%
%
c = c(:);
alpha = 1;
M = 2;
sigma = 0;
delta = 0.95;
alphaM = 1.5;
alpham = 1e-6;
epsilon = 2e-3;
MAX = 10000;
k = 1;
[~,n] =size(Q); 
n = n/2;
x=[x0;zeros(n,1)];
f=[]; 
f(k)=0.5*(x'*Q*x)+c'*x;
g=Q*x+c;
while norm(P(x-g)-x,inf) >= epsilon && k <= MAX
    if mod(k,1000)==0
        disp(k);
    end
    d = P(x-alpha*g)-x;
    alpha = 1;
    x1 = x+d;
    f(k+1)=0.5*(x1'*Q*x1)+c'*x1;
    if k > M
        F = max(f(k-M:k));
    else
        F = max(f(1:k));
    end
    while f(k+1)>=F+sigma*(d'*g)
        alpha = delta*alpha;
%         disp(alpha);
        x1 = x + alpha*d;
        f(k+1)=0.5*(x1'*Q*x1)+c'*x1;
    end
    s = x1-x;
    g1 = Q*x1+c;
    y = g1-g;
    if s'*y <=0
        alpha = alphaM;
    else
        alpha = max(min(alphaM,(s'*s)/(s'*y)),alpham);
    end
    k = k+1;
    x = x1;
    g = g1;    
end
    function y = P(x)
       for i =1:2*n
           if x(i)<0
               x(i)=0;
           end
       end
       y = x;
    end
            
end