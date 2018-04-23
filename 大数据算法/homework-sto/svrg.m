function [ y,lossf] = svrg( a,b,hatx0,lambda,alpha,m)
%UNTITLED2 此处显示有关此函数的摘要
%   n为f个数,p为x维数
%   a = matrix(n,p);  数据中的x1,x2,...,xn
%   b = vevtor(n);     数据中的y1,y2,...,yn
%   

[n,p] = size(a);

E = 20;
lossf = zeros(E,p);
x = zeros(m,p);
grady = zeros(n,p);
for e = 1:E
    lossf(e,:) = hatx0;
    y = hatx0;
    x(1,:) = y;
    sig = lambda * sign(y);
    for j = 1:n
        ex = exp(-b(j)*y*a(j,:)');
        grady(j,:) = sig - b(j)*ex/(1+ex)*a(j,:);  %%
    end
    
    g = mean(grady);   %%
%     nor = norm(g-sig);
%     disp(nor);
%     if nor < 1e-5
%         return
%     end
    
%     s = randperm(n,m-1);
    for k = 1:m-1
        sk = randperm(n,1);
        
        ex = exp(-b(sk)*x(k,:)*a(sk,:)');
        if ex < inf
            sigma = ex/(1+ex);
        else
            sigma = 1;
        end
   
        
        gradsk = lambda*sign(x(k,:)) - b(sk)*sigma*a(sk,:); 
        vk = gradsk - grady(sk,:) + g;%%
        
        x(k+1,:) = x(k,:) - alpha*vk;
    end
    hatx1 = mean(x);
    
    hatx0 = hatx1;
    
    
end

