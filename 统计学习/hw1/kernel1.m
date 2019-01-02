function [ y ] = kernel1( x, lambda, type )
%UNTITLED 此处显示有关此函数的摘要
%  type = 0 : Epanechnikov
%              1:  Tri-cube
%              2:  Gaussian
% 
if type == 0
    D = @(t)(abs(t)<=1)*3/4.*(1-t.*t);
elseif type == 1
    D = @(t) (abs(t)<=1).*(1-abs(t).^3).^3;
elseif type == 2
    D = @(t) 1/sqrt(2*pi).*exp(-x.^2/2);
end

y = D(x/lambda);
end

