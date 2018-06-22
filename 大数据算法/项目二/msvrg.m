function [ y,lossf] = msvrg( a,b,hatx0,lambda,alpha,K)
%UNTITLED2 此处显示有关此函数的摘要
%   n为f个数,p为x维数
%   a = matrix(n,p);  数据中的x1,x2,...,xn
%   b = vevtor(n);     数据中的y1,y2,...,yn
%   

[p,n] = size(a);

E = 10;
lossf = zeros(p,E);
grady = zeros(p,n);
for e = 1:E
    lossf(:,e) = hatx0;
    y = hatx0;
    sig = lambda * sign(y);
    for j = 1:n
        ex = exp(-b(j)*y'*a(:,j));
        grady(:,j) = sig - b(j)*ex/(1+ex)*a(:,j);  %%
    end
    g = mean(grady,2);
    N = n/10;
    N = floor(N);
    x = zeros(p,N);
    x(:,1) = y;
    for k = 1:N-1
        gradsk = 0;
        J = randperm(n,10);
        for j = 1:10
            sk = J(j);
            ex = exp(-b(sk)*x(:,k)'*a(:,sk));
            sigma = ex/(1+ex);
            if K == 1
                gradsk = lambda * sign(x(:,k)) - b(sk)*sigma*a(:,sk) - grady(:,sk) + gradsk;
            elseif K == 2
                gradsk = lambda * 2 * x(:,k) - b(sk)*sigma*a(:,sk) - grady(:,sk) + gradsk;
            end
        end
        gradsk = gradsk/10;
        vk = gradsk + g;%%  grady(j) = partia f_{sk} (x0)
        x(:,k+1) = x(:,k) - alpha*vk;
    end
    hatx1 = mean(x,2);
    hatx0 = hatx1;
end
end