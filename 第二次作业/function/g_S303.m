function [ Whole_g ] = g_S303( x,n )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

Whole_g = cell(3,1);
Whole_g{1} = 2*x;
r = x.*([1:n]')/2;
Whole_g{2} = r.*([1:n]');
Whole_g{3} = 2*r.^3.*([1:n]');
end


