function [ f,g ] = S303( x )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
r = x.*([1:n]')/2;
t = r.^2;
f = x'*x + r'*r+ t'*t;
if nargout > 1
    g = 2*x+r.*([1:n]')+2*r.^3.*([1:n]');
end
    

end

