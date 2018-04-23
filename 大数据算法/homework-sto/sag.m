function [ x1,lossf ] = sag( a,b,x0,lambda,alpha)
%UNTITLED2 此处显示有关此函数的摘要
%   n为f个数,p为x维数
%   a = matrix(n,p);  数据中的x1,x2,...,xn
%   b = vevtor(n);     数据中的y1,y2,...,yn
%   

[n,p] = size(a);
E = n;
lossf = zeros(E,p);

grady = zeros(n,p);   %%recent gradient of each component f
for j = 1:n
    ex = exp(-b(j)*x0*a(j,:)');
    grady(j,:) = lambda * sign(x0) - b(j)*ex/(1+ex)*a(j,:);  %%
end
g = mean(grady);
for e = 1:E
%     lossf(e) = loss(a,b,x0);    %%统计时间花费应该去掉f的花费 计算f耗时占据95%
lossf(e,:) = x0;
    sk = randperm(n,1);
    ex = exp(-b(sk)*x0*a(sk,:)');
        if ex < inf
            sigma = ex/(1+ex);
        else
            sigma = 1;
        end
    gradsk = lambda * sign(x0) - b(sk)*sigma*a(sk,:);
    g = g + (gradsk - grady(sk,:))/n;
    grady(sk,:) = gradsk;
     
%     nor = norm(g-lambda*sign(x0));
%     disp(nor);
%     
%     if nor < 1e-6
%         return
%     end
    
    x1 = x0 - alpha*g;
    x0 = x1;
end
    
end