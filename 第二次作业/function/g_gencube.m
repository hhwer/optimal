function [ Whole_g ] = g_gencube( x,n )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明;
Whole_g = cell(n,1);
Whole_g{1} = 2*(x(1)-1);
for i = 2:n
    r = 10*(x(i)-x(i-1)^3);
    Whole_g{i} = [-60*r*x(i-1)^2,20*r]';
end
end
