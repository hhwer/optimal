function [ y,lossf] = svrg( a,b,hatx0,lambda,alpha,m,K)
%UNTITLED2 此处显示有关此函数的摘要
%   n为f个数,p为x维数
%   a = matrix(n,p);  数据中的x1,x2,...,xn
%   b = vevtor(n);     数据中的y1,y2,...,yn
%   

[p,n] = size(a);


E = 10;
lossf = zeros(p,E);
x = zeros(p,m);
grady = zeros(p,n);
for e = 1:E
    lossf(:,e) = hatx0;
    y = hatx0;
    x(:,1) = y;
    if K == 1
        sig = lambda * sign(y);
    elseif K == 2
        sig = lambda * 2 * y;
    end
    for j = 1:n
        ex = exp(-b(j)*y'*a(:,j));
        grady(:,j) = sig - b(j)*ex/(1+ex)*a(:,j);
    end
    g = mean(grady,2);
    for k = 1:m-1
        sk = randperm(n,1);
        ex = exp(-b(sk)*x(:,k)'*a(:,sk));
        
        sigma = ex/(1+ex);
        if K == 1
            gradsk = lambda * sign(x(:,k)) - b(sk)*sigma*a(:,sk);
        elseif K == 2
            gradsk = lambda * 2 * x(:,k) - b(sk)*sigma*a(:,sk);
        end
        vk = gradsk - grady(:,sk) + g;%%
        
        x(:,k+1) = x(:,k) - alpha*vk;
    end
    hatx1 = mean(x,2);
    hatx0 = hatx1;
end

