function [ y ] = func_wood( x )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明

x = x(1:4);

 r = [10*(x(2)-x(1)^2);...
    1-x(1);...
    sqrt(90)*(x(4)-x(3)^2);...
    1-x(3);...
    sqrt(10)*(x(2)+x(4)-2);...
    sqrt(10)\(x(2)-x(4))];
y = r'*r;
end

