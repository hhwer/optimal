function [ c ] = grid_Trigonometric( x )
%UNTITLED12 此处显示有关此函数的摘要
%   此处显示详细说明
n = size(x);
n = n(1);
r = zeros(n,1);
for i = 1:n
    r(i) = n + i*(1 - cos(x(i))) - sin(x(i));
    for j = 1:n 
        r(i) = r(i) - cos(x(j));
    end
end
c = zeros(n,1);
for i = 1:n
    for j = 1:n
        if  j ~= i
            c(i) = c(i) + 2*r(j)*sin(x(i));
        else
            c(i) = c(i) + 2*r(i)*(sin(x(i))*(i+1)-cos(x(i)));
        end
    end
end
end
