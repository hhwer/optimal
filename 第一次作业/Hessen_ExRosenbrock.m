function [ c ] = Hessen_ExRosenbrock( x )
%UNTITLED10 此处显示有关此函数的摘要
%   此处显示详细说明
m = size(x);
m = m(1);
n = m/2;
c = zeros(m,1);
for i = 1:n
    a = 2*i-1;
    b = a+1;
    x1 = x(a);
    x2 = x(b);
    c(a,a) = 1200*x1^2 - 400*x2 + 2;
    c(b,b) = 200;
    c(a,b) = -400*x1;
    c(b,a) = c(a,b);
end
end

