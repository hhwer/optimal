function [ Whole_g ] = g_wood( x,n )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
N = n/2 - 1;
Whole_g = cell(N,1);
for i = 1:N
    [~,Whole_g{i}] = wood(x(2*i-1:2*i+2));
end
end

