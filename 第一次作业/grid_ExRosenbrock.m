function [ c ] = grid_ExRosenbrock( x )
%UNTITLED11 此处显示有关此函数的摘要
%   此处显示详细说明
m = size(x);
m = m(1);
n = m/2;
c = zeros(m,1);
for i = 1:n
    x1 = x(2*i-1);
    x2 = x(2*i);
    r1 = 10*(x2-x1^2);
    r2 = 1 - x1;
    c(2*i-1) = -2*r1*20*x1 - 2*r2;
    c(2*i) = 2*r1*10;
end
end
