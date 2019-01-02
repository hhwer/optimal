function [x,out] = l1_subgrad(x0,A,b,mu,opt)
%
%
%
[m,n] = size(A);
epsilon = 1e-6 ;

MAX = 6000;
x=x0;
B = A'*A;
b1 = A'*b;
mu1 = [1e4*mu,1000*mu,100*mu,10*mu,4*mu,2*mu,mu];
out =[];
for mu =mu1
    x = iter(x,B,b1,mu,epsilon,MAX,n);
end
% disp(norm(A*x-b)^2+mu*norm(x,1));
end


function x1 = iter(x1,B,b1,mu_now,epsilon,MAX,n)
g = B*x1-b1+mu_now*sign(x1);
% k = 1;
%   while norm(g,inf) >= epsilon && k <= MAX
for k = 1:MAX
%     t = 2/sqrt(k)/lamda;
    t = 1/sqrt(k)/n;
    x1 = x1-t*g;
    g = B*x1-b1+mu_now*sign(x1);
  end
end
