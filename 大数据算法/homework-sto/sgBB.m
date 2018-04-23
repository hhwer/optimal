function [ x1,lossf  ] =  sgBB(  a,b,x0,lambda,alpha1 )
%UNTITLED2 此处显示有关此函数的摘要
%   n为f个数,p为x维数
%   a = matrix(n,p);  数据中的x1,x2,...,xn
%   b = vevtor(n);     数据中的y1,y2,...,yn
%   

[n,p] = size(a);
E = 2*n;
lossf = zeros(E,p);


for e = 1:E
%     lossf(e) = loss(a,b,x0);    %%统计时间花费应该去掉 f 的花费 计算f耗时占据95%
lossf(e,:) = x0;
    s = randperm(n,1);
    ex = exp(-b(s)*x0*a(s,:)');
        if ex < inf
            sigma = ex/(1+ex);
        else
            sigma = 1;
        end
    gradsk = lambda * sign(x0) - b(s)*sigma*a(s,:);
%     disp(norm(gradsk))
    if e == 1
        alpha = alpha1;
    else
        yk = gradsk - gradsk0;
        alpha = (sk*yk')/(yk*yk');
        if isnan(alpha) || alpha == inf
            alpha = alpha1;
        end
    end
    sk = - alpha*gradsk;
    x1 = x0 +sk;
    x0 = x1;
    gradsk0 = gradsk;
end
end

