function [ f ] = loss( a,b,x )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
f = 0;
[n,~] = size(a);
for i = 1:n
    sigma = -b(i)*x*a(i,:)';
    ex = exp(sigma);
    if ex < inf
        f = f + log(1+ex);
    else
        f = f + sigma;
    end
end
    f = f/n;
end

