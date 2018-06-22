function [ y,lossf] = scsg( a,b,hatx0,lambda,alpha,K)
%UNTITLED2 此处显示有关此函数的摘要
%   n为f个数,p为x维数
%   a = matrix(n,p);  数据中的x1,x2,...,xn
%   b = vevtor(n);     数据中的y1,y2,...,yn
%   

[p,n] = size(a);
B = floor(0.1*n);
N=B;

E = 10;
lossf = zeros(p,E);

grady = zeros(p,B);
for e = 1:E
    I = randperm(n,B);
    lossf(:,e) = hatx0;
    y = hatx0;
    if K == 1
        sig = lambda * sign(y);
    elseif K == 2
        sig = lambda * 2 * y;
    for i = 1:B
        j = I(i);
        ex = exp(-b(j)*y'*a(:,j));
        grady(:,i) = sig - b(j)*ex/(1+ex)*a(:,j);  %%
    end
    
    g = mean(grady,2);   %%
    x = zeros(p,N);
    x(:,1) = y;
    for k = 1:N-1
        j = randperm(B,1);
        sk = I(j);
        ex = exp(-b(sk)*x(:,k)'*a(:,sk));
        sigma = ex/(1+ex);
        if K == 1
            gradsk = lambda * sign(x(:,k)) - b(sk)*sigma*a(:,sk);
        elseif K == 2
            gradsk = lambda * 2 * x(:,k)- b(sk)*sigma*a(:,sk);
        end
        vk = gradsk - grady(:,j) + g;%%  grady(j) = partia f_{sk} (x0)
        x(:,k+1) = x(:,k) - alpha*vk;
    end
    hatx1 = mean(x,2);
    hatx0 = hatx1;
end
end