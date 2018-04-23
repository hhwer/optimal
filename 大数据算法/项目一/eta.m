function [ out ] = eta( x,rho )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[n,~]=size(x);
out = sign(x).*max(abs(x)-rho,0);
end

